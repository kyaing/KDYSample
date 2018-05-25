# coding: utf-8

from urllib.parse import urlencode
from requests.exceptions import RequestException
from bs4 import BeautifulSoup
import requests
import json
from config import *
import pymongo

client = pymongo.MongoClient(MONGO_URL)
db = client[MONGO_DB]

'''
头条街拍是通过Ajax接口请求调用，注意下查找的位置；
'''
def getPageIndex(offset, keyword):
    data = {
        'offset': offset,
        'format': 'json',
        'keyword': keyword,
        'count': '20',
        'cur_tab': '1'
    }
    url = 'https://www.toutiao.com/search_content/?' + urlencode(data)
    try:
        res = requests.get(url)
        if res.status_code == 200: 
            return res.text
        return None
    except RequestException:    
        print('请求索引页错误')
        return None

def parsePageIndex(html):
    jd = json.loads(html) 
    if jd and 'data' in jd.keys():
        for item in jd.get('data'):
            yield item.get('article_url')

def getPageDetail(url):
    try:
        res = requests.get(url)
        if res.status_code == 200: 
            return res.text
        return None
    except RequestException:    
        print('请求详情页错误', url) 
        return None 

def parsePageDetail(html, url):
    soup = BeautifulSoup(html, 'lxml')       
    title = soup.select('title')[0].text
    print(title)
    return {
            'title':'', 
            'url': url,
            'images': ''
        }

def saveToMongo(result):
    if db[MONGO_TABLE].insert(result):
        print('存储到MongoDB成功', result)
        return True
    return False

def main():
    html = getPageIndex(0, '街拍')
    for url in parsePageIndex(html):
        html = getPageDetail(url)
        if html:
            result = parsePageDetail(html, url)
            saveToMongo(result)

if __name__ == '__main__':
    main()