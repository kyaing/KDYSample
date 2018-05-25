# coding: utf-8

parts = ['Is', 'Chicago', 'Not', 'Chicago?']
print(' '.join(parts))  # join 连接不同的数据序列

a = 'hello'
b = 'python'
print(a + ' ' + b)  # 用 +号 连接少量的字符串

datas = ['ACME', 50, 91.1]
print(','.join(str(d) for d in datas))