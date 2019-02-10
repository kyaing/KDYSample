# -*- coding: UTF-8 -*-

import io
import sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf8')

class Cat:
    """ 定义一个cat类 """ 

    def __init__(self, new_name, new_age):
        self.name = new_name
        self.age = new_age

    def __str__(self):
        return "%s is age: %d" % (self.name, self.age)

    def eat(self):
        print("猫在吃鱼")

    def drive(self):
        print("猫在喝水")

    def introduce(self):
        print("%s的年龄是: %d" % (self.name, self.age))

tom = Cat('Tom', 40)
print(tom)

tom.eat()