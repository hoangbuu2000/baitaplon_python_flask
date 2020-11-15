from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_admin import Admin
from flask_login import LoginManager

app = Flask(__name__)
app.config['SECRET_KEY'] = 'hdjkfhuiy12ui3y12783yhjskbdks'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:123456789@localhost/airlinedb?charset=utf8mb4'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True

db = SQLAlchemy(app=app)
ad = Admin(app=app, name="Bán vé chuyến bay", template_mode="Bootstrap4")
login = LoginManager(app=app)