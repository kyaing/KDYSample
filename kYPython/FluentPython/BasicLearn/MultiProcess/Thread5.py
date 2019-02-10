from threading import Thread
import time

""" 多线程中使用全局变量，所引发的问题！ """ 

g_num = 0

def test1():
    global g_num  # global 使用并修改全局变量
    for i in range(1000000):
        g_num += 1
    print('---test1---g_num=%d' % g_num)

def test2():
    global g_num
    for i in range(1000000):
        g_num += 1
    print('---test2---g_num=%d' % g_num)

t1 = Thread(target=test1)
t1.start()

# time.sleep(3)  

t2 = Thread(target=test2)
t2.start()
