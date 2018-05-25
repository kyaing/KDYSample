# coding: utf-8

def manual_iter():
    with open('/etc/passwd') as f:
        try: 
            while True:
                line = next(f, None)
                if line is None:
                    break
                print(line)
        except StopIteration:
            pass

'''
实现了类似于 range() 的内置函数功能
'''
def frange(start, stop, increase):
    x = start
    while x < stop:
        yield x    # 使用函数生成器来创建新的迭代模式
        x += increase

# for n in frange(0, 4, 1):  # 生成器用for循环 或 next() 取出元素
#     print(n)

class CountDown():
    def __init__(self, start):
        self.start = start

    # Forward iterator
    def __iter__(self):
        n = self.start
        while n > 0:
            yield n
            n -= 1

    # Reverse iterator 反向迭代
    def __reversed__(self):
        n = 1
        while n < self.start:
            yield n
            n += 1

# for item in reversed(CountDown(30)):
#     print(item)

for item in CountDown(30):
    print(item) 