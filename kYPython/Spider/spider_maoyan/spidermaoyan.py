#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   spidermaoyan.py
@Time    :   2019/02/27 21:30:02
@Author  :   Kyaing 
@Version :   1.0
@Desc    :   None
'''

# here put the import lib
import requests
from requests.exceptions import RequestException
from multiprocessing import Pool
import json
import re

def get_one_page(url):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            return response.text 
        return None
    except RequestException:
        return None

def parse_one_page(html):
    pattern = re.compile('<dd>.*?board-index.*?>(\d+)</i>.*?alt.*?src="(.*?)".*?</a>.*?'
        + 'name.*?title="(.*?)".*?<p.*?star">.*?(.*?)</p>.*?/dd>', re.S)

    items = re.findall(pattern, html)
    for item in items:
        yield {
            'index': item[0],
            'image': item[1],
            'title': item[2],
            'actor': item[3].strip()[3:]
        }

def write_to_file(content):
    with open('result.json', 'a', encoding='utf-8') as f:
        f.write(json.dumps(content, ensure_ascii=False) + '\n')
        f.close()

def main(offset):
    url = 'http://maoyan.com/board/4?offset=' + str(offset)
    html = get_one_page(url)
    for item in parse_one_page(html):
        write_to_file(item)

if __name__ == "__main__":
    pool = Pool()
    pool.map(main, [i * 10 for i in range(10)])