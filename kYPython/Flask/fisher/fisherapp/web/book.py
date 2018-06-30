from flask import jsonify, request, render_template, flash

from . import web
from fisherapp.spider.fisher_book import FisherBook
from fisherapp.libs.helper import is_isbn_or_key
from fisherapp.forms.book import SearchForm
from fisherapp.view_models.book import BookViewModel, BookCollection
import json

@web.route('/book/search')
def search():  # 从路由中得到参数
    '''
    q: 普通关键字 isbn
    page 
    '''
    # q = request.args['q']
    # page = request.args['page']
    form = SearchForm(request.args)
    books = BookCollection()

    if form.validate():
        q = form.q.data.strip()
        page = form.page.data

        isbn_or_key = is_isbn_or_key(q)
        fisher_book = FisherBook()
        
        if isbn_or_key == 'isbn':
            fisher_book.search_by_isbn(q)
        else:
            fisher_book.search_by_keyword(q, page)

        books.fill(fisher_book, q)
        # json.dumps(books, default=lambda o: o.__dict__)
        # return jsonify(books.__dict__)
    else:
        # return jsonify(form.errors)
        flash('关键字不符合要求，请重新输入')
    return render_template('search_result.html', books=books)
    
@web.route('/book/<isbn>/detail')
def book_detail(isbn):
    pass

@web.route('/test')
def test():
    r = {
        'name': 'flask',
        'age': 18
    }
    r1 = {

    }

    flash('hello flask', category='error')
    flash('hello python', category='warning')
    return render_template('test.html', data=r, data1=r1)