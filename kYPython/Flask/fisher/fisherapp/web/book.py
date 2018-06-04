from flask import jsonify, request

from . import web
from fisherapp.spider.fisher_book import FisherBook
from fisherapp.libs.httper import is_isbn_or_key
from fisherapp.forms.book import SearchForm

@web.route('/book/search')
def search():  # 从路由中得到参数
    '''
    q: 普通关键字 isbn
    page 
    '''
    # q = request.args['q']
    # page = request.args['page']
    form = SearchForm(request.args)

    if form.validate():
        q = form.q.data.strip()
        page = form.page.data

        isbn_or_key = is_isbn_or_key(q)
        if isbn_or_key == 'isbn':
            result = FisherBook.search_by_isbn(q)
        else:
            result = FisherBook.search_by_keyword(q, page)
        # return json.dumps(result), 200, {'content-type': 'application/json'}
        # dict 序列化；API（难点在于设计）
        return jsonify(result)
    else:
        return jsonify({'msg': '参数校验失败'})
    