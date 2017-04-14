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

    // MARK: - Properties
    
    /// 展示的列数
    let photoColumns: Int = 4
    
    let margin: CGFloat = 5.0
    
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
        collect.register(UINib(nibName: "AssetCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AssetCell")
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
    
    /// 总数据源
    var allAssetsArray = NSMutableArray()
    
    /// 选中的数据源
    var selAssetsArray = NSMutableArray()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupAllViews()
        
        assetGroups?.enumerationGroupAssets(assetBlock: { (asset) in
            if asset != nil {
                allAssetsArray.add(asset!)
            } else {
                photoCollection.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupAllViews() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelAction))
        
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
    
    // MARK: - Event Response
    
    func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    func refeshToolBarViewState() {
        
    }
    
    func clickButtonsWithAnimation() {
        
    }
    
    func requestPreviewImage(withIndexPath indexPath: IndexPath) {
        
    }
    
    // 判断
    func selectAssetInArray(_ selectAsset: KYAsset, _ selectedArray: NSMutableArray) -> Bool {
        for tepAsset in selectedArray as! [KYAsset] {
            if tepAsset.phAsset.localIdentifier == selectAsset.phAsset.localIdentifier {
                return true
            }
        }
        
        return false
    }
}

// MARK:

extension UICollectionView {
    
    func indexPathOfView(_ sender: AnyObject) -> IndexPath? {
        if sender.isKind(of: UIView.classForCoder()) {
            let view = sender as! UIView
            if let cell = parentCellwithView(view) {
                return indexPath(for: cell)
            }
        }
        
        return nil
    }
    
    func parentCellwithView(_ view: UIView) -> UICollectionViewCell? {
        if view.superview == nil {
            return nil
        }
        
        if (view.superview?.isKind(of: UICollectionViewCell.classForCoder()))! {
            return view.superview as? UICollectionViewCell
        }
        
        return parentCellwithView(view.superview!)
    }
}

extension KYPhotosPickerController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allAssetsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let assetCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetCell", for: indexPath) as! AssetCollectionCell

        let phAsset = allAssetsArray.object(at: indexPath.row) as! KYAsset
        let size = CGSize(width: assetCell.width, height: assetCell.height)
        
        _ = phAsset.requestThumbnailImage(size, assetBlock: { (result, info) in
            assetCell.photoImage.image = result
        })
        
        // 选择图片按钮事件
        assetCell.didSelectBtnClosure = { sender in
            let indexPath  = self.photoCollection.indexPathOfView(sender)
            let selectCell = self.photoCollection.cellForItem(at: indexPath!) as! AssetCollectionCell
            _ = self.allAssetsArray.object(at: (indexPath?.row)!) as! KYAsset
            
            if selectCell.isChecked {
                // 取消选择图片
                selectCell.isChecked = false
                
            } else {
                // 点击选择图片
                selectCell.isChecked = true
                self.requestPreviewImage(withIndexPath: indexPath!)
            }
        }
        
        assetCell.isChecked = selectAssetInArray(phAsset, selAssetsArray)
        
        return assetCell
    }
}

extension KYPhotosPickerController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let previewController = KYPreviewViewController()
        previewController.currentIndex = indexPath.row
        previewController.assetsArray = allAssetsArray
        self.navigationController?.pushViewController(previewController, animated: true)
    }
}

