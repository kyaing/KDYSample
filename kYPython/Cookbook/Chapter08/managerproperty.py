# coding: utf-8

class Person:
    def __init__(self, first_name):
        self.first_name = first_name
       
    '''
    给某个实例attribute增加除访问与修改之外的其他处理逻辑，比如类型检查或合法性验证，
    定义了三个相关联的方法;
    '''
    @property
    def first_name(self):
        return self._first_name

    @first_name.setter
    def first_name(self, value):
        if not isinstance(value, str):
            raise TypeError('Expected a string!')
        self._first_name = value

    @first_name.deleter
    def first_name(self):
        raise AttributeError("Can't delete attribute")

p = Person('Guido')
print(p.first_name)

    
