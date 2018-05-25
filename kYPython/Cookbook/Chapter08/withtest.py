# coding: utf-8

from socket import socket, AF_INET, SOCK_STREAM
from functools import partial
import sys

# 让自己的对象支持上下文管理协议（with）
class LazyConnection:
    def __init__(self, address, family=AF_INET, type=SOCK_STREAM):
        self.address = address
        self.family = family
        self.type = type
        self.sock = None

    def __enter__(self):
        if self.sock is not None:
            raise RuntimeError('Already connected!')
        self.sock = socket(self.family, self.type)
        self.sock.connect(self.address)
        return self.sock

    def __exit__(self, exc_ty, exc_val, tb):
        self.sock.close()
        self.sock = None

conn = LazyConnection(('www.python.org', 80))
# Connection closed
with conn as s:
    # conn.__enter__() executes: connection open
    s.send(b'GET /index.html HTTP/1.0\r\n')
    s.send(b'Host: www.python.org\r\n')
    s.send(b'\r\n')
    resp = b''.join(iter(partial(s.recv, 8192), b''))
    # conn.__exit__() executes: connection closed

class DateTime:
    # __slots__ = ['year', 'month', 'day']  __slots__ 优化了内存
    def __init__(self, year, month, day):
        self.year = year
        self.month = month
        self.day = day    

 d = DateTime((2018,5,16))
 print(sys.getsizeof(d))