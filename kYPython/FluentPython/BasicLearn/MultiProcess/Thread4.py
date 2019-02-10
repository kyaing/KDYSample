from threading import Thread
import time

""" 列表作为参数传递给线程，它和全局变量一样也是线程间共享的 """ 

def work1(nums):
    nums.append(44)
    print('---in work1---', nums)

def work2(nums):
    time.sleep(1)
    print('---in work2---', nums)

g_nums = [11, 22, 33]

t1 = Thread(target=work1, args=(g_nums,))
t1.start()

t2 = Thread(target=work2, args=(g_nums,))
t2.start()