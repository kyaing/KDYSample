# coding: utf-8

def w1(func):
	print('---正在装饰1---')
	def inner():
		print('---正在验证权限1---')
		func()
	return inner

def w2(func):
	print('---正在装饰2---')
	def inner():
		print('---正在验证权限2---')
		func()
	return inner

# 即使没有调用时，装饰器就已经在装饰了
@w1 # f1 = w1(f1)
@w2 # f1 = w2(f2)
def f1():
	print('---f1---')

f1()