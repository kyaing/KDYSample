import urllib.request
import urllib.parse 
import re

class Spider(object):
    
    def __init__(self):
        self.page = 2

    def loadPage(self):
        url = "https://www.neihanba.com/dz/list_" + str(self.page) + ".html"
        headers = {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"}
        
        request = urllib.request.Request(url, headers=headers) 
        response = urllib.request.urlopen(request)

        html = response.read()
        pattern = re.compile(b'<div\sclass="f18 mb20">(.*?)</div>', re.S)
        content_list = pattern.findall(html)

        for content in content_list:
            print(content)

    def dealPage():
        pass
    
    def writePage():
        pass

    def startWork():
        pass

if __name__ == "__main__":
    spider = Spider()
    spider.loadPage()