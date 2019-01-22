from collections import deque 
from asyncio import Queue

dq = deque(range(10), maxlen=10)
print(dq)

dq.rotate(3)
print(dq)

dq.appendleft(-1)
print(dq)

dq.append([11, 22, 33])
print(dq)

dq.extend([11, 22, 33])
print(dq)