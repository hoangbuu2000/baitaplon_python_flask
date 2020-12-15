import os

from sqlalchemy.orm import aliased

from banvechuyenbay import app, login, utils, ad, admin, mail
from flask import render_template, redirect, request, url_for, session
from banvechuyenbay.models import *
from flask_login import login_user, logout_user, current_user
import hashlib
from flask_admin import BaseView
from flask_mail import Message
from datetime import datetime, timedelta


@app.route('/xuatve', methods=['GET', 'POST'])
def xuatve():
    sb1 = aliased(SanBay)
    sb2 = aliased(SanBay)
    phieu_dat_cho = PhieuDatCho.query.join(KhachHang, KhachHang.id == PhieuDatCho.id_khach_hang) \
        .join(Ghe, PhieuDatCho.ghe) \
        .join(LoaiGhe, LoaiGhe.id == Ghe.id_loai_ghe) \
        .join(MayBay, Ghe.id_may_bay == MayBay.id) \
        .join(ChuyenBay, ChuyenBay.id_may_bay == MayBay.id) \
        .join(DuongBay, DuongBay.id == ChuyenBay.id_duong_bay) \
        .join(sb1, DuongBay.san_bay_di) \
        .join(sb2, DuongBay.san_bay_den) \
        .filter(PhieuDatCho.confirm == True) \
        .add_columns(PhieuDatCho.id, KhachHang.name, KhachHang.gioi_tinh,
                     KhachHang.ngay_sinh, KhachHang.Cmnd, KhachHang.dia_chi,
                     KhachHang.sdt, KhachHang.email, Ghe.name.label('ghe'),
                     DuongBay.khoang_cach, LoaiGhe.don_gia.label('giaghe'),
                     LoaiGhe.name.label('hangghe'),
                     ChuyenBay.id_chuyen_bay, MayBay.name.label('maybay'),
                     sb1.vi_tri.label('sanbaydi'), sb2.vi_tri.label('sanbayden')).all()

    if request.method == 'POST':
        phieu_dat_cho = PhieuDatCho.query.filter(PhieuDatCho.confirm == True).all()
        for p in phieu_dat_cho:
            if request.form.get('submit') == 'xuatve' + str(p.id):
                querry = PhieuDatCho.query.join(KhachHang, KhachHang.id == PhieuDatCho.id_khach_hang) \
                    .join(Ghe, PhieuDatCho.ghe) \
                    .join(MayBay, Ghe.id_may_bay == MayBay.id) \
                    .join(ChuyenBay, ChuyenBay.id_may_bay == MayBay.id) \
                    .join(DuongBay, DuongBay.id == ChuyenBay.id_duong_bay) \
                    .join(sb1, DuongBay.san_bay_di) \
                    .join(sb2, DuongBay.san_bay_den) \
                    .filter(PhieuDatCho.id == p.id) \
                    .add_columns(PhieuDatCho.id, Ghe.id.label('ghe'), KhachHang.id.label('khachhang'),
                                 KhachHang.name, ChuyenBay.id_chuyen_bay, MayBay.name.label('maybay'),
                                 sb1.vi_tri.label('sanbaydi'), sb2.vi_tri.label('sanbayden')).first()

                ma_hoa_don = 'H' + str(querry.id) + ' - ' + querry.name
                ma_ve = 'V' + str(querry.id) + ' - ' + querry.name

                hoa_don = HoaDon(id=ma_hoa_don, id_nhan_vien=current_user.id, id_khach_hang=querry.khachhang)
                db.session.add(hoa_don)
                db.session.commit()

                ve = Ve(id=ma_ve, id_chuyen_bay=querry.id_chuyen_bay, id_ghe=querry.ghe, id_hoa_don=hoa_don.id)
                db.session.add(ve)
                db.session.commit()

                # xuất vé và hóa đơn xong sẽ xóa phiếu đặt chỗ đi
                db.session.delete(p)
                db.session.commit()
                return redirect('/xuatve')

    return render_template('xuatve.html', phieu_dat_cho=phieu_dat_cho)


# code xóa nested dict copy trên mạng ^^
def dict_sweep(input_dict, key):
    if isinstance(input_dict, dict):
        return {k: dict_sweep(v, key) for k, v in input_dict.items() if k != key}

    elif isinstance(input_dict, list):
        return [dict_sweep(element, key) for element in input_dict]

    else:
        return input_dict


