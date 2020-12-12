from sqlalchemy import extract, desc, asc
from sqlalchemy.orm import aliased
from sqlalchemy.sql.functions import count, sum
from datetime import datetime
from banvechuyenbay.models import *


def bao_cao(lua_chon=None, year=None, month=None, quarter=None):
    if lua_chon:
        if lua_chon.lower() == 'year':
            if year:
                ve = Ve.query.filter(extract('year', Ve.ngay_xuat_ve) == int(year))\
                             .add_columns(count(Ve.id).label('tong_ve'),
                                          extract('month', Ve.ngay_xuat_ve).label('month'))\
                             .group_by('month').all()

                month = []
                # data = []
                for v in ve:
                    month.append(v.month)
                    # data.append(v.tong_ve)

                return ve, month

        if lua_chon.lower() == 'quarter':
            if year and quarter:
                ve = Ve.query.filter(extract('year', Ve.ngay_xuat_ve) == int(year),
                                     extract('quarter', Ve.ngay_xuat_ve) == int(quarter)) \
                    .add_columns(count(Ve.id).label('tong_ve'),
                                 extract('month', Ve.ngay_xuat_ve).label('month')).group_by('month').all()

                month = []
                # data = []
                for v in ve:
                    month.append(v.month)
                    # data.append(v.tong_ve)

                return ve, month

        if lua_chon.lower() == 'month':
            if year and month:
                ve = Ve.query.join(ChuyenBay, ChuyenBay.id_chuyen_bay == Ve.id_chuyen_bay)\
                             .filter(extract('year', Ve.ngay_xuat_ve) == year,
                                     extract('month', Ve.ngay_xuat_ve) == month) \
                             .add_columns(count(Ve.id).label('tong_ve'),
                                          ChuyenBay.id_chuyen_bay.label('chuyen_bay')).group_by('chuyen_bay').all()

                chuyen_bay = []
                # data = []
                for v in ve:
                    chuyen_bay.append(v.chuyen_bay)
                    # data.append(v.tong_ve)

                return ve, chuyen_bay


def get_all_chuyen_bay():
    sb1 = aliased(SanBay)
    sb2 = aliased(SanBay)
    sb3 = aliased(SanBay)

    chuyenbay = ChuyenBay.query.join(DuongBay, ChuyenBay.id_duong_bay == DuongBay.id) \
        .join(sb1, DuongBay.san_bay_di) \
        .join(sb2, DuongBay.san_bay_den) \
        .join(MayBay, ChuyenBay.id_may_bay == MayBay.id) \
        .filter(extract('day', ChuyenBay.ngay_khoi_hanh) > datetime.now().day,
                extract('month', ChuyenBay.ngay_khoi_hanh) >= datetime.now().month)\
        .add_columns(ChuyenBay.id_chuyen_bay, sb1.name.label("sanbaydi"),
                     sb2.name.label("sanbayden"),
                     sb1.vi_tri.label("noidi"),
                     sb2.vi_tri.label("noiden"),
                     ChuyenBay.ngay_khoi_hanh,
                     ChuyenBay.id_may_bay,
                     MayBay.name,
                     MayBay.ghe_hang_1,
                     MayBay.ghe_hang_2).order_by(asc(ChuyenBay.ngay_khoi_hanh)).all()

    ghetrong = []
    ghedat = []
    for cb in chuyenbay:
        ghe = Ghe.query.filter(Ghe.id_may_bay == cb.id_may_bay).all()

        gt = 0
        gd = 0
        for g in ghe:
            if g.available == False:
                gd = gd + 1
            else:
                gt = gt + 1
        ghetrong.append(gt)
        ghedat.append(gd)
    return chuyenbay, ghedat, ghetrong


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
                    ChuyenBay.ngay_khoi_hanh.contains(ngay),
                    extract('day', ChuyenBay.ngay_khoi_hanh) > datetime.now().day,
                    extract('month', ChuyenBay.ngay_khoi_hanh) >= datetime.now().month) \
            .add_columns(ChuyenBay.id_chuyen_bay, sb1.name.label("sanbaydi"),
                         sb2.name.label("sanbayden"),
                         sb1.vi_tri.label("noidi"),
                         sb2.vi_tri.label("noiden"),
                         ChuyenBay.ngay_khoi_hanh,
                         ChuyenBay.id_may_bay,
                         MayBay.name,
                         MayBay.ghe_hang_1,
                         MayBay.ghe_hang_2).order_by(asc(ChuyenBay.ngay_khoi_hanh)).all()

        ghetrong = []
        ghedat = []
        for cb in chuyenbay:
            ghe = Ghe.query.filter(Ghe.id_may_bay == cb.id_may_bay).all()

            gt = 0
            gd = 0
            for g in ghe:
                if g.available == False:
                    gd = gd + 1
                else:
                    gt = gt + 1
            ghetrong.append(gt)
            ghedat.append(gd)
        return chuyenbay, ghedat, ghetrong

    else:
        chuyenbay = ChuyenBay.query.join(DuongBay, ChuyenBay.id_duong_bay == DuongBay.id) \
                                .join(sb1, DuongBay.san_bay_di) \
                                .join(sb2, DuongBay.san_bay_den) \
                                .join(MayBay, ChuyenBay.id_may_bay == MayBay.id) \
                                .filter(sb1.vi_tri == noi_di,
                                        sb2.vi_tri == noi_den,
                                        extract('day', ChuyenBay.ngay_khoi_hanh) > datetime.now().day,
                                        extract('month', ChuyenBay.ngay_khoi_hanh) >= datetime.now().month) \
                                .add_columns(ChuyenBay.id_chuyen_bay, sb1.name.label("sanbaydi"),
                                             sb2.name.label("sanbayden"),
                                             sb1.vi_tri.label("noidi"),
                                             sb2.vi_tri.label("noiden"),
                                             ChuyenBay.ngay_khoi_hanh,
                                             ChuyenBay.id_may_bay,
                                             MayBay.name,
                                             MayBay.ghe_hang_1,
                                             MayBay.ghe_hang_2).order_by(asc(ChuyenBay.ngay_khoi_hanh)).all()

        ghetrong = []
        ghedat = []
        for cb in chuyenbay:
            ghe = Ghe.query.filter(Ghe.id_may_bay == cb.id_may_bay).all()

            gt = 0
            gd = 0
            for g in ghe:
                if g.available == False:
                    gd = gd + 1
                else:
                    gt = gt + 1
            ghetrong.append(gt)
            ghedat.append(gd)
        return chuyenbay, ghedat, ghetrong


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
                         MayBay.name.label('may_bay'),
                         Ghe.id,
                         Ghe.name.label('ten_ghe'),
                         LoaiGhe.name.label('hang_ghe'),
                         Ghe.available).all()

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
                         MayBay.name.label('may_bay'),
                         Ghe.id,
                         Ghe.name.label('ten_ghe'),
                         LoaiGhe.name.label('hang_ghe'),
                         Ghe.available).all()

        return chuyenbay, ghe_chuyenbay


