
def test():
	i = 0
	while i < 5:
		temp = yield i	# 注意 yield 整个语句赋值给 temp
		print(temp)
		i += 1

t = test()

print(t.__next__())
print(t.__next__())
print(t.__next__())
print(t.send('hello'))	# send 与__next__()用法类似，只是会把其中的内容整体赋值于 yield i 语句
# print(t.send(None))  # send(None) 相当于第一次执行 next()