@app.route('/confirm', methods=['GET', 'POST'])
def confirm():
    sb1 = aliased(SanBay)
    sb2 = aliased(SanBay)
    phieu_dat_cho = PhieuDatCho.query.join(KhachHang, KhachHang.id == PhieuDatCho.id_khach_hang)\
                                     .join(Ghe, PhieuDatCho.ghe)\
                                     .join(LoaiGhe, LoaiGhe.id == Ghe.id_loai_ghe)\
                                     .join(MayBay, Ghe.id_may_bay == MayBay.id)\
                                     .join(ChuyenBay, ChuyenBay.id_may_bay == MayBay.id) \
                                     .join(DuongBay, DuongBay.id == ChuyenBay.id_duong_bay) \
                                     .join(sb1, DuongBay.san_bay_di)\
                                     .join(sb2, DuongBay.san_bay_den)\
                                     .filter(PhieuDatCho.confirm == False)\
                                     .add_columns(PhieuDatCho.id, KhachHang.name, KhachHang.gioi_tinh,
                                                  KhachHang.ngay_sinh, KhachHang.Cmnd, KhachHang.dia_chi,
                                                  KhachHang.sdt, KhachHang.email, Ghe.name.label('ghe'),
                                                  ChuyenBay.id_chuyen_bay, MayBay.name.label('maybay'),
                                                  DuongBay.khoang_cach, LoaiGhe.don_gia.label('giaghe'),
                                                  LoaiGhe.name.label('hangghe'),
                                                  sb1.vi_tri.label('sanbaydi'), sb2.vi_tri.label('sanbayden')).all()

    if request.method == 'POST':
        phieu_dat_cho = PhieuDatCho.query.filter(PhieuDatCho.confirm == False).all()
        for p in phieu_dat_cho:
            if request.form.get('submit') == 'success' + str(p.id):
                p.confirm = True
                db.session.commit()

                # lấy thông tin khách hàng đặt chỗ để gửi mail xác nhận
                querry = PhieuDatCho.query.join(KhachHang, KhachHang.id == PhieuDatCho.id_khach_hang) \
                    .join(Ghe, PhieuDatCho.ghe) \
                    .join(MayBay, Ghe.id_may_bay == MayBay.id) \
                    .join(ChuyenBay, ChuyenBay.id_may_bay == MayBay.id) \
                    .join(DuongBay, DuongBay.id == ChuyenBay.id_duong_bay) \
                    .join(sb1, DuongBay.san_bay_di) \
                    .join(sb2, DuongBay.san_bay_den) \
                    .filter(PhieuDatCho.id == p.id) \
                    .add_columns(KhachHang.email, ChuyenBay.ngay_khoi_hanh, Ghe.name).first()
                msg = Message('ĐẶT VÉ THÀNH CÔNG!', sender=app.config['MAIL_USERNAME'], recipients=[querry.email])
                msg.body = 'Chúng tôi đã xác nhận đơn đặt chỗ (' + querry.name + ') của bạn thành công, vui lòng đến ' \
                           'lấy vé tại công ty đúng lịch hẹn vào ' + \
                           str((querry.ngay_khoi_hanh - timedelta(1)).strftime('%d-%m-%Y, %H:%M'))
                mail.send(msg)
                return redirect('/confirm')

            if request.form.get('submit') == 'fail' + str(p.id):
                # lấy thông tin khách hàng đặt chỗ để gửi mail xác nhận
                querry = PhieuDatCho.query.join(KhachHang, KhachHang.id == PhieuDatCho.id_khach_hang) \
                    .join(Ghe, PhieuDatCho.ghe) \
                    .join(MayBay, Ghe.id_may_bay == MayBay.id) \
                    .join(ChuyenBay, ChuyenBay.id_may_bay == MayBay.id) \
                    .join(DuongBay, DuongBay.id == ChuyenBay.id_duong_bay) \
                    .join(sb1, DuongBay.san_bay_di) \
                    .join(sb2, DuongBay.san_bay_den) \
                    .filter(PhieuDatCho.id == p.id) \
                    .add_columns(KhachHang.email, ChuyenBay.ngay_khoi_hanh, Ghe.name).first()
                msg = Message('ĐẶT VÉ THẤT BẠI!', sender=app.config['MAIL_USERNAME'], recipients=[querry.email])
                msg.body = 'Chúng tôi rất tiếc vì một lý do nào đó mà phiếu đặt chỗ (' + querry.name + \
                           ') của bạn đã không được phê duyệt! '
                mail.send(msg)

                for g in p.ghe:
                    g.available = True
                db.session.delete(p)
                db.session.commit()
                return redirect('/confirm')

    return render_template('ghinhandatve.html', phieu_dat_cho=phieu_dat_cho)


