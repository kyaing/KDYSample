#coding: utf-8

from threading import Thread, Lock
import time

g_num = 0  # 线程对全局变量访问时，一般加锁防止出错

def test1():
	global g_num

	mutex.acquire()  # 上锁
	for i in range(1000000):
		g_num += 1
	print('---test1---g_num=%d' % g_num)
	mutex.release()  # 解锁

def test2():
	global g_num

	mutex.acquire()
	for i in range(1000000):
		g_num += 1
	print('---test2---g_num=%d' % g_num)
	mutex.release()

# 创建互斥锁
mutex = Lock()

t1 = Thread(target=test1)
t1.start()

t2 = Thread(target=test2)
t2.start()