from fisherapp import create_app

app = create_app()

# @app.route('/hello')
# def hello():
#     # 基于类的视图函数（即插视图）
#     # status 200, 301, 404
#     # content-type http headers
#     # content-type = text/html
#     # Response
#     headers = {
#         'content-type': 'text/plain',
#         'location': 'http://www.baidu.com'
#     }
#     # response = make_response('<html>Hello, World!</html>', 301)
#     # response.headers = headers
#     # return response
#     # return '<html>Hello, World!</html>', 301, headers
#     return '<html>Hello, World!</html>'

if __name__ == '__main__':
    # 注意参数的用法;
    # 生产环境：nginx + uwsgi
    app.run(host='0.0.0.0', debug=app.config['DEBUG'], port=5000) 
    