@app.route('/profile', methods=['GET', 'POST'])
def profile():
    message = ""
    try:
        user = NhanVien.query.join(Account, Account.id == NhanVien.id)\
                             .filter(Account.id == current_user.id)\
                             .add_columns(Account.username, Account.password, NhanVien.id, NhanVien.name,
                                          NhanVien.gioi_tinh, NhanVien.ngay_sinh, NhanVien.que_quan,
                                          NhanVien.dien_thoai, NhanVien.dia_chi, NhanVien.avatar).first()
    except:
        return render_template('profile.html')

    if request.method == 'POST':
        id = request.form.get('hidden')
        fullname = request.form.get('fullname')
        username = request.form.get('username')
        password = request.form.get('password')
        old_password = request.form.get('old-password')
        gioi_tinh = request.form.get('gioitinh')
        ngay_sinh = request.form.get('ngaysinh')
        dia_chi = request.form.get('diachi')
        que_quan = request.form.get('quequan')
        dien_thoai = request.form.get('dienthoai')

        if password != old_password:
            password = hashlib.md5(password.encode('utf8')).hexdigest()


        # kiểm tra xem username muốn đổi có ai sử dụng chưa
        acc = Account.query.filter(Account.username == username, Account.id != id).first()
        if acc:
            message = "Username đã tồn tại!"
        else:
            nv = NhanVien.query.get(id)
            acc = Account.query.get(id)

            avatar = request.files['avatar']
            if avatar:
                avatar_path = 'images/%s' % avatar.filename
                avatar.save(os.path.join(app.config['ROOT_PROJECT_PATH'], 'static/', avatar_path))
                nv.avatar = avatar_path

            nv.name = fullname
            nv.gioi_tinh = gioi_tinh
            nv.ngay_sinh = ngay_sinh
            nv.dia_chi = dia_chi
            nv.que_quan = que_quan
            nv.dien_thoai = dien_thoai

            acc.username = username
            acc.password = password

            db.session.commit()

            return redirect('/profile')

    return render_template('profile.html', user=user, message=message)


@app.route('/datve', methods=['GET', 'POST'])
def datve():
    # kiểm tra xem url trước đó là /home hay /home/nv
    khach_hang = ""
    if 'url' in session:
        if session['url'] == '/home':
            khach_hang = 'khach hang'

    if request.method == 'POST':
        # Chon ghe
        data_ghe = request.form.getlist('ghe')
        data_chuyenbay = request.form.get('hidden') #id chuyen bay
        data_duongbay = request.form.get('chuyenbay')
        data_maybay = request.form.get('maybay')

        if data_ghe and data_chuyenbay and data_maybay and data_duongbay:
            session['ghe'] = data_ghe
            session['chuyenbay'] = data_chuyenbay
            session['duongbay'] = data_duongbay
            session['maybay'] = data_maybay

        # Dien thong tin khach hang
        fullname = request.form.get('fullname')
        gioi_tinh = request.form.get('gioi_tinh')
        ngay_sinh = request.form.get('ngay_sinh')
        cmnd = request.form.get('cmnd')
        dia_chi = request.form.get('dia_chi')
        dien_thoai = request.form.get('dien_thoai')
        email = request.form.get('email')

        if fullname and gioi_tinh and ngay_sinh and cmnd and dia_chi and dien_thoai and email:
            kh = KhachHang.query.filter(KhachHang.Cmnd == cmnd).first()
            if kh:
                kh.name = fullname
                kh.gioi_tinh = gioi_tinh
                kh.ngay_sinh = ngay_sinh
                kh.Cmnd = cmnd
                kh.dia_chi = dia_chi
                kh.sdt = dien_thoai
                kh.email = email
                db.session.commit()
            else:
                kh = KhachHang(name=fullname, gioi_tinh=gioi_tinh, ngay_sinh=ngay_sinh, Cmnd=cmnd, dia_chi=dia_chi,
                               sdt=dien_thoai, email=email)
                db.session.add(kh)
                db.session.commit()

            ghe = Ghe.query.join(MayBay, Ghe.id_may_bay == MayBay.id)\
                           .filter(Ghe.name.in_(session['ghe']), MayBay.name == session['maybay']).all()
            for g in ghe:
                phieu_dat_cho = PhieuDatCho(id_khach_hang=kh.id)
                phieu_dat_cho.ghe.append(g)
                db.session.add(phieu_dat_cho)
                db.session.commit()

            # Lấy ghế sau khi khách hàng đã điền thông tin đẻ set ghế đã đặt
            ghedb = Ghe.query.join(MayBay, MayBay.id == Ghe.id_may_bay)\
                             .filter(MayBay.name == session['maybay'], Ghe.name.in_(session['ghe'])).all()
            for g in ghedb:
                g.available = False
                db.session.commit()
                return """
                <script>
                    alert('Vui lòng check mail để đợi thông báo xác nhận đặt vé thành công/thất bại!');
                    window.location = '""" \
                       + session['url'] + """'
                </script>
                       """

        # nhớ kiểm tra ghế thuộc máy bay nào,
        # vẫn còn lỗi đặt ghế chuyến bay này sẽ ảnh hưởng ghế chuyến bay khác
        # Lấy ghế để hiển thị thông tin ghế cho khách hàng xem ở bước điền thông tin khách hàng
        ghe = Ghe.query.join(MayBay, MayBay.id == Ghe.id_may_bay)\
                       .join(LoaiGhe, LoaiGhe.id == Ghe.id_loai_ghe)\
                       .filter(MayBay.name == data_maybay, Ghe.name.in_(data_ghe))\
                       .add_columns(Ghe.name, LoaiGhe.name.label('loai_ghe'), LoaiGhe.don_gia).all()

        chuyen_bay = ChuyenBay.query.filter(ChuyenBay.id_chuyen_bay == data_chuyenbay).first()

        if ghe and chuyen_bay:
            return render_template('datve.html', chuyen_bay=chuyen_bay, ghe=ghe, khach_hang=khach_hang)

    return redirect(session['url'])


