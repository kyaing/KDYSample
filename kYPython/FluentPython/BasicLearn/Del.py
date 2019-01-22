class Dog:
    
    def __del__(self):
        print('--- game over ---')

dog1 = Dog()
dog2 = dog1

# del 内部维护着引用计数，程序结束前进行垃圾回收
del dog1
del dog2
print("================")