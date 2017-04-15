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
    
    let maxSelImageCount: Int = 9
    
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
    
    var previewButton = UIButton()
    var doneButton    = UIButton()
    var numberButton  = UIButton()
    
    /// 底部工具栏
    lazy var toolBarView: UIView = {
        let toolbar = UIView()
        toolbar.frame = CGRect(x: 0, y: self.view.height - 44, width: self.view.width, height: 44)
        toolbar.backgroundColor = UIColor(colorLiteralRed: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        let previewBtn = UIButton()
        previewBtn.frame = CGRect(x: 5, y: 0, width: 50, height: 44)
        previewBtn.setTitle("预览", for: .normal)
        previewBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        previewBtn.setTitleColor(.lightGray, for: .normal)
        previewBtn.setTitleColor(.white, for: .selected)
        previewBtn.isEnabled = false
        previewBtn.addTarget(self, action: #selector(previewBtnAction), for: .touchUpInside)
        toolbar.addSubview(previewBtn)
        self.previewButton = previewBtn
        
        let doneBtn = UIButton()
        doneBtn.frame = CGRect(x: self.view.width-60, y: 0, width: 50, height: 44)
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        doneBtn.setTitleColor(.green, for: .normal)
        doneBtn.isEnabled = false
        previewBtn.addTarget(self, action: #selector(doneBtnAction), for: .touchUpInside)
        toolbar.addSubview(doneBtn)
        self.doneButton = doneBtn
        
        let numberBtn = UIButton()
        numberBtn.frame = CGRect(x: self.view.width-80, y: 10, width: 24, height: 24)
        numberBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        numberBtn.setTitleColor(.white, for: .normal)
        numberBtn.backgroundColor = KDYColor.ChatGreen.color
        numberBtn.layer.cornerRadius  = 12.0
        numberBtn.layer.masksToBounds = true
        numberBtn.isHidden = true
        toolbar.addSubview(numberBtn)
        self.numberButton = numberBtn
        
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
    
    func previewBtnAction() {
        // 只预览选择的图片
        let previewController = KYPreviewViewController()
        previewController.isPreviewSelected = true
        previewController.selAssetsArray = selAssetsArray
        previewController.currentSelIndex = 0
        self.navigationController?.pushViewController(previewController, animated: true)
    }
    
    func doneBtnAction() {
        
    }
    
    // MARK: - Private Methods
    
    func refeshToolBarViewState() {
        if selAssetsArray.count > 0 {
            previewButton.isEnabled = true
            previewButton.setTitleColor(.black, for: .normal)
            
            doneButton.isEnabled = true
            doneButton.setTitleColor(KDYColor.ChatGreen.color, for: .normal)
            
            numberButton.isHidden = false
            numberButton.setTitle(String("\(selAssetsArray.count)"), for: .normal)
            clickButtonsWithAnimation(numberButton)
            
        } else {
            previewButton.isEnabled = false
            previewButton.setTitleColor(.lightGray, for: .normal)
            
            doneButton.isEnabled = false
            doneButton.setTitleColor(.green, for: .normal)
            numberButton.isHidden = true
        }
    }
    
    func clickButtonsWithAnimation(_ sender: AnyObject) {
        let changeAnimation = CAKeyframeAnimation()
        changeAnimation.keyPath = "transform.scale"
        changeAnimation.duration = 0.5
        changeAnimation.values = [0.8, 1.1, 0.9, 1.0]
        sender.layer.add(changeAnimation, forKey: nil)
    }
    
    func requestBigImage(withIndexPath indexPath: IndexPath) {
        let phAsset = allAssetsArray.object(at: indexPath.item) as! KYAsset
        _ = photoCollection.cellForItem(at: indexPath) as! AssetCollectionCell
        
        // 请求源图（这里应该是请求预览图，但是没用！）
        _ = phAsset.requestOriginImage { (image, info) in
            self.selAssetsArray.add(phAsset)
            self.refeshToolBarViewState()
        }
    }
    
    func selectAssetContainInArray(_ selectAsset: KYAsset, _ selectedArray: NSMutableArray) -> Bool {
        for tepAsset in selectedArray as! [KYAsset] {
            if tepAsset.phAsset.localIdentifier == selectAsset.phAsset.localIdentifier {
                return true
            }
        }
        
        return false
    }
    
    func selectAssetRemoveInArray(_ selectAsset: KYAsset, _ selectedArray: NSMutableArray) {
        for tepAsset in selectedArray as! [KYAsset] {
            if tepAsset.phAsset.localIdentifier == selectAsset.phAsset.localIdentifier {
                selectedArray.remove(selectAsset)
            }
        }
    }
}

// MARK:

extension UICollectionView {
    
    // 查询当前View所在的indexPath
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

        let phAsset = allAssetsArray.object(at: indexPath.item) as! KYAsset
        let size = CGSize(width: assetCell.width, height: assetCell.height)
        
        _ = phAsset.requestThumbnailImage(size, assetBlock: { (result, info) in
            assetCell.photoImage.image = result
        })
        
        // 选择图片按钮事件
        assetCell.didSelectBtnClosure = { sender in
            
            let indexPath  = self.photoCollection.indexPathOfView(sender)
            let selectCell = self.photoCollection.cellForItem(at: indexPath!) as! AssetCollectionCell
            _ = self.allAssetsArray.object(at: (indexPath?.item)!) as! KYAsset
            
            if selectCell.isChecked {
                // 取消选择图片
                selectCell.isChecked = false
                
                self.selectAssetRemoveInArray(phAsset, self.selAssetsArray)
                self.refeshToolBarViewState()
                
            } else {
                // 点击选择图片
                if self.selAssetsArray.count == self.maxSelImageCount {
                    let msgString = String("您最多只能选择\(self.maxSelImageCount)张图片")
                    let alertController = UIAlertController(title: nil, message: msgString, preferredStyle: .alert)
                    let doneAction = UIAlertAction(title: "我知道了", style: .default, handler: nil)
                    alertController.addAction(doneAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                selectCell.isChecked = true
                
                self.requestBigImage(withIndexPath: indexPath!)
                self.clickButtonsWithAnimation(sender)
            }
        }
        
        assetCell.isChecked = selectAssetContainInArray(phAsset, selAssetsArray)
        
        return assetCell
    }
}

extension KYPhotosPickerController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let previewController = KYPreviewViewController()
        previewController.allAssetsArray  = allAssetsArray
        previewController.currentSelIndex = indexPath.item
        self.navigationController?.pushViewController(previewController, animated: true)
    }
}

