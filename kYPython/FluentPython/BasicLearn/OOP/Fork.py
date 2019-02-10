# coding: utf-8

import os
import time

ret = os.fork()  # 创建子进程，从而实现了多进程，fork执行顺序不确定的
print(ret)

if ret > 0:
	print('---父进程---%d' % os.getpid())
else:
	print('---子进程---%d-%d' % (os.getpid(), os.getppid()))
