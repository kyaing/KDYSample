# coding: utf-8

from itertools import dropwhile
from itertools import islice
from itertools import combinations
from itertools import permutations
from itertools import zip_longest
from itertools import chain
from collections import Iterable

'''
itertools.dropwhile() 
它会返回一个迭代器对象，丢弃原有序列中直到函数返回 Flase之前的所有元素，然后返回后面所有元素
'''
with open('/etc/passwd') as f:
    for line in dropwhile(lambda line: line.startswith('#'), f):
        print(line, '')

items = ['a', 'b', 'c']
for x in permutations(items):
    print('permutations: {}'.format(x))
for x in combinations(items, 2):
    print('combinations: {}'.format(x))

# enumerate 内置函数迭代同时，可以跟踪索引，(index, value)
for index, value in enumerate(items):
    print(index, value)

data = [(1, 2), (2, 3), (3, 4), (4, 5)]
for n, (x, y) in enumerate(data):
    print(n, (x, y))

for x in zip('ABCD', 'xy'):  # zip(a, b) 会生成一个可返回元组 (x, y) 的迭代器，取决于短的列表
    print('zip: {}'.format(x))
for x in zip_longest('ABCD', 'xy', fillvalue='-'):  
    print('zip_longest: {}'.format(x))
    
a = [1, 2, 3, 4]
b = ['x', 'y', 'z']
c = [(1, 2), (2, 3)]
print(a+b+c)  # a+b会创建一个新的列表
for x in chain(a, b, c):  # chain 接受一个或多个可迭代对象作为输入参数
    print(x)

items = [1, 2, [3, 4, [5, 6], 7], 8]  # 嵌套的序列，如何展开
def flatten(items, ignore_types=(str, bytes)):
    for x in items:
        if isinstance(x, Iterable) and not isinstance(x, ignore_types):
            yield from flatten(x)   # yield from 递归生成器
        else:
            yield x
for x in flatten(items):
    print(x)

