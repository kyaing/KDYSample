'''
secure.py的配置文件，放些机密信息的配置，一般不要上传到git
'''

# 注意所有的配置参数都要大写！
DEBUG = True

# 注意数据库的配置名称不能写错，cymysql是驱动器，注意数据库的连接
SQLALCHEMY_DATABASE_URI = 'mysql+cymysql://root@localhost:3306/fisher'
