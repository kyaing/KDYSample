
class Itcast(object):
	def __init__(self, subject1):
		self.subject1 = subject1
		self.subject2 = 'cpp'

	# 属性访问时的拦截器，可以打 log; 注意不要在此方法中 调用类似于 self.xxx的形式
	def __getattribute__(self, obj):   # obj -> 'subject1'
		print('===1 > %s' % obj)
		if obj == 'subject1':
			print('log subject1')
			return 'redirect python'
		else:
			temp = object.__getattribute__(self, obj)
			print('===2 > %s' % str(obj))
			return temp
		
	def show(self):
		print('This is Itcast')

s = Itcast('python')
# print(s.subject1)
# print(s.subject2)

s.show()   # s.show 也会调用 __getattribute__ 方法; obj -> 'show'