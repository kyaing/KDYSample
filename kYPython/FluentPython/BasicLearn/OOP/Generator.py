
# coding: utf-8

a = [x for x in range(10)]  # 列表推导式
b = (x for x in range(10))  # 生成器第一种方式；next(b)来取值，占用内存空间小


# 斐波那切数列
def fib(num):
	print('---start---')
	a, b = 0, 1
	for i in range(num): 
		print('---1---')
		# 生成器第二种方式，yield 所在的函数也就称为生成器
		# 程序执行到 yield 会停止并返回值；当再次调用next()方法，程序会执行 yield后面语句
		yield b   
		print('---2---')
		a, b = b, a + b
		print('---3---')
	print('---stop---')

# 创建了一个生成器对象
a = fib(50)
# print(next(a))
# print(next(a))
# ret = a.__next__()  # next() 等价于 __next__()
# print(ret)

# 生成器依次迭代
for i in a:
	print(i)
