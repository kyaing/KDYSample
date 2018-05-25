# coding: utf-8

import re

text = 'yeah, but no, but yeah, but no, but yeah'
print(text.replace('yeah', 'yep'))

text = 'Today is 11/27/2012. PyCon starts 3/13/2013.'
print(re.sub(r'(\d+)/(\d+)/(\d+)', r'\3-\1-\2', text))  # re 模块中的 sub做匹配

text = 'UPPER PYTHON, lower python, Mixed Python'
re.findall('python', text, flags=re.IGNORECASE)  # 忽略大小写

s = ' hello   world \n'
s = s.strip()
print(s)
re.sub(r'\s+', '', s)
print(s)

s = 'hello world'
s.center(20, '*')
print(s)