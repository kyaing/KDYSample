//
//  9_PalindromeNumber.swift
//  LeetCode
//
//  Created by Mac on 2018/4/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

import Foundation

class PalindromeNumber {
    func isPalindromeNumber(_ x: Int) -> Bool {
        guard x >= 0 else {
            return false
        }

        var result = 0
        var y = x
        
        while y != 0 {
            result = y % 10 + result * 10
            y /= 10
            
            if result > Int(Int32.max) || result < Int(Int32.min) {
                result = 0
            }
        }
        
        if x == result {
            return true
        }
        
        return false
    }
    
    
    func isPalindromeNumber2(_ x: Int) -> Bool {
        guard x >= 0 else {
            return false
        }
        
        var x = x
        var div = 1
        
        while (x / div >= 10) {
            div = div * 10
        }
        
        while (x > 0) {
            let left = x / div
            let right = x % 10
            
            if (left != right) {
                return false
            }
            
            x = (x % div) / 10
            div = div / 100
        }
        
        return true
    }
    
    func isPalindromeNumber3(_ x: Int) -> Bool {
        let str1 = String(x)
        var str2 = ""
        
        for c in str1 {
            str2 = String(c) + str2
        }
        
        return str1 == str2
    }
}
