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
    
    var backButton   = UIButton()
    var selectButton = UIButton()
    var naviTitleLabel = UILabel()
    
    /// 自定义导航栏
    lazy var navigationView: UIView = {
        let navigation = UIView()
        navigation.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 64)
        navigation.backgroundColor = UIColor(colorLiteralRed: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 0.8)

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
        
        let titleL = UILabel()
        titleL.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        titleL.center = navigation.center
        titleL.font = UIFont.boldSystemFont(ofSize: 18)
        titleL.textColor = .white
        titleL.textAlignment = .center
        navigation.addSubview(titleL)
        self.naviTitleLabel = titleL
        
        return navigation
    }()
    
    var originButton = UIButton()
    var doneButton   = UIButton()
    
    /// 底部工具栏
    lazy var toolBarView: UIView = {
        let toolbar = UIView()
        toolbar.frame = CGRect(x: 0, y: self.view.height - 44, width: self.view.width, height: 44)
        toolbar.backgroundColor = UIColor(colorLiteralRed: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 0.8)
        
        let originBtn = UIButton()
        originBtn.frame = CGRect(x: 5, y: 0, width: 80, height: 44)
        originBtn.setTitle("原图", for: .normal)
        originBtn.setImage(UIImage(named: "photo_original_def"), for: .normal)
        originBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        originBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        originBtn.setTitleColor(.lightGray, for: .normal)
        originBtn.setTitleColor(.white, for: .selected)
        toolbar.addSubview(originBtn)
        self.originButton = originBtn
        
        let doneBtn = UIButton()
        doneBtn.frame = CGRect(x: self.view.width-60, y: 0, width: 50, height: 44)
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        toolbar.addSubview(doneBtn)
        self.doneButton = doneBtn
        
        return toolbar
    }()
    
    lazy var totalImageCounts: Int = {
        return !self.isPreviewSelected ? self.allAssetsArray.count : self.selAssetsArray.count
    }()
    
    /// 当前图片索引
    var currentSelIndex: Int = 0 {
        willSet {
            let xPos = self.view.width * CGFloat(newValue)
            previewCollection.setContentOffset(CGPoint(x: xPos, y: 0), animated: false)
            
            // 更新title
            naviTitleLabel.text = String(format: "%d/%d", newValue+1, totalImageCounts)
        }
    }
    
    var allAssetsArray = NSMutableArray()
    
    var selAssetsArray = NSMutableArray()
    
    // 是否只是预览选中的图片
    var isPreviewSelected: Bool = false
    
    // 注意如何隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Private Methods
    
    func backButtonAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

// MARK:

extension KYPreviewViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !isPreviewSelected ? allAssetsArray.count : selAssetsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let previewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewCell", for: indexPath) as! PreviewCollectionCell
        
        // 请求预览图
        var phAsset: KYAsset!
        
        if !isPreviewSelected {
            phAsset = allAssetsArray.object(at: indexPath.item) as! KYAsset
        } else {
            phAsset = selAssetsArray.object(at: indexPath.item) as! KYAsset
        }
        
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

extension KYPreviewViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 计算下一页的页码
        let pageWidth = scrollView.width
        let currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        
        // 注意浮点数据的格式化 %0.f
        naviTitleLabel.text = String(format: "%0.f/%d", currentPage+1, totalImageCounts)
    }
}

