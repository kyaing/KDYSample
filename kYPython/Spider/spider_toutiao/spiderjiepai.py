#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   spiderjiepai.py
@Time    :   2019/02/28 19:58:46
@Author  :   Kyaing 
@Version :   1.0
@Desc    :   None
'''

# here put the import lib
from urllib.parse import urlencode
from requests.exceptions import RequestException
import requests
import pymongo
import json

def get_page_index(offset, keyword):
    data = {
        'aid': 24,
        'app_name': 'web_search',
        'offset': offset,
        'format': 'json',
        'keyword': keyword,
        'autoload': 'true',
        'count': '20',
        'en_qc': '1',
        'cur_tab': '1',
        'from': 'search_tab',
        'pd': 'synthesis'
    }
    url = 'https://www.toutiao.com/api/search/content/?' + urlencode(data)

    try:
        response = requests.get(url)
        if response.status_code == 200:
            return response.text
        else:
            return None
    except RequestException:
        return None

def parse_page_index(html):
    data = json.loads(html)
    if data and 'data' in data.keys():
        for item in data.get('data'):
            yield item.get('article_url')

def main():
    html = get_page_index(0, '街拍')
    for url in parse_page_index(html):
        print(url)

if __name__ == '__main__':
    main()
    