//
//  main.swift
//  LeetCode
//
//  Created by Mac on 2018/4/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

import Foundation

print("Hello, LeetCode!")

// 1 两数相加
let twoNum = TwoSum()
print("1_TwoSum = \(twoNum.twoSum([2, 3, 5, 7, 9], 9))")

// 7 反转整数
let reverInt = ReverseInteger()
print("7_ReverseInteger = \(reverInt.reverse(15342369))")

// 9 是否是回文数
let isPalindromeNumber = PalindromeNumber()
print("9_PalindromeNumber = \(isPalindromeNumber.isPalindromeNumber3(-121))")

// 13 罗马数字转整数
let romanToInt = RomanToInteger()
print("13_RomanToInteger = \(romanToInt.romanToInt("DCXXI"))")

// 14 字符串最长前缀
let longestPre = LongestCommonPrefix()
print("14_longestPre = \(longestPre.longestCommonPrefix([]))")

// 20 字符串最长前缀
let validParentheses = ValidParentheses()
print("20_ValidParentheses = \(validParentheses.isValid("{}"))")

// 21 合并两个有序的链表
let mergeLists = MergeSortedLists()
print("21_MergeSortedLists = \(String(describing: mergeLists.mergeTwoLists(nil, nil)))")

