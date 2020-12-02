from sqlalchemy import exc, or_, and_, extract
from sqlalchemy.orm import aliased
from sqlalchemy.sql.functions import count
from banvechuyenbay import app, admin, login, db, utils
from flask import render_template, redirect, request, url_for, session, flash
from banvechuyenbay.models import *
from flask_login import login_user
import hashlib

# xem lại
@app.route('/nhap/<string:lua_chon>', defaults={'nam': None, 'thang': None})
@app.route('/nhap/<string:lua_chon>/<string:nam>/<string:thang>')
def nhap(lua_chon, nam, thang):
    ve, time, data = utils.bao_cao(lua_chon=lua_chon)

    if nam and not thang:
        chuyenbay = utils.bao_cao_theo_mau(nam=nam, thang=None)
    if nam and thang:
        chuyenbay = utils.bao_cao_theo_mau(nam=nam, thang=thang)

    tong_doanh_thu = 0
    for cb in chuyenbay:
        tong_doanh_thu = tong_doanh_thu + cb.doanh_thu

    return render_template('nhap.html', chuyenbay=chuyenbay, nam=nam, thang=thang
                           , len=len(chuyenbay), tong_doanh_thu=tong_doanh_thu
                           , ve=ve, time=time, data=data, lua_chon=lua_chon)


@app.route('/chuyenbay/<int:id>')
def chi_tiet(id):
    chuyenbay, ghe = utils.get_chuyen_bay_id(id)
    return render_template('flight-detail.html', chuyenbay=chuyenbay, len=len(chuyenbay),
                           ghe=ghe, count=len(ghe))


@app.route('/chuyenbay', methods=['GET', 'POST'])
def tim_chuyen_bay():
    message = ""
    if request.method == "POST":
        noi_di = request.form.get("from")
        noi_den = request.form.get("to")
        ngay = request.form.get("date")

        chuyenbay = utils.get_chuyen_bay(noi_di, noi_den, ngay=ngay)

        if chuyenbay:
            return render_template('flight.html', chuyenbay=chuyenbay)
        else:
            message = "Không có thông tin chuyến bay"

    return render_template('flight.html', message=message)


@app.route('/')
def index():
    return render_template('index.html')


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


# SPRINT 1
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
