# coding: utf-8

from lxml import etree
import requests
import json
import re

def getPageNew(html):
    result = {}
    dom = etree.HTML(html)
    new_title = dom.xpath('//tr//td/a/text()')
    new_url = dom.xpath('//tr//td/a/@href')
    result['title'] = new_title[0]
    result['url'] = new_url[0]
    return result

def spiderNews(url):
    res = requests.get(url).text
    '''
    <div class="titleBar" id="travel"><h2>校园</h2>\
        <div class="more">\
        <a href="http://news.163.com/special/0001386F/rank_campus.html">更多</a>
        </div>
    </div>    
    '''

    pages = []
    pageInfo = re.findall(r'<div class="titleBar" id=".*?"><h2>(.*?)</h2><div class="more"><a href="(.*?)">.*?</a></div></div>', res, re.S)
    for title, url in pageInfo:
        pageDict = {}
        res = requests.get(url).content
        newpage = getPageNew(res)
        pageDict['type'] = title
        pageDict['data'] = newpage
        pages.append(pageDict)
    return pages


'''
爬取网易新闻网
'''
if __name__ == '__main__':
    url = 'http://news.163.com/rank/'  
    print(spiderNews(url))