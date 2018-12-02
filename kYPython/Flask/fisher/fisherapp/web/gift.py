from . import web
from flask_login import login_required, current_user
from fisherapp.models.gift import Gift
from fisherapp.models.base import db
from flask import current_app, flash

@web.route('/my/gifts')
@login_required
def my_gifts():
    return 'My Gifts'

@web.route('/gifts/book/<isbn>')
@login_required
def save_to_gifts(isbn):
    if current_user.can_save_to_list(isbn):
        # 事务 与 回滚；涉及到 db.session.commit 时，最好都加上 try-except 回滚
        try:
            gift = Gift()
            gift.isbn = isbn
            gift.uid = current_user.id 
            current_user.beans += current_app.config['BEANS_UPLOAD_ONE_BOOK']
            db.session.add(gift)
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            raise e
    else:
        flash('此书已添加至你的赠送清单或已存在于你的心愿清单，请不要重复添加')

@web.route('/gifts/<gid>/redraw')
def redraw_from_gifts(gid):
    pass
