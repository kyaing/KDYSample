# coding: utf-8

import time

def deco(func):
    def wrapper():  # 嵌套函数
        startTime = time.time()
        func()
        endTime = time.time()
        msecs = (endTime - startTime) * 1000
        print("time is %d ms" %msecs)
    return wrapper

@deco
def func():
    print('hello')
    time.sleep(1)
    print('world')

def main():
    f = func
    f()
    print("f.__name__ is",f.__name__)
    
if __name__ == '__main__':
    main()