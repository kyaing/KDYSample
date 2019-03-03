import urllib.request

# 构建一个HTTPHandler处理器对象，支持处理HTTP请求，带有的参数debuglevel可用于调试
# http_handler = urllib.request.HTTPHandler()
http_handler = urllib.request.HTTPHandler(debuglevel=1)

# 构建一个自定义的opener，用于发起请求
opener = urllib.request.build_opener(http_handler)

# 构建Request请求
request = urllib.request.Request("http://www.baidu.com/")

response = opener.open(request)

print(response.read())