def bao_cao_theo_mau(nam=None, thang=None, quy=None):
    if nam:
        chuyenbay = Ve.query.join(Ghe, Ve.id_ghe == Ghe.id)\
            .join(LoaiGhe, LoaiGhe.id == Ghe.id_loai_ghe)\
            .join(ChuyenBay, ChuyenBay.id_chuyen_bay == Ve.id_chuyen_bay)\
            .join(MayBay, MayBay.id == ChuyenBay.id_may_bay)\
            .join(DuongBay, DuongBay.id == ChuyenBay.id_duong_bay)\
            .filter(extract('year', Ve.ngay_xuat_ve) == int(nam))\
            .add_columns(count(ChuyenBay.id_chuyen_bay).label('so_luong')
                        ,extract('month', Ve.ngay_xuat_ve).label('thang')
                        ,sum(DuongBay.khoang_cach * LoaiGhe.don_gia).label('doanh_thu')).group_by('thang').all()
        if thang:
            chuyenbay = Ve.query.join(ChuyenBay, ChuyenBay.id_chuyen_bay == Ve.id_chuyen_bay) \
                .join(Ghe, Ghe.id == Ve.id_ghe)\
                .join(LoaiGhe, LoaiGhe.id == Ghe.id_loai_ghe) \
                .join(MayBay, MayBay.id == ChuyenBay.id_may_bay) \
                .join(DuongBay, DuongBay.id == ChuyenBay.id_duong_bay) \
                .filter(extract('year', Ve.ngay_xuat_ve) == int(nam), extract('month', Ve.ngay_xuat_ve) == int(thang)) \
                .add_columns(ChuyenBay.id_chuyen_bay.label('chuyen_bay'), count(Ve.id).label('so_luong_ve')
                             , sum(DuongBay.khoang_cach * LoaiGhe.don_gia).label('doanh_thu')).group_by('chuyen_bay').all()
            return chuyenbay
        if quy:
            chuyenbay = Ve.query.join(Ghe, Ve.id_ghe == Ghe.id) \
                .join(LoaiGhe, LoaiGhe.id == Ghe.id_loai_ghe) \
                .join(ChuyenBay, ChuyenBay.id_chuyen_bay == Ve.id_chuyen_bay) \
                .join(MayBay, MayBay.id == ChuyenBay.id_may_bay) \
                .join(DuongBay, DuongBay.id == ChuyenBay.id_duong_bay) \
                .filter(extract('year', Ve.ngay_xuat_ve) == int(nam), extract('quarter', Ve.ngay_xuat_ve) == int(quy)) \
                .add_columns(count(ChuyenBay.id_chuyen_bay).label('so_luong')
                             , extract('month', Ve.ngay_xuat_ve).label('thang')
                             , sum(DuongBay.khoang_cach * LoaiGhe.don_gia).label('doanh_thu')).group_by('thang').all()

        return chuyenbay


def reset_ghe():
    chuyen_bay = ChuyenBay.query.filter(extract('day', ChuyenBay.ngay_khoi_hanh) <= datetime.now().day,
                                        extract('month', ChuyenBay.ngay_khoi_hanh) <= datetime.now().month)\
                                .all()
    for cb in chuyen_bay:
        ghe = Ghe.query.filter(Ghe.id_may_bay == cb.id_may_bay).all()
        for g in ghe:
            g.available = True
            db.session.commit()
