//
//  ViewController.swift
//  FromTable
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.title = "Froms"
        self.view.backgroundColor = .white
        
        let array = JsonData.getInfosWithJson(fileName: "test", jsonKey: "configure")
        print("array = \(array)")
    }
}

