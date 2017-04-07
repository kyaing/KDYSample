//
//  KYAlbumPickerController.swift
//  ImagePicker
//
//  Created by mac on 17/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

/// 相册控制器
class KYAlbumPickerController: UIViewController {

    var albumsArray = NSMutableArray()
    
    lazy var albumTableVIew: UITableView = {
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        tb.delegate = self
        tb.dataSource = self
        tb.register(AlbumTableCell.classForCoder(), forCellReuseIdentifier: "AlbumCell")
        
        self.view.addSubview(tb)
        
        tb.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 遍历所有相册
        KYAssetManager.default.enumerationGroupAssets { (assetGroups) in
            if assetGroups != nil {
                albumsArray.add(assetGroups!)
            } else {
                albumTableVIew.reloadData()
            }
        }
    }
}

extension KYAlbumPickerController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        
        return albumCell
    }
}

extension KYAlbumPickerController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

