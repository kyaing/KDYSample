class Dog(object):
    def print_self(self):
        print('my name is dog.')

class Xiaotq(Dog):
    def print_self(self):
        print("boss of dog.")
    
# 函数(类的外部，也就不能称为方法)
def introduce(temp):
    temp.print_self()

dog1 = Dog()
dog2 = Xiaotq()

introduce(dog1)
introduce(dog2)