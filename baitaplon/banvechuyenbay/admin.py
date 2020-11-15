from banvechuyenbay import ad, db
from banvechuyenbay.models import *
from flask_admin.contrib.sqla import ModelView
from flask_admin import BaseView, expose
from flask_login import logout_user, current_user
from flask import redirect


class AccessibleView(BaseView):
    def is_accessible(self):
        return current_user.is_authenticated


# Template mẫu để ghi đè các trang list, create của flask-admin
class ModelTemplate(ModelView, AccessibleView):
    list_template = 'admin/list.html'
    create_template = 'admin/create.html'
    edit_template = 'admin/edit.html'
    can_export = True
    create_modal = True
    edit_modal = True


class MayBayModelView(ModelTemplate):
    form_columns = ('name', 'ghe_hang_1', 'ghe_hang_2',)


class DuongBayModelView(ModelTemplate):
    form_columns = ('san_bay_di', 'san_bay_den', 'san_bay_trung_gian', 'thoi_gian_dung', 'khoang_cach',)


class ChuyenBayModelView(ModelTemplate):
    form_columns = ('may_bay', 'duong_bay', 'thoi_gian_bay',)


class SanBayModelView(ModelTemplate):
    form_columns = ('name', 'vi_tri',)


class SanBayDuongBayModelView(ModelTemplate):
    pass


class UserRoleModelView(ModelTemplate):
    form_columns = ('name',)


# Không cho phép hiển thị mật khẩu và tạo nhân viên
class NhanVienModelView(ModelTemplate):
    column_exclude_list = ('password',)
    form_columns = ('name', 'username', 'active', 'user_role',)
    can_create = False


class KhachHangModelView(ModelTemplate):
    form_columns = ('name', 'Cmnd', 'dia_chi', 'sdt', 'email',)


class DonDatVeModelView(ModelTemplate):
    form_columns = ('nhan_vien', 'khach_hang', 'ngay_dat_ve',)


class LoaiVeModelView(ModelTemplate):
    form_columns = ('name', 'don_gia',)


class VeModelView(ModelTemplate):
    form_columns = ('name', 'chuyen_bay', 'loai_ve', 'don_dat_ve',)


# Định nghĩa 1 view mới không liên quan đến các models để hiển thị cách sử dụng cho người dùng
class HelperView(AccessibleView):
    @expose('/')
    def index(self):
        return self.render('admin/helper.html')


class LogoutView(AccessibleView):
    @expose('/')
    def index(self):
        logout_user()
        return redirect('/admin')


# Nhóm các view model liên quan
group1 = "Airline"
group2 = "User"
group3 = "Ticket"

ad.add_view(MayBayModelView(MayBay, db.session, category=group1, name="Máy bay"))
ad.add_view(DuongBayModelView(DuongBay, db.session, category=group1, name="Đường bay"))
ad.add_view(ChuyenBayModelView(ChuyenBay, db.session, category=group1, name="Chuyến bay"))
ad.add_view(SanBayModelView(SanBay, db.session, category=group1, name="Sân bay"))
ad.add_view(SanBayDuongBayModelView(SanBayDuongBay, db.session, category=group1, name="Sân bay _ Đường bay"))
ad.add_view(UserRoleModelView(UserRole, db.session, category=group2, name="Vai trò người dùng"))
ad.add_view(NhanVienModelView(NhanVien, db.session, category=group2, name="Nhân viên"))
ad.add_view(KhachHangModelView(KhachHang, db.session, category=group2, name="Khách hàng"))
ad.add_view(LoaiVeModelView(LoaiVe, db.session, category=group3, name="Loại vé"))
ad.add_view(DonDatVeModelView(DonDatVe, db.session, category=group3, name="Đơn đặt vé"))
ad.add_view(VeModelView(Ve, db.session, category=group3, name="Vé"))
ad.add_view(HelperView(name="Hướng dẫn sử dụng"))
ad.add_view(LogoutView(name="Đăng xuất"))
