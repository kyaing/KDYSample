from sqlalchemy import Column, Integer, String, Boolean, Float
from fisherapp.models.base import Base
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin
from fisherapp import login_manager

class User(UserMixin, Base):
    # __tablename = 'user1'  # 可以修改数据库中对应的表名
    id = Column(Integer, primary_key=True)
    nickname = Column(String(24), nullable=False)
    phone_number = Column(String(18), unique=True) 
    # password = Column(String(128), unique=True, nullable=False) # 实际操作中，还是要加密存储pwd
    _password = Column('password', String(128), nullable=False) # DB中存储的仍然是 password 字段  
    email = Column(String(50), unique=True, nullable=False)
    confirmed = Column(Boolean, default=False)
    beans = Column(Float, default=0)
    send_counter = Column(Integer, default=0)
    receive_counter = Column(Integer, default=0)
    wx_open_id = Column(String(50))
    wx_name = Column(String(32))

    @property
    def password(self):
        return self._password
    
    @password.setter
    def password(self, raw):
        self._password = generate_password_hash(raw)

    def check_password(self, raw):
        return check_password_hash(self._password, raw)

@login_manager.user_loader
def get_user(uid):
    return User.query.get(int(uid))