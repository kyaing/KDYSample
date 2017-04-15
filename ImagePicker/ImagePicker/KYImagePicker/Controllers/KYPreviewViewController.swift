//
//  KYPreviewViewController.swift
//  ImagePicker
//
//  Created by kaideyi on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

/// 预览图控制器
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
        navigation.backgroundColor = UIColor(colorLiteralRed: 35/255.0, green: 35/255.0, blue: 35/255.0, alpha: 0.8)

        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 5, y: 10, width: 44, height: 44)
        backBtn.setImage(UIImage(named: "navi_back"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        navigation.addSubview(backBtn)
        self.backButton = backBtn
        
        let selectBtn = UIButton()
        selectBtn.frame = CGRect(x: self.view.width - 60, y: 2, width: 60, height: 60)
        selectBtn.setImage(UIImage(named: "photo_def_photoPickerVc"), for: .normal)
        selectBtn.setImage(UIImage(named: "photo_sel_photoPickerVc"), for: .selected)
        selectBtn.setImage(UIImage(named: "photo_sel_photoPickerVc"), for: .highlighted)
        selectBtn.addTarget(self, action: #selector(originBtnAction), for: .touchUpInside)
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
    var numberButton = UIButton()
    
    /// 底部工具栏
    lazy var toolBarView: UIView = {
        let toolbar = UIView()
        toolbar.frame = CGRect(x: 0, y: self.view.height - 44, width: self.view.width, height: 44)
        toolbar.backgroundColor = UIColor(colorLiteralRed: 35/255.0, green: 35/255.0, blue: 35/255.0, alpha: 0.8)
        
        let originBtn = UIButton()
        originBtn.frame = CGRect(x: 5, y: 0, width: 80, height: 44)
        originBtn.setTitle("原图", for: .normal)
        originBtn.setImage(UIImage(named: "photo_original_def"), for: .normal)
        originBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        originBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        originBtn.setTitleColor(.lightGray, for: .normal)
        originBtn.setTitleColor(.white, for: .selected)
        originBtn.addTarget(self, action: #selector(selectBtnAction), for: .touchUpInside)
        toolbar.addSubview(originBtn)
        self.originButton = originBtn
        
        let doneBtn = UIButton()
        doneBtn.frame = CGRect(x: self.view.width-60, y: 0, width: 50, height: 44)
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        doneBtn.setTitleColor(KDYColor.ChatGreen.color, for: .normal)
        doneBtn.addTarget(self, action: #selector(doneBtnAction), for: .touchUpInside)
        toolbar.addSubview(doneBtn)
        self.doneButton = doneBtn
        
        let numberBtn = UIButton()
        numberBtn.frame = CGRect(x: self.view.width-80, y: 11.5, width: 23, height: 23)
        numberBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        numberBtn.setTitleColor(.white, for: .normal)
        numberBtn.backgroundColor = KDYColor.ChatGreen.color
        numberBtn.layer.cornerRadius  = 11.5
        numberBtn.layer.masksToBounds = true
        numberBtn.isHidden = true
        toolbar.addSubview(numberBtn)
        self.numberButton = numberBtn
        
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
    
    /// 滑动下张图索引
    var nextPageIndex: Float = 0 {
        willSet {
            refeshNaviAndToolStates(Int(newValue))
        }
    }
    
    lazy var allAssetsArray = NSMutableArray()
    
    lazy var selAssetsArray = NSMutableArray()
    
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
        
        refeshNaviAndToolStates(currentSelIndex)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Private Methods 
    
    func refeshNaviAndToolStates(_ index: Int) {
        if isPreviewSelected {
            selectButton.isSelected = true
        } else {
            let phAsset = allAssetsArray.object(at: index) as! KYAsset
            selectButton.isSelected = selAssetsArray.contains(phAsset)
        }
        
        // 判断选择的图片数
        if selAssetsArray.count > 0 {
            numberButton.isHidden = false
            numberButton.setTitle(String("\(selAssetsArray.count)"), for: .normal)
            
        } else {
            numberButton.isHidden = true
        }
    }
    
    // MARK: - Event Response
    
    func backBtnAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func selectBtnAction() {
        let msgString = String("您最多只能选择9张图片")
        let alertController = UIAlertController(title: nil, message: msgString, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "我知道了", style: .default, handler: nil)
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func originBtnAction() {
        
    }
    
    func doneBtnAction() {
        
    }
    
    func clickButtonsWithAnimation(_ sender: AnyObject) {
        let changeAnimation = CAKeyframeAnimation()
        changeAnimation.keyPath = "transform.scale"
        changeAnimation.duration = 0.5
        changeAnimation.values = [0.8, 1.1, 0.9, 1.0]
        sender.layer.add(changeAnimation, forKey: nil)
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 计算页码
        let pageWidth = scrollView.width
        nextPageIndex = round(Float(scrollView.contentOffset.x / pageWidth))
        
        // 浮点数格式化 %0.f
        naviTitleLabel.text = String(format: "%0.f/%d", nextPageIndex+1, totalImageCounts)
    }
}

