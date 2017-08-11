//
//  WbTimeline.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import YYKit

class WbTimeline: NSObject {
    
    var interval: Int = 0
    var maxID: String = ""
    var sinceID: String = ""
    var statuses: Array<WbStatus> = []

    public static func modelCustomPropertyMapper() -> [String : Any]? {
        return [
            "statusID": "id",
            "statusIdstr": "idstr",
            "createdAt": "created_at"
        ]
    }
    
    public static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["statuses": WbStatus.classForCoder()]
    }
}

