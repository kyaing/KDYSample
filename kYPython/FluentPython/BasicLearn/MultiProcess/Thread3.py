from threading import Thread
import time

""" 多线程中使用全局变量 """ 

# 注意线程与进程不同的是，多线程间是可以共享全局变量的
g_num = 100

def work1():
    global g_num 
    for i in range(3):
        g_num += 1
    print('--- in work1, g_num is %d ---' % g_num)

def work2():
    global g_num
    print('--- in work2, g_num is %d ---' % g_num)

print('--- 线程创建之前，g_num is %d ---' % g_num)

t1 = Thread(target=work1)
t1.start()

time.sleep(1)

t2 = Thread(target=work2)
t2.start()



