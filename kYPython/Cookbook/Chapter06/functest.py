# coding: utf-8

# 带有默认参数的函数，默认参数的值应该是不可变的对象，若要传可变，则定义为 None
def spam(a, b=None):  
    if b is None:
        pass

x = 10
a = lambda y, x = x: x + y  # (x = x)，让匿名函数，在定义时捕获到变量的值
x = 20
b = lambda y, x = x: x + y 
print(a(10), b(10))

# 通过使用函数默认值参数形式，lambda函数在定义时就能绑定到值
funcs = [lambda x, n = n: x + n for n in range(5)]
for f in funcs:
    print(f(0))