# coding: utf-8

from multiprocessing import Process
import time
import os

class ProcessClass(Process):
	def __init__(self, intervale):
		Process.__init__(self)
		self.intervale = intervale

	# 重写了 Process类的 run()方法
	def run(self):
		t_start = time.time()
		time.sleep(self.intervale)
		t_stop = time.time()
		print('(%s)执行结束，用时 %0.2fs' % (os.getpid(), t_stop-t_start))

if __name__ == '__main__':
	print('当前进程：(%s)' % os.getpid())
	t_start = time.time()
	p1 = ProcessClass(2)
	p1.start()
	p1.join()
	t_stop = time.time()
	print('(%s)执行结束，用时 %0.2fs' % (os.getpid(), t_stop-t_start))