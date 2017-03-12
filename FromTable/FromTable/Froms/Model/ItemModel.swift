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
    
    var key: String?
    var name: String?
    var type: FormItemType?
    var required: Bool?
    var tip1: String?
    var tip2: String?
    var tip3: String?
    
    func mapDicToModel(_ dic: NSDictionary) -> ItemModel {
        let model = ItemModel()
        
        model.key  = dic.value(forKey: "key") as! String?
        model.name = dic.value(forKey: "name") as! String?
        
        return model
    }
}

