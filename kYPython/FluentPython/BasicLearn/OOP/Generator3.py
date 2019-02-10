# coding: utf-8

''' yield 实现多任务 - 协程 '''

def test1():
	while True:
		print('---1---')
		yield None

def test2():
	while True:
		print('---2---')
		yield None

t1 = test1()
t2 = test2()

i = 5
while i:
	t1.__next__()  # 这里就相当于两个任务来回切换地执行
	t2.__next__()
	i -= 1