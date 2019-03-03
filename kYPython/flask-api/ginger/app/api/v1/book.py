#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   book.py
@Time    :   2019/03/03 21:43:08
@Author  :   Kyaing 
@Version :   1.0
@Desc    :   None
'''

# here put the import lib
from flask import Blueprint

# blueprint
book = Blueprint('book', __name__)

@book.route('/v1/book/get')
def get_book():
    return 'v1 book'