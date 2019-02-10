# coding: utf-8

import os
import time

# 父进程
ret = os.fork()  
if ret == 0:
	print('---process-1---')
else:
	print('---process-2---')

# 父子进程
ret = os.fork()  
if ret == 0:
	print('---process-11---')
else:
	print('---process-22---')

# fork 炸弹，不能执行
# while 1:
# 	os.fork()