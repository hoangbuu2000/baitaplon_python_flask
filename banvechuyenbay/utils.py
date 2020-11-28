from sqlalchemy import extract
from sqlalchemy.orm import aliased
from sqlalchemy.sql.functions import count

from banvechuyenbay.models import *


def bao_cao(lua_chon=None):
    if lua_chon.lower() == 'năm':
        ve = Ve.query.add_columns(count(Ve.id).label('tong_ve'),
                                  extract('year', Ve.ngay_xuat_ve).label('year')).group_by('year').all()

        year = []
        data = []
        for v in ve:
            year.append(v.year)
            data.append(v.tong_ve)

        return ve, year, data

    if lua_chon.lower() == 'quý':
        ve = Ve.query.filter(Ve.ngay_xuat_ve.contains('2020')) \
            .add_columns(count(Ve.id).label('tong_ve'),
                         extract('quarter', Ve.ngay_xuat_ve).label('quarter')).group_by('quarter').all()

        quarter = []
        data = []
        for v in ve:
            quarter.append(v.quarter)
            data.append(v.tong_ve)

        return ve, quarter, data

    if lua_chon.lower() == 'tháng':
        ve = Ve.query.filter(Ve.ngay_xuat_ve.contains('2020')) \
            .add_columns(count(Ve.id).label('tong_ve'),
                         extract('month', Ve.ngay_xuat_ve).label('month')).group_by('month').all()

        month = []
        data = []
        for v in ve:
            month.append(v.month)
            data.append(v.tong_ve)

        return ve, month, data


def get_chuyen_bay(noi_di, noi_den, ngay=None):
    sb1 = aliased(SanBay)
    sb2 = aliased(SanBay)
    sb3 = aliased(SanBay)

    if ngay:
        chuyenbay = ChuyenBay.query.join(DuongBay, ChuyenBay.id_duong_bay == DuongBay.id) \
            .join(sb1, DuongBay.san_bay_di) \
            .join(sb2, DuongBay.san_bay_den) \
            .join(MayBay, ChuyenBay.id_may_bay == MayBay.id) \
            .filter(sb1.vi_tri == noi_di,
                    sb2.vi_tri == noi_den,
                    ChuyenBay.ngay_khoi_hanh.contains(ngay)) \
            .add_columns(ChuyenBay.id_chuyen_bay, sb1.name.label("sanbaydi"),
                         sb2.name.label("sanbayden"),
                         sb1.vi_tri.label("noidi"),
                         sb2.vi_tri.label("noiden"),
                         ChuyenBay.ngay_khoi_hanh,
                         MayBay.name,
                         MayBay.ghe_hang_1,
                         MayBay.ghe_hang_2).all()
        return chuyenbay
    else:
        chuyenbay = ChuyenBay.query.join(DuongBay, ChuyenBay.id_duong_bay == DuongBay.id) \
            .join(sb1, DuongBay.san_bay_di) \
            .join(sb2, DuongBay.san_bay_den) \
            .join(MayBay, ChuyenBay.id_may_bay == MayBay.id) \
            .filter(sb1.vi_tri == noi_di,
                    sb2.vi_tri == noi_den) \
            .add_columns(ChuyenBay.id_chuyen_bay, sb1.name.label("sanbaydi"),
                         sb2.name.label("sanbayden"),
                         sb1.vi_tri.label("noidi"),
                         sb2.vi_tri.label("noiden"),
                         ChuyenBay.ngay_khoi_hanh,
                         MayBay.name,
                         MayBay.ghe_hang_1,
                         MayBay.ghe_hang_2).all()
        return chuyenbay


def get_chuyen_bay_id(id):
    sb1 = aliased(SanBay)
    sb2 = aliased(SanBay)
    sb3 = aliased(SanBay)

    # Lấy chuyến bay từ csdl theo id
    cb = ChuyenBay.query.filter(ChuyenBay.id_chuyen_bay == id).first()
    # Lấy đường bay theo chuyến bay
    dbay = DuongBay.query.filter(DuongBay.id == cb.id_duong_bay).first()

    # Kiểm tra nếu đường bay đó có sân bay trung gian thì sẽ truy vấn theo sân bay trung gian
    if dbay.san_bay_trung_gian:
        chuyenbay = ChuyenBay.query.join(MayBay, MayBay.id == ChuyenBay.id_may_bay) \
            .join(DuongBay, DuongBay.id == ChuyenBay.id_duong_bay) \
            .join(sb1, DuongBay.san_bay_di) \
            .join(sb2, DuongBay.san_bay_den) \
            .join(SanBayTrungGian, SanBayTrungGian.id_duong_bay == DuongBay.id) \
            .join(sb3, sb3.id == SanBayTrungGian.id_san_bay) \
            .filter(ChuyenBay.id_chuyen_bay == id) \
            .add_columns(ChuyenBay.id_chuyen_bay, sb1.name.label("sanbaydi"),
                         sb2.name.label("sanbayden"),
                         sb3.name.label("sanbaytrunggian"),
                         sb1.vi_tri.label("noidi"),
                         sb2.vi_tri.label("noiden"),
                         ChuyenBay.ngay_khoi_hanh,
                         ChuyenBay.thoi_gian_bay,
                         SanBayTrungGian.thoi_gian_dung,
                         MayBay.name,
                         MayBay.ghe_hang_1,
                         MayBay.ghe_hang_2).all()

        ghe_chuyenbay = Ghe.query.join(MayBay, MayBay.id == Ghe.id_may_bay) \
            .join(LoaiGhe, LoaiGhe.id == Ghe.id_loai_ghe) \
            .join(ChuyenBay, ChuyenBay.id_may_bay == MayBay.id) \
            .filter(ChuyenBay.id_chuyen_bay == chuyenbay[0].id_chuyen_bay) \
            .add_columns(ChuyenBay.id_chuyen_bay.label('chuyen_bay'),
                         Ghe.name.label('ten_ghe'),
                         LoaiGhe.name.label('hang_ghe')).all()

        return chuyenbay, ghe_chuyenbay

    # Ngược lại không cần truy vấn theo sân bay trung gian
    else:
        chuyenbay = ChuyenBay.query.join(MayBay, MayBay.id == ChuyenBay.id_may_bay) \
            .join(DuongBay, DuongBay.id == ChuyenBay.id_duong_bay) \
            .join(sb1, DuongBay.san_bay_di) \
            .join(sb2, DuongBay.san_bay_den) \
            .filter(ChuyenBay.id_chuyen_bay == id) \
            .add_columns(ChuyenBay.id_chuyen_bay, sb1.name.label("sanbaydi"),
                         sb2.name.label("sanbayden"),
                         sb1.vi_tri.label("noidi"),
                         sb2.vi_tri.label("noiden"),
                         ChuyenBay.ngay_khoi_hanh,
                         ChuyenBay.thoi_gian_bay,
                         MayBay.name,
                         MayBay.ghe_hang_1,
                         MayBay.ghe_hang_2).all()

        ghe_chuyenbay = Ghe.query.join(MayBay, MayBay.id == Ghe.id_may_bay) \
            .join(LoaiGhe, LoaiGhe.id == Ghe.id_loai_ghe) \
            .join(ChuyenBay, ChuyenBay.id_may_bay == MayBay.id) \
            .filter(ChuyenBay.id_chuyen_bay == chuyenbay[0].id_chuyen_bay) \
            .add_columns(ChuyenBay.id_chuyen_bay.label('chuyen_bay'),
                         Ghe.name.label('ten_ghe'),
                         LoaiGhe.name.label('hang_ghe')).all()

        return chuyenbay, ghe_chuyenbay
