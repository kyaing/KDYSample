//
//  7_ReverseInteger.swift
//  LeetCode
//
//  Created by Mac on 2018/4/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

import Foundation

class ReverseInteger {
    func reverse(_ x: Int) -> Int {
        var result = 0
        var x = x
        
        while x != 0 {
            result = x % 10 + result * 10
            x /= 10
            
            if result > Int(Int32.max) || result < Int(Int32.min) {
                return 0
            }
        }
        
        return result
    }
}
