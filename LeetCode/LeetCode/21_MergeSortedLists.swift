//
//  21_MergeSortedLists.swift
//  LeetCode
//
//  Created by Mac on 2018/4/17.
//  Copyright © 2018年 Mac. All rights reserved.
//

import Foundation

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class List {
    var head: ListNode?
    var tail: ListNode?
    
    // 尾插法
    func appendToTail(_ val: Int) {
        if tail == nil {
            tail = ListNode(val)
            head = tail
        } else {
            tail!.next = ListNode(val)
            tail = tail!.next
        }
    }
    
    // 头插法
    func appendToHead(_ val: Int) {
        if head == nil {
            head = ListNode(val)
            tail = head
        } else {
            let temp = ListNode(val)
            temp.next = head
            head = temp
        }
    }
}

class MergeSortedLists {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        var node = dummy
        
        var l1 = l1
        var l2 = l2
        
        while l1 != nil && l2 != nil {
            if l1!.val < l2!.val {
                node.next = l1
                l1 = l1!.next
            } else {
                node.next = l2
                l2 = l2!.next
            }
            node = node.next!
        }

        node.next = l1 ?? l2
        
        return dummy.next
    }
}
