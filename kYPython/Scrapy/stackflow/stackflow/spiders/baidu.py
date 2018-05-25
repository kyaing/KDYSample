import scrapy
from scrapy.spiders import CrawlSpider, Rule

# class BaiduSpider(CrawlSpider):
#     name = 'baidu'
#     start_urls = ['http://www.baidu.com']

#     rules = (
#         # 提取匹配 'category.php' (但不匹配 'subsection.php') 的链接并跟进链接(没有callback意味着follow默认为True)
#         Rule(LinkExtractor(allow=('category\.php', ), deny=('subsection\.php', ))),

#         # 提取匹配 'item.php' 的链接并使用spider的parse_item方法进行分析
#         Rule(LinkExtractor(allow=('item\.php', )), callback='parse_item'),
#     )

#     def parse_item(self, response):
#         self.logger.info('Hi, this is an item page! %s', response.url)

#         item = scrapy.Item()
#         item['id'] = response.xpath('//td[@id="item_id"]/text()').re(r'ID: (\d+)')
#         item['name'] = response.xpath('//td[@id="item_name"]/text()').extract()
#         item['description'] = response.xpath('//td[@id="item_description"]/text()').extract()
#         return item