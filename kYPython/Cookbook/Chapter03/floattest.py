# coding: utf-8

from decimal import Decimal

a = 4.2 
b = 2.1
print(a + b)

a = Decimal('4.2') 
b = Decimal('2.1')
print(a + b)

x = 1234.5678
print(format(x, '0.2f'))
print(format(x, 'e'))   # 指数计法

y = 1234
print(bin(y))   # 二进制
print(oct(y))   # 八进制
print(hex(y))   # 十六进制