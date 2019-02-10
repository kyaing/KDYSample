import functools

def note(func):
	"""note function"""
	@functools.wraps(func)	# 用以消除装饰器带来的副作用
	def wrapper():
		'''wrapper function'''
		print('note something')
		return func()
	return wrapper
	
@note
def test():
	"""test function"""
	print('--test--')

print(help(test))
