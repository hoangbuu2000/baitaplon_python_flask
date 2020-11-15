from banvechuyenbay import db
from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, Time, DateTime, Float
from sqlalchemy.orm import relationship
from datetime import datetime
from flask_login import UserMixin


class BaseModel(db.Model):
    __abstract__ = True

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)

    def __str__(self):
        return self.name


class MayBay(BaseModel):
    __tablename__ = "maybay"

    ghe_hang_1 = Column(Integer, default=0)
    ghe_hang_2 = Column(Integer, default=0)
    chuyen_bay = relationship('ChuyenBay', backref='may_bay', lazy=True)


class DuongBay(db.Model):
    __tablename__ = "duongbay"

    id = Column(Integer, primary_key=True, autoincrement=True)
    san_bay_di = Column(String(50), nullable=False)
    san_bay_den = Column(String(50), nullable=False)
    san_bay_trung_gian = Column(String(50))
    thoi_gian_dung = Column(Time)
    khoang_cach = Column(Integer, nullable=False)
    chuyen_bay = relationship('ChuyenBay', backref='duong_bay', lazy=True)
    san_bay_duong_bay = relationship('SanBayDuongBay', backref='duong_bay', lazy=True)

    def __str__(self):
        return self.san_bay_di + " - " + self.san_bay_den


class ChuyenBay(db.Model):
    __tablename__ = "chuyenbay"

    id_chuyen_bay = Column(Integer, primary_key=True, autoincrement=True)
    id_may_bay = Column(Integer, ForeignKey(MayBay.id), primary_key=True, nullable=False)
    id_duong_bay = Column(Integer, ForeignKey(DuongBay.id), primary_key=True, nullable=False)
    ngay_khoi_hanh = Column(DateTime, primary_key=True, default=datetime.now())
    thoi_gian_bay = Column(Time, nullable=False)
    ve = relationship('Ve', backref="chuyen_bay", lazy=True)

    def __str__(self):
        duong_bay = str(self.duong_bay)
        return duong_bay


class SanBay(BaseModel):
    __tablename__ = "sanbay"

    vi_tri = Column(String(50), nullable=False)
    san_bay_duong_bay = relationship('SanBayDuongBay', backref='san_bay', lazy=True)


class SanBayDuongBay(db.Model):
    __tablename__ = "sanbay_duongbay"

    id_san_bay = Column(Integer, ForeignKey(SanBay.id), primary_key=True, nullable=False)
    id_duong_bay = Column(Integer, ForeignKey(DuongBay.id), primary_key=True, nullable=False)


class UserRole(BaseModel):
    __tablename__ = "userrole"

    nhan_vien = relationship('NhanVien', backref='user_role', lazy=True)


class NhanVien(BaseModel, UserMixin):
    __tablename__ = "nhanvien"

    username = Column(String(50), nullable=False, unique=True)
    password = Column(String(50), nullable=False)
    active = Column(Boolean, default=True)
    role = Column(Integer, ForeignKey(UserRole.id), nullable=False)
    don_dat_ve = relationship('DonDatVe', backref="nhan_vien", lazy=True)


class KhachHang(BaseModel):
    __tablename__ = "khachhang"

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

    id_loai_ve = Column(Integer, ForeignKey(LoaiVe.id), nullable=False)
    id_chuyen_bay = Column(Integer, ForeignKey(ChuyenBay.id_chuyen_bay), nullable=False)
    id_don_dat_ve = Column(Integer, ForeignKey(DonDatVe.id_don_dat_ve), nullable=False)


if __name__ == "__main__":
    db.create_all()
