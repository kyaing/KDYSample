
# Python中一切皆是对象；因此类也是对象，可以在运行时动态创建它们 (一般不这样写)
def choose_class(name):
	if name == 'foo':
		class Foo(object):
			pass
		return Foo
	else:
		class Bar(object):
			pass
		return Bar
	
my_class = choose_class('foo')
print(my_class)
	
	