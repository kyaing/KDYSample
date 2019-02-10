# coding: utf-8

# https://cuiqingcai.com/2621.html
# https://www.cnblogs.com/gaochsh/p/6757475.html

from lxml import etree

html = """
<!DOCTYPE html>
<html>
    <head lang="en">
    <title>测试</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    </head>
<body>
    <div id="content">
    <ul id="ul">
        li>NO.1</li>
        <li>NO.2</li>
        <li>NO.3</li>
    </ul>
    <ul id="ul2">
    <li>one</li>
    <li>two</li>
    </ul>
    </div>

    <div id="url">
    <a href="http:www.58.com" title="58">58</a>
    <a href="http:www.csdn.net" title="CSDN">CSDN</a>
    </div>
</body>
</html>
"""

# 解析HTML文档为HTML DOM模型
selector = etree.HTML(html)
content = selector.xpath('//div[@id="content"]/ul[@id="ul"]/li/text()')
for i in content:
    print(i)

con = selector.xpath('//a/@title')
for each in con:
    print(each)

con = selector.xpath('/html/body/div/a/@title')
for each in con:
    print(each)

print("************************")

html2 = """
<body>
    <div id="aa">aa</div>
    <div id="ab">ab</div>
    <div id="ac">ac</div>
</body>
"""
selector = etree.HTML(html2)
content = selector.xpath('//div[starts-with(@id, "a")]/text()')  # starts-with方法提取div的id标签属性值开头为a的div标签
for each in content:
    print(each)

print("************************")

html3 = """
 <div id="a">
    left
        <span id="b">
        right
            <ul>
            up
                <li>down</li>
            </ul>
        east
        </span>
        west
    </div>
"""
selector = etree.HTML(html3)
# data = selector.xpath('//div[@id="a"]/text()') 
# for each in data:
#     print(each)
data = selector.xpath('//div[@id="a"]')[0]
info = data.xpath('string(.)')
content = info.replace('\n','').replace(' ','')
for each in info:
    print(each)

