
from multiprocessing import Pool
import os
import random
import time

def worker(num):
	for i in range(10):
		print('---pid-%d---%d' % (os.getpid(), num))
		time.sleep(1)

pool = Pool(3)  # 开辟一块线程池

for i in range(10):
	print('---%d---' % i)
	pool.apply_async(worker, (i, ))

pool.close()
pool.join()