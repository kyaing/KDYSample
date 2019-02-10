import urllib.request
import urllib.parse
from http import cookiejar

# 构建cookeiJar()对象，用来保存cookie
cookie = cookiejar.CookieJar()

# HTTPCookieProcessor构建处理器对象，用来处理cookie
cookie_handler = urllib.request.HTTPCookieProcessor(cookie)

opener = urllib.request.build_opener(cookie_handler)

# 添加报文头参数
opener.addheaders = [("User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6")]

url = "http://www.renren.com/PLogin.do"

data = {"email" : "562352353@qq.com", "password":"chen562352353"}

data = urllib.parse.urlencode(data).encode("utf-8")

# 第一次POST请求，成功之后保存cookie
request = urllib.request.Request(url, data=data)

response = opener.open(request)

print(response.read().decode('utf-8'))

# 第二次GET请求，使用之前保存下来的cookie
profile_response = opener.open("http://www.renren.com/882182119/profile")

print(profile_response.read().decode('utf-8'))
