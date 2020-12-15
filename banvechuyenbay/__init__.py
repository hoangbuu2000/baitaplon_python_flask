from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_admin import Admin
from flask_login import LoginManager
from flask_mail import Mail

app = Flask(__name__)
app.config['SECRET_KEY'] = 'hdjkfhuiy12ui3y12783yhjskbdks'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:123456789@localhost/airlinedb?charset=utf8mb4'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['ROOT_PROJECT_PATH'] = app.root_path
app.config['MAIL_SERVER']='smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USERNAME'] = '1851050010buu@ou.edu.vn'
app.config['MAIL_PASSWORD'] = '079200008902'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True

mail = Mail(app=app)
db = SQLAlchemy(app=app)
ad = Admin(app=app, name="Bán vé chuyến bay", template_mode="Bootstrap4")
login = LoginManager(app=app)