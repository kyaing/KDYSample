#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   user.py
@Time    :   2019/03/03 21:43:22
@Author  :   Kyaing 
@Version :   1.0
@Desc    :   None
'''

# here put the import lib
from flask import Blueprint

# blueprint
user = Blueprint('user', __name__)

@user.route('/v1/user/get')   # v1表示版本
def get_user():
    return 'v1 get'