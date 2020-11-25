from sqlalchemy import exc

from banvechuyenbay import app, admin, login, db
from flask import render_template, redirect, request, url_for, session, flash
from banvechuyenbay.models import *
from flask_login import login_user
import hashlib


@app.route('/')
def index():
    return render_template('index.html')


# Đây là trang đăng ký thuộc sprint 2
@app.route('/register', methods=['GET', 'POST'])
def register():
    message = None
    fullname = request.args.get("fullname")
    sdt = request.args.get("sdt")

    if request.method == 'POST':
        username = request.form.get("username")
        password = request.form.get("password")
        fullname = request.form.get("fullname")
        sdt = request.form.get("sdt")

        acc = Account.query.filter(Account.username == username).first()

        if acc:
            message = "Username này đã có người sử dụng"
        else:
            nhan_vien = NhanVien.query.filter(NhanVien.name == fullname, NhanVien.dien_thoai == sdt).first()

            password = hashlib.md5(password.encode("utf8")).hexdigest()
            acc = Account(id=nhan_vien.id, username=username, password=password)
            db.session.add(acc)
            db.session.commit()
            return redirect('/')

    return render_template('register.html', message=message, fullname=fullname, sdt=sdt)


# Đây là trang đăng ký thuộc sprint 2
@app.route('/register1', methods=['GET', 'POST'])
def register1():
    message = None
    if request.method == 'POST':
        fullname = request.form.get('fullname')
        sdt = request.form.get('sdt')
        nv = NhanVien.query.filter(NhanVien.name == fullname, NhanVien.dien_thoai == sdt).first()
        if nv:
            if str(nv.user_role) == 'Nhân viên':
                acc = Account.query.join(NhanVien, NhanVien.id == Account.id)\
                                .filter(NhanVien.name == nv.name)\
                                .add_columns(NhanVien.name, Account.username, Account.password).first()
                if not acc:
                    return redirect(url_for('register', fullname=fullname, sdt=sdt))
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
    return render_template('contacts.html')


# Trang giao diện của sprint 2
@app.route('/offer')
def offer():
    return render_template('offers.html')


# Trang giao diện của sprint 2
@app.route('/book')
def book():
    return render_template('book.html')


# Trang giao diện của sprint 2
@app.route('/service')
def service():
    return render_template('services.html')


# Trang giao diện của sprint 2
@app.route('/safety')
def safety():
    return render_template('safety.html')


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
