# coding: utf-8

from collections import OrderedDict

d1 = {}
d1['foo'] = 1
d1['bar'] = 2
d1['grok']= 3
print(d1)

d2 = OrderedDict() # 保证操作的顺序
d2['foo'] = 1
d2['bar'] = 2
d2['grok']= 3
print(d2)

prices = {
    'ACME': 45.23,
    'AAPL': 612.78,
    'IBM': 205.55,
    'HPQ': 37.20,
    'FB': 10.75
}

price = zip(prices.values(), prices.keys())
print(price)
