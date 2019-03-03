import urllib.request
from lxml import etree
import json
import ssl

url = "https://www.qiushibaike.com/text/page/2/.html"

headers = {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6)"}

request = urllib.request.Request(url, headers=headers)

context = ssl._create_unverified_context()

html = urllib.request.urlopen(request, context=context).read()

text = etree.HTML(html)

# 返回所有段子的节点位置，它作为根节点
node_list = text.xpath('//div[contains(@id, "qiushi_tag")]')

items = {}

for node in node_list:
    username = node.xpath('./div/a/')

    image = node.xpath('.//div[@class="thumb"]//@src')

    content = node.xpath('.//div[@class="content]/span').text

    zan = node.xpath('.//i').text

    commetns = node.xpath('.//i').text

    items = {
        'username': username,
        'image': image,
        'content': content,
        'zan': zan,
        'commetns': commetns,
    }

    with open('qieshi.json', 'a') as f:
        f.write(json.dumps(items, ensure_ascii=False)).encode('utf-8') + "\n"