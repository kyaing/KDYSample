# coding: utf-8

import re

# http://www.cnblogs.com/chuxiuhong/p/5885073.html
# http://www.cnblogs.com/chuxiuhong/p/5907484.html
# https://www.cnblogs.com/minz/p/5975444.html

# 普通字符：'.' '\' '*' '+' '?' '^' '$' '|' '{}' '[]' '()' 清楚每个字符的用法
# [0-9]   0到9任意之一
# [a-z]   小写字母任意之一
# [A-Z]   大宝字母任意之一
# \d      等同于[0-9]
# \D      等同于[^0-9],匹配非数字
# \w      等同于[a-z0-9A-Z_],匹配大小字母、数字、下划线
# \W      等同于[^a-z0-9A-Z_]

key1 = r"<html><body><h1>hello world<h1></body></html>"
# . （. 字符在正则表达式代表着可以代表任何一个字符（包括它本身） + (+ 的作用是将前面一个字符或一个子表达式重复一遍或者多遍)
p1 = r"<h1>.+<h1>"  
pattern1 = re.compile(p1)
print(pattern1.findall(key1))

key2 = r"afiouwehrfuichuxiuhong@hit.edu.cnaskdjhfiosue"
p2 = r"chuxiuhong@hit\.edu\.cn"  # \. 用到了转义符
pattern2 = re.compile(p2)
print(pattern2.findall(key2))

key3 = r"http://test1.com and https://test2.cn"
p3 = r"https*://"   # * (* 跟在其他符号后面表达可以匹配到它0次或多次)
pattern3 = re.compile(p3)
print(pattern3.findall(key3))

key4 = r"lalala<hTml>..hello.....</Html>heiheihei"
p4 = r"<[Hh][Tt][Mm][Ll]>.+?</[Hh][Tt][Mm][Ll]>"  # [] ([] 代表匹配里面的字符的任意一个)
pattern4 = re.compile(p4)
print(pattern4.findall(key4))

key5 = r"mat cat hat pat"
p5 = r"[^p]at"   # [^] 代表除了内部包含的字符以外的都能匹配
pattern5 = re.compile(p5)
print(pattern5.findall(key5))

key6 = r"chuxiuhong@hit.edu.cn"
p6 = r"@.+?\."  # 注意 ？ 控制了重复的次数为一次
pattern6 = re.compile(p6)
print(pattern6.findall(key6))

key7 = r"saas and sas and saaas"
p7 = r"sa{1,2}s"      # {a, b} 等价于 a <= 匹配次数 <= b, 用于准确控制重复的次数
pattern7 = re.compile(p7)
print(pattern7.findall(key7))
