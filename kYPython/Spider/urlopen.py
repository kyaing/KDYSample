import urllib.request

re_headers = {
	"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6)"
}

request = urllib.request.Request('http://www.baidu.com/', headers=re_headers)

response = urllib.request.urlopen(request)

# print(response.getcode())
# print(response.geturl())
# print(response.info())

html = response.read().decode('utf-8')

print(html)