# coding: utf-8

import re

text1 = '11/27/2012'
text2 = 'Nov 27, 2012'

if re.match(r'\d+/\d+/\d+', text1):
    print('Yes')
else:
    print('No')

datepat = re.compile(r'\d+/\d+/\d+')
text = 'Today is 11/27/2012. PyCon starts 3/13/2013.'
print(datepat.findall(text))

m = datepat.match('11/27/2012')
print(m, m.group(0))



