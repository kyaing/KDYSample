# coding: utf-8

from collections import deque
from itertools import dropwhile
from itertools import islice
from itertools import combinations
from itertools import permutations

class LineHistory:
    def __init__(self, lines, histlen=3):
        self.lines = lines
        self.history = deque(maxlen=histlen)

    def __iter__(self):
        for lineno, line in enumerate(self.lines, 1):
            self.history.append((lineno, line))
            yield line

    def clear(self):
        self.history.clear()

with open('/Users/Mac/Desktop/ceshi.txt') as f:
    lines = LineHistory(f)
    for line in lines:
        if 'python' in line:
            for lineno, hline in lines.history:
                print('{}:{}'.format(lineno, hline), '')


'''
itertools.islice() 正好适用于在迭代器和生成器上做切片操作;
迭代器和生成器不能使用标准的切片操作，因为长度预先不知道。
'''
def count(n):
    while True:
        yield n  # yield 语句作为数据的生产者；而 for 循环语句作为数据的消费者
        n += 1

c = count(0)
for x in islice(c, 10, 20):
    print(x)

