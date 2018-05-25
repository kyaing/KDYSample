# coding: utf-8

from collections import defaultdict

strings = ('puppy', 'kitten', 'puppy', 'puppy', 'weasel', 'puppy', 'kitten', 'puppy')
counts = {}

# for kw in strings:
#     counts[kw] += 1  # Python的dict中不存在默认值的说法，keyError!

for kw in strings:
    counts.setdefault(kw, 0)
    counts[kw] += 1
    # counts[kw] = counts.setdefault(kw, 0) + 1

print(counts)
# print(counts['foo'])

dd = defaultdict(int)
print(dd)

dd = defaultdict(list)
dd['a'].append(1)
dd['a'].append(2)
dd['a'].append(4)
dd['b'].append(5)
print(dd)

