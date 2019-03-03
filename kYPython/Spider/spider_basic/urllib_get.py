#coding: utf-8

import urllib.parse
import urllib.request

url = 'http://ww.baidu.com/s'

# url的参数为字典类型
wd = {'wd': '中国'}

re_headers = {"User-Agent": "Mozilla..."}

wd = urllib.parse.urlencode(wd)  # 对url进行编码

full_url = url + '?' + wd

request = urllib.request.Request(full_url, headers=re_headers)

response = urllib.request.urlopen(request)

print(response.read().decode('utf-8'))
