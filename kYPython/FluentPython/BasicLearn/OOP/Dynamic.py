# coding: utf-8
import types  

class Person(object):
	# 用 __slots__ 限制了动态添加属性，只能调用定义的属性
	# __slots__ = {'name', 'age'} 

	def __init__(self, name, age):
		self.name = name
		self.age = age

	def eat(self):
		print('---eating---')

def run(self):
	print('---running---')

@staticmethod
def test():
	print('---static method---')
		
@classmethod
def test2(cls):
	print('---class method---')

p1 = Person("David", 18)
p1.addr = 'beijing'   # 动态添加属性
print(p1.addr)

p1.eat()

p1.run = types.MethodType(run, p1)  # 动态添加实例方法
p1.run()

Person.test = test  # 动态添加静态方法
Person.test() 

Person.test2 = test2  # 动态添加类方法
Person.test2() 