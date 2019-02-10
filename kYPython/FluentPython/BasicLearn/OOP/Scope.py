# LEGB 规则(局部，闭包，全局，内建的顺序访问)

num = 100
def test():
	num = 200
	def test1():
		num = 300
	return test1

ret = test()
print(ret)