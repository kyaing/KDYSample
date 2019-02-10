from multiprocessing import Pool
import os
import random
import time

def worker(num):
    for i in range(5):
        print('---pid=%d---num=%d---' % (os.getpid(), num))
        time.sleep(1)

pool = Pool(3)

for i in range(10):
    print('-----%d-----' % i) 
    pool.apply_async(worker, (i, ))   # 异步执行  
    # pool.apply(worker, (i,))    # 同步执行，阻塞方式

pool.close()  # 关闭进程池，即不能再次添加新任务
pool.join()   # 主进程创建或添加任务后，主进程默认不会等待进程池中的任务执行完后才结束，而是
              # 当主进程的任务做完之后，立即结束；如果没有join()，会导致进程池中的任务不会执行。
