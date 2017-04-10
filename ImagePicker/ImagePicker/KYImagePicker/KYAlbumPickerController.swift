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
        tb.register(UINib(nibName: "AlbumTableCell", bundle: nil), forCellReuseIdentifier: "AlbumTableCell")
        tb.tableFooterView = UIView()
        tb.rowHeight = 55
        
        self.view.addSubview(tb)
        
        tb.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "照片"
        self.view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelAction))
        
        // 遍历所有相册
        KYAssetManager.default.enumerationGroupAssets { (assetGroups) in
            if assetGroups != nil {
                albumsArray.add(assetGroups!)
            } else {
                albumTableVIew.reloadData()
            }
        }
    }
    
    func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension KYAlbumPickerController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableCell", for: indexPath) as! AlbumTableCell
        
        if indexPath.row < albumsArray.count {
            let assetGroups = albumsArray.object(at: indexPath.row) as! KYAssetGroup
            
            albumCell.titleLabel.text = assetGroups.groupName
            albumCell.numberLabel.text = "(\(assetGroups.numberOfGroup))"
            albumCell.pickerImage.image = assetGroups.posterImage(CGSize(width: 45, height: 45))
        }
        
        return albumCell
    }
}

extension KYAlbumPickerController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row < albumsArray.count {
            let assetGroups = albumsArray.object(at: indexPath.row) as! KYAssetGroup
            
            let photosConroller = KYPhotosPickerController()
            photosConroller.title = assetGroups.groupName
            photosConroller.assetGroups = assetGroups
            self.navigationController?.pushViewController(photosConroller, animated: true)
        }
    }
}

