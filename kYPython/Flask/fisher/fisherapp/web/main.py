from . import web

@web.route('/')
def index():
    return 'Hello'

@web.route('/personal')
def personal_center():
    pass
