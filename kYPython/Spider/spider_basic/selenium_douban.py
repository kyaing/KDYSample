#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   selenium_douban.py
@Time    :   2019/02/09 17:41:12
@Author  :   Kyaing 
@Version :   1.0
@Desc    :   None
'''

# here put the import lib

from selenium import webdriver
from selenium.webdriver.chrome.options import Options

def main():
    chrome_options = Options()
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--disable-gpu')
    driver = webdriver.Chrome(executable_path='./chromedriver', chrome_options=chrome_options)
    driver.get("https://www.baidu.com")
    print(driver.page_source)
    driver.close()

if __name__ == '__main__':
    main()
