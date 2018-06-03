from flask import jsonify, request

from helper import is_isbn_or_key
from fisher_book import FisherBook
from . import web

@web.route('/book/search/')
def search():  # 从路由中得到参数
    '''
    q: 普通关键字 isbn
    page 
    '''
    q = request.args['q']
    page = request.args['page']

    isbn_or_key = is_isbn_or_key(q)
    if isbn_or_key == 'isbn':
        result = FisherBook.search_by_isbn(q)
    else:
        result = FisherBook.search_by_keyword(q)
    # return json.dumps(result), 200, {'content-type': 'application/json'}
    # dict 序列化；API（难点在于设计）
    return jsonify(result)