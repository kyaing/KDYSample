# coding: utf-8

"""
改变一个实例的字符串表示，重新定义 __str__(), __repr__()方法
"""
class Pair():
    def __init__(self, x, y):
        self.x = x
        self.y = y
    
    def __str__(self):  # 将实例转换为一个字符串, str() print()
        return 'Pair({0.x!s}, {0.y!s})'.format(self)

    def __repr__(self): # 返回一个实例的代码表示形式, repr()
        return '({0.x!r}, {0.y!r})'.format(self)
        # return Pair(%r, %r)' % (self.x, self.y)'

p = Pair(3, 4)
print(p)  