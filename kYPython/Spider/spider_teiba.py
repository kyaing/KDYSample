#coding: utf-8

import urllib.request
import ssl

""" 抓取百度贴吧数据 """

def loadPage(url, fileName):
	""" 通过url发送请求，获取服务器响应文件 """

	request = urllib.request.Request(url)
	context = ssl._create_unverified_context()
	response = urllib.request.urlopen(request, context=context)
	html = response.read().decode('utf-8')
	writePage(html, fileName)

def writePage(html, fileName):
	""" 将html内容写到本地 """
	with open(fileName, 'w') as f:
		f.write(fileName)

def teibaSpider(url, beginPage, endPage):
	for page in range(beginPage, endPage+1):
		if beginPage == 0:
			pn = 0
		else:
			pn = (page - 1) * 50

		fileName = "第" + str(page) + "页.html"
		fullUrl = url + "&pn=" + str(pn)

		loadPage(fullUrl, fileName)

def main():
	kw = input("请输入贴吧名：")
	beginPage = int(input("请输入起始页："))
	endPage = int(input("请输入结束页："))

	url = "https://tieba.baidu.com/f?"
	key = urllib.parse.urlencode({"kw": kw})
	fullUrl = url + key

	teibaSpider(fullUrl, beginPage, endPage)

if __name__ == '__main__':
	main()