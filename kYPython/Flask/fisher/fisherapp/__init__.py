from flask import Flask

def create_app():
    app = Flask(__name__)
    app.config.from_object('fisherapp.secure')  # 引入配置文件的路径 
    app.config.from_object('fisherapp.setting')
    register_blueprint(app)
    return app

def register_blueprint(app):
    from fisherapp.web.book import web
    # from fisherapp.web.user import user
    app.register_blueprint(web)