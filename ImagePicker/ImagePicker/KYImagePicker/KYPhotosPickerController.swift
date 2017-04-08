//
//  KYPhotosPickerController.swift
//  ImagePicker
//
//  Created by mac on 17/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Photos

/// 图片控制器
class KYPhotosPickerController: UIViewController {

    lazy var photoLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        
        let width: CGFloat = (self.view.width - 25) / 4.0
        let hight = width
        flowLayout.itemSize = CGSize(width: width, height: hight)
        
        return flowLayout
    }()
    
    lazy var photoCollection: UICollectionView = {
        let collect: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.photoLayout)
        collect.register(UINib.init(nibName: "AssetCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AssetCollectionCell")
        collect.backgroundColor = .clear
        collect.showsHorizontalScrollIndicator = false
        collect.dataSource = self
        collect.delegate = self

        self.view.addSubview(collect)
        
        collect.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        return collect
    }()
    
    var assetGroups: KYAssetGroup?
    
    var assetsArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        assetGroups?.enumerationGroupAssets(assetBlock: { (asset) in
            if asset != nil {
                assetsArray.add(asset!)
            } else {
                photoCollection.reloadData()
            }
        })
    }
}

extension KYPhotosPickerController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let assetCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetCollectionCell", for: indexPath) as! AssetCollectionCell

        if indexPath.row < assetsArray.count {
            let phAsset = assetsArray.object(at: indexPath.row) as! KYAsset
            
            _ = phAsset.requestThumbnailImage(CGSize(width: 80, height: 80), assetBlock: { (result, info) in
                assetCell.photoImage.image = result
            })
        }
        
        return assetCell
    }
}

extension KYPhotosPickerController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

