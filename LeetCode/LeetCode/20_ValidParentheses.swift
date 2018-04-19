//
//  20_ValidParentheses.swift
//  LeetCode
//
//  Created by Mac on 2018/4/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

import Foundation

class ValidParentheses {
    func isValid(_ strs: String) -> Bool {
        var stack = [Character]()
        
        for c in strs {
            if c == "{" || c == "(" || c == "[" {
                stack.append(c)
            } else if c == "}" {
                guard stack.count != 0 && stack.removeLast() == "{" else {
                    return false
                }
                
            } else if c == ")" {
                guard stack.count != 0 && stack.removeLast() == "(" else {
                    return false
                }
                
            } else if c == "]" {
                guard stack.count != 0 && stack.removeLast() == "[" else {
                    return false
                }
            }
        }
        
        return stack.isEmpty
    }
}
