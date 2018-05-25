
def deque(items):
    seen = set()
    for item in items:
        if item not in seen:
            yield item
        seen.add(item)
    
a = [1, 2, 2, 5, 5, 1, 10, 3]
# for i in deque(a):
#     print(i)
print(list(deque(a)))