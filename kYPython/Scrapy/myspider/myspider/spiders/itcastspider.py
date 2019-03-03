# /usr/bin/ python3
# -*- coding: utf-8 -*-
# @Time    : 2019-02-10 16:05
# @Author  : kyaing
# @File    : itcastspider.py

import scrapy

class ItcastSpider(scrapy.Spider):
    name = "itcast"
    allowed_domains = ["http://www.itcast.cn/"]
    start_url = ["http://www.itcast.cn/channel/teacher.shtml#"]

    def parse(self, response):
        # with open("teacher.html", "w") as f:
        #     f.write(response.body)

        teacher_list = response.xpath('//div[@class="li_txt"]')

        for each in teacher_list:
            name = each.xpath('./h3/text()').extract()
            title = each.xpath('./h4/text()').extract()
            info = each.xpath('./p/text()').extract()

            print(name, title, info)
