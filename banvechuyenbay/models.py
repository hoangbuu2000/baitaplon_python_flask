from banvechuyenbay import db
from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, Time, DateTime, Float, Date
from sqlalchemy.orm import relationship
from datetime import datetime, date
from flask_login import UserMixin


class BaseModel(db.Model):
    __abstract__ = True

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)

    def __str__(self):
        return self.name


class MayBay(BaseModel):
    __tablename__ = "maybay"

    ghe_hang_1 = Column(Integer, default=0, nullable=False)
    ghe_hang_2 = Column(Integer, default=0, nullable=False)
    chuyen_bay = relationship('ChuyenBay', backref='may_bay', lazy=True)


class SanBay(BaseModel):
    __tablename__ = "sanbay"

    vi_tri = Column(String(50), nullable=False)


class DuongBay(db.Model):
    __tablename__ = "duongbay"

    id = Column(Integer, primary_key=True, autoincrement=True)
    id_san_bay_di = Column(Integer, ForeignKey(SanBay.id), nullable=False)
    id_san_bay_den = Column(Integer, ForeignKey(SanBay.id), nullable=False)
    id_san_bay_trung_gian = Column(Integer, ForeignKey(SanBay.id))
    thoi_gian_dung = Column(Time)
    khoang_cach = Column(Integer, nullable=False)
    chuyen_bay = relationship('ChuyenBay', backref='duong_bay', lazy=True)
    san_bay_di = relationship("SanBay", foreign_keys=[id_san_bay_di])
    san_bay_den = relationship("SanBay", foreign_keys=[id_san_bay_den])
    san_bay_trung_gian = relationship("SanBay", foreign_keys=[id_san_bay_trung_gian])

    def __str__(self):
        return self.san_bay_di.vi_tri + " - " + self.san_bay_den.vi_tri


class ChuyenBay(db.Model):
    __tablename__ = "chuyenbay"

    id_chuyen_bay = Column(Integer, primary_key=True, autoincrement=True)
    id_may_bay = Column(Integer, ForeignKey(MayBay.id), primary_key=True, nullable=False)
    id_duong_bay = Column(Integer, ForeignKey(DuongBay.id), primary_key=True, nullable=False)
    ngay_khoi_hanh = Column(DateTime, primary_key=True, default=datetime.now(), nullable=False)
    thoi_gian_bay = Column(Time, nullable=False)
    ve = relationship('Ve', backref="chuyen_bay", lazy=True)

    def __str__(self):
        duong_bay = str(self.duong_bay)
        return "Chuyến bay số %s, từ %s, ngày %s" %(str(self.id_chuyen_bay), duong_bay,
                                                    str(self.ngay_khoi_hanh))


class UserRole(BaseModel):
    __tablename__ = "userrole"

    nhan_vien = relationship('NhanVien', backref='user_role', lazy=True)


class NhanVien(BaseModel):
    __tablename__ = "nhanvien"

    gioi_tinh = Column(String(50), nullable=False)
    ngay_sinh = Column(Date, nullable=False)
    dia_chi = Column(String(50), nullable=False)
    que_quan = Column(String(50), nullable=False)
    dien_thoai = Column(String(10), nullable=False)
    avatar = Column(String(255), default='/static/images/logo.png', nullable=False)
    role = Column(Integer, ForeignKey(UserRole.id), nullable=False)
    don_dat_ve = relationship('DonDatVe', backref="nhan_vien", lazy=True)
    account = relationship('Account', uselist=False, backref='nhan_vien', lazy=True)


class Account(db.Model, UserMixin):
    __tablename__ = "account"

    id = Column(Integer, ForeignKey(NhanVien.id), primary_key=True)
    username = Column(String(50), nullable=False, unique=True)
    password = Column(String(50), nullable=False)
    active = Column(Boolean, default=True)

    def __str__(self):
        return self.username


class KhachHang(BaseModel):
    __tablename__ = "khachhang"

    gioi_tinh = Column(String(50), nullable=False)
    ngay_sinh = Column(Date, nullable=False)
    Cmnd = Column(String(50), nullable=False, unique=True)
    dia_chi = Column(String(50), nullable=False)
    sdt = Column(String(50), nullable=False)
    email = Column(String(50), nullable=False, unique=True)
    don_dat_ve = relationship('DonDatVe', backref="khach_hang", lazy=True)


class DonDatVe(db.Model):
    __tablename__ = "dondatve"

    id_don_dat_ve = Column(Integer, primary_key=True)
    id_khach_hang = Column(Integer, ForeignKey(KhachHang.id), nullable=False)
    id_nhan_vien = Column(Integer, ForeignKey(NhanVien.id), nullable=False)
    ngay_dat_ve = Column(DateTime, default=datetime.now())
    ve = relationship('Ve', backref="don_dat_ve", lazy=True)

    def __str__(self):
        return "Đơn đặt vé số " + str(self.id_don_dat_ve)


class LoaiVe(BaseModel):
    __tablename__ = "loaive"

    don_gia = Column(Float, default=0)
    ve = relationship('Ve', backref="loai_ve", lazy=True)


class Ve(BaseModel):
    __tablename__ = "ve"

    available = Column(Boolean, default=True, nullable=False)
    id_loai_ve = Column(Integer, ForeignKey(LoaiVe.id), nullable=False)
    id_chuyen_bay = Column(Integer, ForeignKey(ChuyenBay.id_chuyen_bay), nullable=False)
    id_don_dat_ve = Column(Integer, ForeignKey(DonDatVe.id_don_dat_ve), nullable=True)


if __name__ == "__main__":
    db.create_all()
