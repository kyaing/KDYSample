
import urllib.request
import urllib.parse
import ssl

# 抓取豆瓣电影剧情排行的数据
url = "https://movie.douban.com/typerank?type_name=%E5%89%A7%E6%83%85&type=11&interval_id=100:90&action="

headers = {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"}

formdata = {
    "start": "0",
    "limit": "20"
}

data = urllib.parse.urlencode(formdata).encode(encoding='UTF8')

request = urllib.request.Request(url, data=data, headers=headers)

# 忽略SSL安全认证
context = ssl._create_unverified_context()

print(urllib.request.urlopen(request, context=context).read().decode('utf-8'))