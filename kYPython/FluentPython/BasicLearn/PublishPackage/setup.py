# Python库提供的一种打包方式
from distutils.core import setup

setup(
    name="message_module",
    version="1.0",
    author="kyaing",
    author_email="kyaing@163.com",
    py_modules=['Message.SendMsg'],
)

# python setup.py build  # 编译
# python setup.py sdist  # 压缩
# python setup.py instll # 安装