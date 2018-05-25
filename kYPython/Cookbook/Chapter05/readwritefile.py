# coding: utf-8

import gzip
import os
import pickle
import json

with open('/Users/Mac/Desktop/ceshi.txt', 'rt') as f:
    data = f.read()
    print(data)

# with gzip.open('somfile.gz', 'rt') as f:
#     text = f.read()

# with gzip.open('somfile.gz', 'wt') as f:
#     f.write(text)  

testpath = '/Users/beazley/Data/data.csv'
print(os.path.dirname(testpath), os.path.basename(testpath))  # 操作文件路径

dirname = os.listdir('/Users/Mac/Documents/')
print(dirname)

data = {
    'name' : 'ACME',
    'shares': 100,
    'price' : 542.23
}
json_str = json.dumps(data)  # obj => json 
data = json.loads(json_str)
print(json_str, data)