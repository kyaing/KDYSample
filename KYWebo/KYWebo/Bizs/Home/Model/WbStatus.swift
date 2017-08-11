//
//  WbStatus.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import YYKit

class WbStatus: NSObject {
    
    var statusID: Int = 0
    var statusIdstr: String = ""
    var createdAt: String = ""
    
    var user: WbUser = WbUser()
    
    public static func modelCustomPropertyMapper() -> [String : Any]? {
        return [
            "statusID": "id",
            "statusIdstr": "idstr",
            "createdAt": "created_at"
        ]
    }
}

