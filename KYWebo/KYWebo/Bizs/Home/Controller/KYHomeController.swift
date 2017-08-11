//
//  KYHomeController.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/10.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import YYKit

/// Webo首页
class KYHomeController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Webo"
        self.view.backgroundColor = .white
        
        requestDats()
    }
    
    func requestDats() {
        guard let authData = UserDefaults.standard.object(forKey: "WeboAuthData") as? [String: Any] else {
            return
        }
        
        var params: [String: String] = [:]
        params["access_token"] = authData["AccessTokenKey"] as? String
        params["count"] = "5"
        
        _ = WBHttpRequest(url: "https://api.weibo.com/2/statuses/home_timeline.json",
                          httpMethod: "GET",
                          params: params,
                          delegate: self,
                          withTag: "homeTag")
    }
}

extension KYHomeController: WBHttpRequestDelegate {
    
    func request(_ request: WBHttpRequest!, didFinishLoadingWithDataResult data: Data!) {
        if let json = String(data: data, encoding: .utf8) {
            print("json = \(String(describing: json))")
            
            if let item: WbTimeline = WbTimeline.model(withJSON: json) {
                for statues in item.statuses {
                    print("id = \(statues.statusID)")
                }
            }
        }
    }
    
    func request(_ request: WBHttpRequest!, didFailWithError error: Error!) {
        
    }
}

