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

    /// 展示的列数
    var photoColumns: Int = 4
    
    var margin: CGFloat = 5.0
    
    lazy var photoLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = self.margin
        flowLayout.minimumInteritemSpacing = self.margin
        
        let width: CGFloat = (self.view.width - CGFloat(self.photoColumns + 1) * self.margin) / CGFloat(self.photoColumns)
        flowLayout.itemSize = CGSize(width: width, height: width)
        
        return flowLayout
    }()
    
    lazy var photoCollection: UICollectionView = {
        let collect: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.photoLayout)
        collect.register(UINib.init(nibName: "AssetCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AssetCell")
        collect.contentInset = UIEdgeInsets(top: self.margin, left: self.margin, bottom: self.margin, right: self.margin)
        collect.backgroundColor = UIColor(colorLiteralRed: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        collect.showsHorizontalScrollIndicator = false
        collect.dataSource = self
        collect.delegate = self
        
        return collect
    }()
    
    /// 底部工具栏
    lazy var toolBarView: UIView = {
        let toolbar = UIView()
        toolbar.frame = CGRect(x: 0, y: self.view.height - 44, width: self.view.width, height: 44)
        toolbar.backgroundColor = UIColor(colorLiteralRed: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        let previewBtn = UIButton()
        previewBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 44)
        previewBtn.setTitle("预览", for: .normal)
        previewBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        previewBtn.setTitleColor(.lightGray, for: .normal)
        previewBtn.setTitleColor(.white, for: .selected)
        toolbar.addSubview(previewBtn)
        
        let doneBtn = UIButton()
        doneBtn.frame = CGRect(x: self.view.width-60, y: 0, width: 50, height: 44)
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        doneBtn.setTitleColor(UIColor.green, for: .normal)
        toolbar.addSubview(doneBtn)
        
        return toolbar
    }()
    
    var assetGroups: KYAssetGroup?
    
    var assetsArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        setupViews()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelAction))
        
        assetGroups?.enumerationGroupAssets(assetBlock: { (asset) in
            if asset != nil {
                assetsArray.add(asset!)
            } else {
                photoCollection.reloadData()
            }
        })
    }
    
    func setupViews() {
        self.view.addSubview(photoCollection)
        self.view.insertSubview(toolBarView, aboveSubview: photoCollection)
        
        photoCollection.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
            make.bottom.equalTo(toolBarView.snp.top)
        }
        
        let lineView = UIView()
        lineView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 0.5)
        lineView.backgroundColor = .gray
        toolBarView.addSubview(lineView)
    }
    
    func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension KYPhotosPickerController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let assetCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetCell", for: indexPath) as! AssetCollectionCell

        if indexPath.row < assetsArray.count {
            let phAsset = assetsArray.object(at: indexPath.row) as! KYAsset
            let size = CGSize(width: assetCell.width, height: assetCell.height)
            
            _ = phAsset.requestThumbnailImage(size, assetBlock: { (result, info) in
                assetCell.photoImage.image = result
            })
        }
        
        return assetCell
    }
}

extension KYPhotosPickerController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let previewController = KYPreviewViewController()
        previewController.currentIndex = indexPath.row
        previewController.assetsArray = assetsArray
        self.navigationController?.pushViewController(previewController, animated: true)
    }
}