class MyView(BaseView):
    def __init__(self, *args, **kwargs):
        self._default_view = True
        super(MyView, self).__init__(*args, **kwargs)
        self.admin = ad


@app.route('/thongke', methods=['GET', 'POST'])
def thongke():
    # nhớ ràng buộc js yêu cầu bắt buộc nhập liệu

    if request.method == 'POST':
        year = request.form.get('year')
        month = request.form.get('month')
        quarter = request.form.get('quarter')
        lua_chon = request.form.get('options')

        ve, chuyen_bay = utils.bao_cao(lua_chon=lua_chon, year=year, month=month, quarter=quarter)

        chuyenbay = utils.bao_cao_theo_mau(nam=year, thang=month, quy=quarter)

        tong_doanh_thu = 0
        data = []
        for cb in chuyenbay:
            tong_doanh_thu = tong_doanh_thu + cb.doanh_thu
            data.append(cb.doanh_thu)

    return MyView().render('admin/thongke.html', chuyenbay=chuyenbay, nam=year, thang=month, quy=quarter,
                                    len=len(chuyenbay), tong_doanh_thu=tong_doanh_thu,
                                    ve=ve, chuyen_bay=chuyen_bay, data=data, lua_chon=lua_chon)


@app.route('/chuyenbay/<int:id>')
def chi_tiet(id):
    chuyenbay, ghe = utils.get_chuyen_bay_id(id)

    # kiểm tra xem url trước đó là /home hay /home/nv
    khach_hang = ""
    if 'url' in session:
        if session['url'] == '/home':
            khach_hang = 'khach hang'

    return render_template('flight-detail.html', chuyenbay=chuyenbay, len=len(chuyenbay),
                           ghe=ghe, count=len(ghe), khach_hang=khach_hang)


@app.route('/chuyenbay', methods=['GET', 'POST'])
def tim_chuyen_bay():
    message = ""
    khach_hang = ""

    # kiểm tra xem url trước đó là /home hay /home/nv
    if 'url' in session:
        if session['url'] == '/home':
            khach_hang = 'khach hang'
    chuyenbay, ghedat, ghetrong = utils.get_all_chuyen_bay()

    if request.method == "POST":
        noi_di = request.form.get("from")
        noi_den = request.form.get("to")
        ngay = request.form.get("date")

        chuyenbay, ghedat, ghetrong = utils.get_chuyen_bay(noi_di, noi_den, ngay=ngay)

        if chuyenbay:
            pass
        else:
            message = "Không có thông tin chuyến bay"

    return render_template('flight.html', message=message, chuyenbay=enumerate(chuyenbay),
                           ghedat=ghedat, ghetrong=ghetrong, khach_hang=khach_hang)


@app.route('/')
def gate():
    return render_template('gate.html')


@app.route('/home')
def index():
    utils.reset_ghe()
    khach_hang = 'khach hang'
    chuyen_bay, ghedat, ghetrong = utils.get_all_chuyen_bay()
    session['url'] = url_for('index')
    return render_template('index.html', chuyen_bay=chuyen_bay, khach_hang=khach_hang)


