import heapq
from collections import deque

nums = [1, 8, 2, 23, 10, -10, 0, -32]
heap = list(nums)
heapq.heapify(heap)
print(heap)
print('heap largest:' % heapq.nlargest(3, heap))
print('heap smallest:' % heapq.nsmallest(3, heap)) 

print(heapq.heappop(heap))
print(sorted(nums))
print(sorted(nums)[:3])
print(sorted(nums)[3:])