//
//  KYPreviewViewController.swift
//  ImagePicker
//
//  Created by kaideyi on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

/// 预览大图控制器
class KYPreviewViewController: UIViewController {
    
    // MARK: - Proproties
    
    var previewLayout = KYCollectionFlowLayout()
        
    lazy var previewCollection: UICollectionView = {
        let collect: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.previewLayout)
        collect.register(UINib(nibName: "PreviewCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PreviewCell")
        collect.backgroundColor = .black
        collect.showsHorizontalScrollIndicator = false
        collect.scrollsToTop = false
        collect.isPagingEnabled = true
        collect.dataSource = self
        collect.delegate = self
        
        self.view.addSubview(collect)
        
        collect.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        return collect
    }()
    
    /// 返回按钮
    var backButton: UIButton!
    
    /// 选择大图按钮
    var selectButton: UIButton!
    
    /// 自定义导航栏
    lazy var navigationView: UIView = {
        let navigation = UIView()
        navigation.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 64)
        navigation.backgroundColor = UIColor(colorLiteralRed: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 0.7)

        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 5, y: 10, width: 44, height: 44)
        backBtn.setImage(UIImage(named: "navi_back"), for: .normal)
        backBtn.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        navigation.addSubview(backBtn)
        self.backButton = backBtn
        
        let selectBtn = UIButton()
        selectBtn.frame = CGRect(x: self.view.width - 60, y: 2, width: 60, height: 60)
        selectBtn.setImage(UIImage(named: "photo_def_photoPickerVc"), for: .normal)
        selectBtn.setImage(UIImage(named: "photo_sel_photoPickerVc"), for: .selected)
        selectBtn.isSelected = true
        navigation.addSubview(selectBtn)
        self.selectButton = selectBtn
        
        return navigation
    }()
    
    /// 查看原图按钮
    var originsButton: UIButton!
    
    /// 选择完成按钮
    var doneButton: UIButton!
    
    /// 底部工具栏
    lazy var toolBarView: UIView = {
        let toolbar = UIView()
        toolbar.frame = CGRect(x: 0, y: self.view.height - 44, width: self.view.width, height: 44)
        toolbar.backgroundColor = UIColor(colorLiteralRed: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 0.7)
        
        let originBtn = UIButton()
        originBtn.frame = CGRect(x: 5, y: 0, width: 80, height: 44)
        originBtn.setTitle("原图", for: .normal)
        originBtn.setImage(UIImage(named: "photo_original_def"), for: .normal)
        originBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        originBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        originBtn.setTitleColor(.lightGray, for: .normal)
        originBtn.setTitleColor(.white, for: .selected)
        toolbar.addSubview(originBtn)
        self.originsButton = originBtn
        
        let doneBtn = UIButton()
        doneBtn.frame = CGRect(x: self.view.width-60, y: 0, width: 50, height: 44)
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        toolbar.addSubview(doneBtn)
        self.doneButton = doneBtn
        
        return toolbar
    }()
    
    /// 当前图片索引
    var currentIndex: Int = 0
    
    var assetsArray = NSMutableArray()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.insertSubview(navigationView, aboveSubview: previewCollection)
        self.view.insertSubview(toolBarView, aboveSubview: previewCollection)
        
        previewCollection.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // 注意如何隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Private Methods
    
    
    
    func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK:

extension KYPreviewViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let previewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewCell", for: indexPath) as! PreviewCollectionCell
        
        let phAsset = assetsArray.object(at: indexPath.row) as! KYAsset
        _ = phAsset.requestPreviewImage { (image, info) in
            previewCell.previewImage.image = image
        }
        
        return previewCell
    }
}

extension KYPreviewViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

