#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   ginger.py
@Time    :   2019/03/03 21:43:42
@Author  :   Kyaing 
@Version :   1.0
@Desc    :   入口函数
'''

# here put the import lib
from app.app import create_app
 
app = create_app()

if __name__ == '__main__':
    app.run(debug=True)