# coding: utf-8
from itertools import compress

mylist = [1, 4, -5, 10, -8, 4, 3, 2]  
l1 = [n for n in mylist if n > 0]   # 列表推导式
l2 = [n for n in mylist if n <= 0]
print(l1, l2)

pos = (n for n in mylist if n > 0)  # generator 
for i in pos:
    print(i)

values = ['1', '2', '-3', '-', '4', 'N/A', '5']
def is_int(val):
    try:
        int(val)
        return True
    except ValueError:  
        return False
ivals = list(filter(is_int, values)) # filter() 高阶函数
print(ivals)

addresses = [
    '5412 N CLARK',
    '5148 N CLARK',
    '5800 E 58TH',
    '2122 N CLARK',
    '5645 N RAVENSWOOD',
    '1060 W ADDISON',
    '4801 N BROADWAY',
    '1039 W GRANVILLE',
]
counts = [ 0, 3, 10, 4, 1, 7, 6, 1]
more5 = [n > 5 for n in counts]
print(more5)
print(list(compress(addresses, more5)))  # compress() 
