# coding: utf-8

# multiprocessing 相比于 fork() 跨平台，所以做选 Process
from multiprocessing import Process
import time

def test():
	while True:
		print('---test---')
		time.sleep(1)

p = Process(target=test)
p.start()  # 启动子线程，并执行test()函数，同时主进程会等待Process子进程先结束才会再结束

p.join(2)  # 堵塞，等待实例进程结束，程序不会再往下执行

print('---main---')