
class Dog(object):
    
    __instance = None
    __init_flag = False

    # 创建一个单例，保证创建的对象只创建一次
    def __new__(cls, name):
        if cls.__instance == None:
            cls.__instance = object.__new__(cls)
            return cls.__instance
        else:
            return cls.__instance

    # init方法会完成多次初始化，当然也可以保证只调用一次 
    def __init__(self, name):
        if Dog.__init_flag == False:
            self.name = name
            Dog.__init_flag = True

a = Dog('name dog1')
print(id(a))
print(a.name)

b = Dog('name dog2')
print(id(b))
print(b.name)