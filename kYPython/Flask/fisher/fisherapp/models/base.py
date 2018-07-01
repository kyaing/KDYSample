from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Column, SmallInteger

db = SQLAlchemy()

class Base(db.Model):
    __abstract__ = True  # 不让映射成模型

    # create_time = Column('create_time', Integer)
    status = Column(SmallInteger, default=1)

    def set_attrs(self, attrs_dict):
        for key, value in attrs_dict.item():
            if hasattr(self, key) and key != 'id':
                setattr(self, key, value)