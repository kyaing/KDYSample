//
//  ConfigureData.swift
//  FromTable
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ConfigureData: NSObject {
    
    var originalData: NSArray = []
    
    var baseInputDic: NSDictionary!
    
    var extendInputDic: NSDictionary?
    
    override init() {}
    
    // MARK: Public Methods
    
    func start() {
        // 基础字典
        if let dic = JsonData.getInfosWithJson(fileName: "base", jsonKey: "data") {
            baseInputDic = dic as! NSDictionary
        }
        
        // 扩展字典(重载某些字段)
        if let dic = JsonData.getInfosWithJson(fileName: "shandai", jsonKey: "data") {
            extendInputDic = dic as? NSDictionary
        } else {
            extendInputDic = nil
        }
    }
    
    func getOriginalItems() -> NSMutableArray {
        if let array = JsonData.getInfosWithJson(fileName: "shandai", jsonKey: "configure") {
            originalData = array as! NSArray
        }
        
        return getOriginalItems(array: originalData)
    }
    
    func getOriginalItems(array: NSArray) -> NSMutableArray {
    
        var index = 0
        let itemModelArray = NSMutableArray()
        for _ in array {
            let dic = array.object(at: index) as! NSDictionary
            
            let key     = dic.value(forKey: "key")
            let title   = dic.value(forKey: "title")
            let subsDic = dic.value(forKey: "subs")
            
            let tempDic = NSMutableDictionary()
            tempDic.setValue(key, forKey: "key")
            tempDic.setValue(title, forKey: "title")
            
            if let subs = subsDic {
                let item = genOriginalItemsWithArray(subs as! NSArray)
                tempDic.setValue(item, forKey: "subs")
                
                itemModelArray.add(tempDic)
            }
            
            index += 1
        }
        
        return itemModelArray
    }
    
    func genOriginalItemsWithArray(_ array: NSArray) -> NSArray {
        
        var index = 0
        let itemArray = NSMutableArray()
        for _ in array {
            let key = array.object(at: index) as! NSString
            
            var model = ItemModel()
            let baseDic = getBaseDicWithkey(key)
            model = model.mapDicToModel(baseDic)

            itemArray.add(model)
            
            index += 1
        }
        
        return itemArray
    }
    
    func getBaseDicWithkey(_ key: NSString) -> NSDictionary {
        if let dic = extendInputDic {
            return dic.value(forKey: key as String) as! NSDictionary
        }
        
        return baseInputDic.value(forKey: key as String) as! NSDictionary
    }
}

