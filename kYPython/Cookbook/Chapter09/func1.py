
import time
from functools import wraps

def timethis(func):
    '''
    Decorator that reports the execution time.
    '''
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)  # 定义了接受任意参数的函数
        end = time.time()
        print(func.__name__, end-start)
        #return result
    return wrapper

@timethis   
def countdown(n):   # 定义了一个装饰器函数来修饰 countdown()
    '''
    Count down
    '''
    while n > 0:
        n -= 1 

countdown(10000)