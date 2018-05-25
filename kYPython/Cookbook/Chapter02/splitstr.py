# coding: utf-8

import re
import os

line = 'asdf fjdk; afed, fjek,asdf, foo'
l = re.split(r'[;,\s]\s*', line)  # 正则匹配
print(l)

filename = 'spam.txt'
print(filename.endswith('.txt'))  # startswith 和 endswith 匹配

choices = ['http:', 'ftp:']
url = 'http://www.python.org'
print(url.startswith(tuple(choices)))  # 注意参数要是 tuple