@app.route('/home/nv', methods=['GET', 'POSt'])
def index1():
    utils.reset_ghe()
    chuyen_bay, ghedat, ghetrong = utils.get_all_chuyen_bay()
    session['url'] = url_for('index1')
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        if password:
            password = hashlib.md5(password.encode('utf8')).hexdigest()
            acc = Account.query.filter(Account.username == username, Account.password == password).first()

            if acc:
                login_user(user=acc)

    return render_template('index.html', chuyen_bay=chuyen_bay)


@app.route('/logout')
def logout():
    user = current_user
    user.authenticated = False
    db.session.add(user)
    db.session.commit()
    logout_user()
    return redirect('/')


# Đây là trang đăng ký thuộc sprint 2
@app.route('/register', methods=['GET', 'POST'])
def register():
    message = None
    id = request.args.get("id")
    fullname = request.args.get("fullname")
    sdt = request.args.get("sdt")

    if request.method == 'POST':
        username = request.form.get("username")
        password = request.form.get("password")
        cf_password = request.form.get("cf_password")
        id = request.form.get("id")
        fullname = request.form.get("fullname")
        sdt = request.form.get("sdt")

        if password != cf_password:
            message = "Mật khẩu không khớp"
        else:
            acc = Account.query.filter(Account.username == username).first()

            if acc:
                message = "Username này đã có người sử dụng"
            else:
                nhan_vien = NhanVien.query.filter(NhanVien.id == id,
                                                  NhanVien.name == fullname,
                                                  NhanVien.dien_thoai == sdt).first()

                password = hashlib.md5(password.encode("utf8")).hexdigest()
                acc = Account(id=nhan_vien.id, username=username, password=password)
                db.session.add(acc)
                db.session.commit()
                return redirect('/')

    return render_template('register.html', message=message, id=id, fullname=fullname, sdt=sdt)


# Đây là trang đăng ký thuộc sprint 2
@app.route('/register1', methods=['GET', 'POST'])
def register1():
    message = None
    if request.method == 'POST':
        id = request.form.get('id')
        fullname = request.form.get('fullname')
        sdt = request.form.get('sdt')
        nv = NhanVien.query.filter(NhanVien.name == fullname,
                                   NhanVien.dien_thoai == sdt, NhanVien.id == id).first()
        if nv:
            if str(nv.user_role) == 'Nhân viên':
                acc = Account.query.join(NhanVien, NhanVien.id == Account.id)\
                                .filter(NhanVien.name == nv.name)\
                                .add_columns(NhanVien.name, Account.username, Account.password).first()
                if not acc:
                    return redirect(url_for('register', id=id, fullname=fullname, sdt=sdt))
                else:
                    message = "Nhân viên này đã có tài khoản và mật khẩu"
            else:
                message = "Quản trị không được phép đăng ký"
        else:
            message = "Không có thông tin nhân viên phù hợp"
    return render_template('register1.html', message=message)


# Trang giao diện của sprint 2
@app.route('/contact')
def contact():
    return render_template('contact.html')


# Trang giao diện của sprint 2
@app.route('/blog')
def blog():
    return render_template('blog.html')


# Trang giao diện của sprint 2
@app.route('/car')
def car():
    return render_template('car.html')


# Trang giao diện của sprint 2
@app.route('/flight')
def flight():
    return render_template('flight.html')


# Trang giao diện của sprint 2
@app.route('/hotel')
def hotel():
    return render_template('hotel.html')


@app.route('/vacation')
def vacation():
    return render_template('vacation.html')


#SPRINT 1
@login.user_loader
def load_user(user_id):
    return Account.query.get(user_id)


'''
    Lưu ý chỉ khi đăng nhập vào user có role là 'Quản trị' thì mới hiển thị các chức năng trang admin
    Đăng nhập vào user có role là 'Nhân viên' chưa xử lý
'''


# Trang đăng nhập, chỉ đăng nhập được khi user có role là quản trị
@app.route('/login-admin', methods=['GET', 'POST'])
def login_admin():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        if password:
            password = str(hashlib.md5(password.encode("utf8")).hexdigest())
            account = Account.query.filter(Account.username == username, Account.password == password).first()
            if account:
                user = NhanVien.query.filter(NhanVien.id == account.id).first()
                if user:
                    if str(user.user_role) == "Quản trị":
                        login_user(user=account)

    return redirect('/admin')


# Khi nộp bài nhớ tắt debug
if __name__ == "__main__":
    app.run(debug=True)
