# -*- coding: utf-8 -*-
import scrapy
from tencent.items import TencentItem

class TencentspiderSpider(scrapy.Spider):
    name = "tencentspider"
    allowed_domains = ["tencent.com"]

    url = "https://hr.tencent.com/position.php?&start="
    offset = 0

    start_urls = [url + str(offset)]

    def parse(self, response):
        for each in response.xpath('//tr[@class="even"] | //tr[@class="odd"]'):
            item = TencentItem()

            item['positionName'] = each.xpath('./td[1]/a/text()').extract()[0]
            item['positionLink'] = each.xpath('./td[1]/a/@href').extract()[0]
            item['positionType'] = each.xpath('./td[2]/text()').extract()[0]
            item['peopleNum'] = each.xpath('./td[3]/text()').extract()[0]
            item['workLocation'] = each.xpath('./td[4]/text()').extract()[0]
            item['publishTime'] = each.xpath('./td[5]/text()').extract()[0]

            # 将请求重新发送给调度器入队列出队列，交给下载器下载
            # yield scrapy.Request(url=url, callback=self.parse)

            # 将数据交给管道文件处理
            yield item

        if self.offset < 1680:
            self.offset += 10

        # 自增处理每页的请求
        yield scrapy.Request(self.url + str(self.offset), callback=self.parse)