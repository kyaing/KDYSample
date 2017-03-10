//
//  ItemModel.swift
//  FromTable
//
//  Created by mac on 17/3/10.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

enum FormItemType {
    case cash
    case month
    case text
    case image
    case city
    case telphone
}

class ItemModel: NSObject {
    
    var key: NSString?
    var name: NSString?
    var type: FormItemType?
    var required: Bool?
    var tip1: NSString?
    var tip2: NSString?
    var tip3: NSString?
    
    func mapDicToModel(_ dic: NSDictionary) -> ItemModel {
        let model = ItemModel()
        
        model.key  = dic.value(forKey: "key") as! NSString?
        model.name = dic.value(forKey: "name") as! NSString?
        
        return model
    }
}

