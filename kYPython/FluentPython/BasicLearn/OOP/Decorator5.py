# coding: utf-8

# 定义了一个通用的闭包作为装饰器用
def func(funcName):
	def func_in(*args, **kwargs):
		ret = funcName(*args, **kwargs)
		return ret

	return func_in

@func
def test():
	print('---test---')
	return 'hello'

@func
def test2():
	print('---test2---')

ret = test()
print('test4 return value is: %s' % ret)

test2()