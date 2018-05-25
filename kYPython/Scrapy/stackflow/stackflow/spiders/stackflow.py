import scrapy

class StackOverflowSpider(scrapy.Spider):
    name = 'stackoverflow'
    start_urls = ['http://stackoverflow.com/questions?sort=votes']

    # def start_requests(self):
    #     return [scrapy.FormRequest("http://www.example.com/login",
    #                                 formdata={'user': 'john', 'pass': 'secret'},
    #                                 callable=self.logged_in)]

    # def logged_in(self, response):
    #     pass

    def parse(self, response):
        for href in response.css('.question-summary h3 a::attr(href)'):
            full_url = response.urljoin(href.extract())
            yield scrapy.Request(full_url, callback=self.parse_question)
        self.logger.info('Parse function called on %s', response.url)

    def parse_question(self, response):
        yield {
            'title': response.css('h1 a::text').extract()[0],
            'votes': response.css('.question .vote-count-post::text').extract()[0],
            'body': response.css('.question .post-text').extract()[0],
            'tags': response.css('.question .post-tag::text').extract(),
            'link': response.url,
        }