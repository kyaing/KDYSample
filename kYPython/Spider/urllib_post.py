from urllib import request, parse, urlopen

# 通过抓包工具获取的url
url = ""

headers = []

# 发送到web服务器的表单数据
formdata = []

# 通过urlencode转码
data = parse.urlencode(formdata)

# 如果Request()方法中有data数据，就是POST；没有data数据，就是GET
request = request.Request(url, data=data, headers=headers)

print(urlopen(request).read())