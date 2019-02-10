# coding: utf-8

def func(funcName):
	print('---func---1---')
	def func_in():
		print('---func_in---1---')
		funcName()
		print('---func_in---2---')

	print('---func---2---')
	return func_in

def func2(funcName):
	print('---func2---1---')
	def func_in(*args, **kwargs):	# 可以对不定长参数进行处理
		print('---func2_in---1---')
		funcName(*args, **kwargs)
		print('---func2_in---2---')

	print('---func2---2---')
	return func_in

def func3(funcName):
	print('---func3---1---')
	def func_in():
		print('---func3_in---1---')
		ret = funcName()  # 保存函数的返回值
		print('---func3_in---2---')
		return ret

	print('---func3---2---')
	return func_in

# 1 装饰器对无参数的函数进行装饰
# @func
# def test():
# 	print('---test---')

# 2 装饰器对有参数的函数进行装饰
# @func2
# def test2(a, b):
# 	print('---test2：a = %d, b = %d' % (a, b))

# 3 装饰器对不定长参数的函数进行装饰
# @func2
# def test3(a, b, c):
# 	print('---test3：a = %d, b = %d, c = %d' % (a, b, c))

# 4 装饰器对有返回值的函数进行装饰
@func3
def test4():
	print('---test4---')
	return "hello test4"

# test()
# test2(1, 2)
# test3(1, 2, 3)
# test4()

ret = test4()
print('test4 return value is: %s' % ret)
