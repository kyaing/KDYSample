//
//  EditTextViewController.swift
//  FromTable
//
//  Created by kaideyi on 2017/3/12.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class EditTextViewController: UIViewController {
    
//    typealias editDoneClosure = 
    
    var editTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: .plain, target: nil, action: #selector(EditTextViewController.editDoneAction))
        
        editTextField = UITextField()
        editTextField.borderStyle = .line
        editTextField.placeholder = self.title
        editTextField.frame = CGRect(x: 0, y: 80, width: self.view.width, height: 40)
        self.view.addSubview(editTextField)
    }
    
    func editDoneAction() {
        
    }
}

