import sys
import re
import collections

# 多种方式创建字典
a = dict(one=1, two=2, three=3)
b = {'one': 1, 'two': 2, 'three': 3}
c = dict(zip(['one', 'two', 'three'], [1, 2, 3]))
d = dict([('one', 1), ('two', 2), ('three', 3)])
e = dict({'one': 1, 'two': 2, 'three': 3})
print(a == b == c == d == e)

# WORD_RE = re.compile(r'\w+')

# index = collections.defaultdict(list)
# with open(sys.argv[1], encoding='utf-8') as fp:
#     for line_no, line in enumerate(fp, 1):
#         for match in WORD_RE.finditer(line):
#             word = match.group()
#             column_no = match.start() + 1
#             location = (line_no, column_no)
#             index[word].append(location)

# for word in sorted(index, key=str.upper):
#     print(word, index[word])
    
