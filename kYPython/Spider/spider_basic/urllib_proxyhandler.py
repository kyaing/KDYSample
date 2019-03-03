import urllib.request

# 代理开关
proxy_switch = True

# 构建一个ProxyHandler处理器，参数是字典类型，包括代理类型和IP端口
proxy_handler = urllib.request.ProxyHandler({"socks": "121.31.150.165"}) 

# 不同于开放代理，私密代理需要账号与密码受权(可以在代理平台上注册)
# auth_proxy_handler = urllib.request.ProxyHandler({"http": "username:password@121.31.150.165:9999"}) 

null_proxy_handler = urllib.request.ProxyHandler({})

if proxy_switch:
    opener = urllib.request.build_opener(proxy_handler)
else:
    opener = urllib.request.build_opener(null_proxy_handler)

# urllib.request.install_opener(opener)
request = urllib.request.Request("http://www.baidu.com/")

# response = urllib.request.urlopen(request)
response = opener.open(request)
print(response.read().decode('utf-8'))

