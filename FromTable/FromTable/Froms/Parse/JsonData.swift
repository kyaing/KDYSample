//
//  JsonData.swift
//  FromTable
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class JsonData: NSObject {
    
    class func getInfosWithJson(fileName: String, jsonKey: String) -> AnyObject? {
        
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        if let jsonPath = path {
            let jsonData = NSData(contentsOfFile: jsonPath)
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                let dic = (jsonObject as AnyObject).object(forKey: "details")
                return dic as AnyObject?
                
            } catch {
                print(error)
            }
        }
        
        return nil
    }
}

