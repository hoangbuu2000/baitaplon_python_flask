from banvechuyenbay import app, admin, login
from flask import render_template, redirect, request
from banvechuyenbay.models import *
from flask_login import login_user
import hashlib


@app.route('/')
def home():
    return render_template('index.html')


@login.user_loader
def load_user(user_id):
    return NhanVien.query.get(user_id)


'''
    Lưu ý chỉ khi đăng nhập vào user có role là 'Quản trị' thì mới hiển thị các chức năng trang admin
    Đăng nhập vào user có role là 'Nhân viên' chưa xử lý
'''
@app.route('/login-admin', methods=['GET', 'POST'])
def login_admin():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        password = str(hashlib.md5(password.encode("utf8")).hexdigest())
        user = NhanVien.query.filter(NhanVien.username == username, NhanVien.password == password).first()

        if user:
            if str(user.user_role) == "Quản trị":
                login_user(user=user)

    return redirect('/admin')


# Khi nộp bài nhớ tắt debug
if __name__ == "__main__":
    app.run(debug=True)