# coding: utf-8

def func_arg(arg):
	def func(funcName):
		def func_in():
			print('---func_in, arg = %s ---' % arg)
			funcName()

		return func_in
	return func

# 带有参数的装饰器；
# 1 先执行 func_arg('hello')函数，这个函数返回的结果是func函数的引用
# 2 @func
# 3 再用 @func对test进行装饰 
# 它的作用，主要是在运行时，用以区分不同的功能
@func_arg('hello')
def test():
	print('---test---')

test()