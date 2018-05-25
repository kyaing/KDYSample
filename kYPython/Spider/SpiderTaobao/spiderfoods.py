# coding : utf-8 

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

browser = webdriver.Chrome()

def search():
    browser.get('https://www.taobao.com/')
    # input = WebDriverWait(browser, 10).until(
    #     EC.presence_of_element_located((By.CSS_SELECTOR, '#q'))
    # )
    # submit = WebDriverWait(browser, 10).until(EC.element_to_be_clickable(By.CSS_SELECTOR, '#J_TSearchForm > div.search-button > button'))
    # input.send_keys('美食')
    # submit.click()

    browser.find_element_by_id("q").send_keys("美食")
    browser.find_element_by_id("q").submit()
    browser.find_element_by_class_name("btn-search tb-bg").click()

def main():
    search()

if __name__ == '__main__':
    main()

