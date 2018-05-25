# coding: utf-8

# import scrapy
# from .items import MyItem

# class MySpider(scrapy.Spider):
#     name = 'myspdier'
#     start_urls = (
#         'http://example.com/page1',
#         'http://example.com/page2',
#     )

#     def parse(self, response):
#         # collect `item_urls`
#         for item_url in item_urls:
#             yield scrapy.Request(item_url, callback=self.parse_item)

#     def parse_item(self, response):
#         item = MyItem()
#         # populate `item` fields
#         # and extract item_details_url
#         # 使用 meta 传递item
#         yield scrapy.Request(item_details_url, self.parse_detail, meta={'item': item})  

#     def parse_detail(self, response):
#         item = response.meta['item']
#         # populate more `item` fields
#         return item