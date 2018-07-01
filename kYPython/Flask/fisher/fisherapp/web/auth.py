from . import web
from flask import render_template, redirect
from flask import request, flash, url_for
from fisherapp.forms.auth import RegisterForm, LoginForm
from fisherapp.models.base import db
from fisherapp.models.user import User

@web.route('/register', methods=['GET', 'POST'])
def register():
    form = RegisterForm(request.form)
    if request.method == 'POST' and form.validate():
        user = User()
        user.set_attrs(form.data)
        db.session.add(user)
        db.session.commit()
        redirect(url_for('web.login'))
    return render_template('auth/register.html', form=form)

@web.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm(request.form)
    if request.method == 'POST' and form.validate():
        pass
    return render_template('auth/login.html', form=form)


@web.route('/reset/password', methods=['GET', 'POST'])
def forget_password_request():
    pass

@web.route('/reset/password/<token>', methods=['GET', 'POST'])
def forget_password(token):
    pass

@web.route('/change/password', methods=['GET', 'POST'])
def change_password():
    pass

@web.route('/logout')
def logout():
    pass
