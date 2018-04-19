//
//  14_LongestCommonPrefix.swift
//  LeetCode
//
//  Created by Mac on 2018/4/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

import Foundation

class LongestCommonPrefix {
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count > 0 else {
            return ""
        }
        
        var res = [Character](strs[0])
        
        for str in strs {
            var strContent = [Character](str)
            
            if res.count > strContent.count {
                res = Array(res[0..<strContent.count])
            }
            
            for i in 0..<res.count {
                if res[i] != strContent[i] {
                    res = Array(res[0..<i])
                    break
                }
            }
        }
        
        return String(res)
    }
}
