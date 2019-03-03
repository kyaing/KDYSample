#coding: utf-8

from queue import Queue  # 队列
from lxml import etree   # 解析库
import requests          # 请求处理
import threading         # 线程库
import json              # json处理

class ThreadCrawl(threading.Thread):
    def __init__(self, threadName, pageQueue, dataQueue):
        super(ThreadCrawl, self).__init__()
        self.threadName = threadName
        self.pageQueue = pageQueue
        self.dataQueue = dataQueue
        self.headers = {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6)"}

    def run(self):
        print("启动" + self.threadName)
        while not CRAWL_EXIT:
            try:
                # 如果队列为空，block为False，就弹出一个Queue.empty()异常；block为True，队列会进入阻塞状态，直到有新的数据；
                page = self.pageQueue.get(False)
                url = "https://www.qiushibaike.com/text/page/" + str(page) + "/"
                content = requests.get(url, headers=self.headers)
                self.dataQueue.put(content)

            except:
                pass
        print("结束" + self.threadName)

class ThreadParse(threading.Thread):
    def __init__(self, threadName, dataQueue, fileName):
        super(ThreadParse, self).__init__()
        self.threadName = threadName
        self.dataQueue = dataQueue
        self.fileName = fileName

    def run(self):
        print("启动" + self.threadName)
        while not PARSE_EXIT:
            try:
                html = self.dataQueue.get(False)
                self.parse(html)
            except:
                pass
        print("结束" + self.threadName)

    def parse(self, html):
        html = etree.HTML(html)

        # 返回所有段子的节点位置，它作为根节点
        node_list = html.xpath('//div[contains(@id, "qiushi_tag")]')

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

            with open('duanzi.json', 'a') as f:
                f.write(json.dumps(items, ensure_ascii=False)).encode('utf-8') + "\n"

CRAWL_EXIT = False
PARSE_EXIT = False

def main():
    # 页码的队列，表示有10个页面
    pageQueue = Queue(10)

    for i in range(1, 11):
        pageQueue.put(i)

    # 采集结棍的数据队列，参数为空表示不限制
    dataQueue = Queue()

    fileName = open("duanzi.json", "a")

    # 三个采集线程
    crawlList = ["采集thread1", "采集thread2", "采集thread3"]

    # 存储三个采集线程
    threadCrawl = []

    for threadName in crawlList:
        thread = ThreadCrawl(threadName, pageQueue, dataQueue)
        thread.start()
        threadCrawl.append(thread)   

    # 三个解析线程
    parselList = ["解析thread1", "解析thread2", "解析thread3"]

    # 存储三个解析线程
    threadParse = []

    for threadName in parselList:
        thread = ThreadParse(threadName, dataQueue, fileName)
        thread.start()
        threadParse.append(thread)

    while not pageQueue.empty():
        pass

    global CRAWL_EXIT
    CRAWL_EXIT = True
    print("pageQueue 为空！")

    for thread in threadCrawl:
        thread.join()
        print('1')

if __name__ == "__main__":
    main()