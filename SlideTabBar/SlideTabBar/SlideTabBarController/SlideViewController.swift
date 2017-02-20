//
//  SlideViewController.swift
//  SlideTabBar
//
//  Created by mac on 17/2/20.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

/// 滑动的控制器
open class SlideViewController: UIViewController {

    // MARK: Properties
    
    /// 标题字体大小
    public var titleFont: UIFont = .systemFont(ofSize: 15)
    
    /// 标题默认颜色
    public var titleNormalColor: UIColor = .black
    
    /// 标题选中颜色
    public var titleSlectColor: UIColor = .red
    
    /// 标题高度
    public var titleHeight: CGFloat = 44.0
    
    /// 标题宽度
    public var titleWidth: CGFloat = 0.0
    
    /// 默认标题间的间距
    public var titleMargin: CGFloat = 20.0
    
    /// 下划线高度
    public var underlineHieght: CGFloat = 3.0
    
    private static let kFrameWidth  = UIScreen.main.bounds.width
    private static let kFrameHeight = UIScreen.main.bounds.height
    
    /// 标题的总数组
    var titleLabelsArray: NSMutableArray = []
    
    /// 标题的总宽度
    var titleWidthsArray: NSMutableArray = []
    
    /// 全部的内容视图
    lazy var totalContentView: UIView = {
        let totalContentView = UIView()
        return totalContentView
    }()
    
    /// 顶部标题滚动视图
    lazy var titleScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = .gray //UIColor(white: 1, alpha: 0.6)
    
        return scrollView
    }()
    
    /// 内容视图
    lazy var collectionView: UICollectionView = {
        let layout = SlideFlowLayout()
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "SlideCell")
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    /// 下划线视图
    lazy var underlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = .red
        return underlineView
    }()

    // MARK: Life Cycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViews()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTitleWidths()
        setupTitlesArray()
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        totalContentView.frame = CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height)
        
        // 标题滚动视图
        titleScrollView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: titleHeight)
        
        // 内容滚动视图
        let yPos = titleScrollView.y
        let height = totalContentView.height - titleScrollView.height
        collectionView.frame = CGRect(x: 0, y: yPos, width: self.view.width, height: height)
    }
    
    // MARK: Private Methods
    
    func setupChildViews() {
        titleScrollView.addSubview(underlineView)
        
        totalContentView.addSubview(titleScrollView)
        totalContentView.insertSubview(collectionView, belowSubview: titleScrollView)
    }

    /**
     * 初始化标题栏
     */
    func setupTitlesArray() {
        // 顶部标题frame
        var labelX: CGFloat = 0
        let labelY: CGFloat = 0
        var labelW = titleWidth
        let labelH = titleHeight
        
        // 遍历所有子控制
        for controller in self.childViewControllers {
            let index = self.childViewControllers.index(of: controller)
            
            // 顶部标题
            let label = SlideTitleLabel()
            label.font      = titleFont
            label.textColor = titleNormalColor
            label.text      = controller.title
            label.tag       = index!
            
            if titleWidth == 0 {
                labelW = titleWidthsArray[index!] as! CGFloat
                
                let tempLastLabel = titleLabelsArray.lastObject as! UILabel
                labelX = titleMargin + tempLastLabel.frame.maxX
                
            } else {
                labelX = CGFloat(index!) * titleWidth
            }
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            titleLabelsArray.add(label)
            titleScrollView.addSubview(label)
        }
        
        // 顶部滚动区域
        let lastLabel = titleLabelsArray.lastObject as! UILabel
        titleScrollView.contentSize = CGSize(width: lastLabel.frame.maxX, height: 0)
        
        // 内容滚动区域
        let counts = self.childViewControllers.count
        collectionView.contentSize = CGSize(width: CGFloat(counts) * self.view.width, height: 0)
    }
    
    /**
     * 初始化标题栏宽度
     */
    func setupTitleWidths() {
        
    }
    
    // MARK: Events Response
}

// MARK: -
extension SlideViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childViewControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideCell", for: indexPath)
        
        let controller = self.childViewControllers[indexPath.item] as UIViewController
        controller.view.frame = CGRect(x: 0, y: 0, width: collectionView.width, height: collectionView.height)
        cell.contentView.addSubview(controller.view)
        
        return cell
    }
}

// MARK: - 
extension SlideViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}

