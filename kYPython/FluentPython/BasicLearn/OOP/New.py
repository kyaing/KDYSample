
class Dog(object):
    def __init__(self):
        print('---init method---')

    def __del__(self):
        print('---del method---')
    
    def __str__(self):
        print('---str method---')

    def __new__(cls):  # cls 此时相当于Dog指向的类对象
        print(id(cls))
        print('---new method---')
        return object.__new__(cls)

print(id(Dog))
huahua = Dog()  # 1 调用__new__方法创建对象；2 __init__(创建出的对象的引用)完成初始化；3 返回对象的引用