import copy

a = [1, 2, 3]
b = a  # 浅拷贝，只是指向了同一块内存，并没有复制内容

print(id(a))
print(id(b))

c = copy.deepcopy(a)  # 深拷贝，复制了同样的内容
print(id(c))

print('-----------')

aa = [1, 2, 3]
bb = [4, 5, 6]

cc = [aa, bb]
dd = cc
print(id(cc), id(dd))

ee = copy.deepcopy(cc)
print(id(aa), id(bb), id(ee))

