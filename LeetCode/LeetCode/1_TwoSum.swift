//
//  1_TwoSum.swift
//  LeetCode
//
//  Created by Mac on 2018/4/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

import Foundation

class TwoSum {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int: Int]()
        
        for(i, num) in nums.enumerated() {
            if let index = dict[target - num] {
                return [i, index]
            }
            
            dict[num] = i
        }
        
        fatalError("No valid outputs")
    }
}
