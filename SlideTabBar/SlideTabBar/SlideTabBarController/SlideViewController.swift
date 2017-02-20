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

    // MARK: - Properties
    
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
    public let Margin: CGFloat = 20.0
    
    /// 标题间距
    public var titleMargin: CGFloat = 0
    
    /// 下划线高度
    public var underlineHieght: CGFloat = 3.0
    
    private let kFrameWidth  = UIScreen.main.bounds.width
    private let kFrameHeight = UIScreen.main.bounds.height
    
    /// 标题的总数组
    lazy var titleLabelsArray: NSMutableArray = {
        let array = NSMutableArray.init()
        return array
    }()
    
    /// 标题的总宽度
    var titleWidthsArray: NSMutableArray = []
    
    /// 全部的内容视图
    lazy var contentBgView: UIView = {
        let contentBgView = UIView()
        contentBgView.frame = CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height)
        
        self.view.addSubview(contentBgView)

        return contentBgView
    }()
    
    /// 顶部标题滚动视图
    lazy var titleScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.titleHeight)
        scrollView.backgroundColor = .gray //UIColor(white: 1, alpha: 0.6)
        scrollView.scrollsToTop = false
        scrollView.showsVerticalScrollIndicator   = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.addSubview(self.underlineView)
        self.contentBgView.addSubview(scrollView)
    
        return scrollView
    }()
    
    /// 内容视图
    lazy var collectionView: UICollectionView = {
        let layout = SlideFlowLayout()
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        let yPos = self.titleScrollView.frame.maxY
        let height = self.contentBgView.height - self.titleScrollView.height
        collectionView.frame = CGRect(x: 0, y: yPos, width: self.view.width, height: height)
        
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "SlideCell")
        collectionView.dataSource = self
        
        self.contentBgView.addSubview(collectionView)
        
        return collectionView
    }()
    
    /// 下划线视图
    lazy var underlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = .red
        return underlineView
    }()

    // MARK: - Life Cycle
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
        
        setupTitleWidths()
        setupTitlesArray()
    }
    
    // MARK: - Private Methods
    
    /**
     *  根据label字符串计算宽
     */
    func getLableWidth(labelStr: String, font: UIFont) -> CGFloat {
        
        let statusLabelText = labelStr as NSString
        let size =  CGSize(width: 900, height: 0)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String: AnyObject], context:nil).size
        
        return strSize.width
    }
    
    /**
     *  初始化标题栏宽度
     */
    func setupTitleWidths() {
        
        // 标题总宽度
        var totalWidth: CGFloat = 0
        
        for controller in self.childViewControllers {
            let title = controller.title
            let width = getLableWidth(labelStr: title!, font: titleFont)
            
            totalWidth += width
            titleWidthsArray.add(width)
        }
        
        let marginCounts = self.childViewControllers.count + 1
        titleMargin = (totalWidth > kFrameWidth) ? Margin : (kFrameWidth - totalWidth) / CGFloat(marginCounts)
        
        titleScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: titleMargin)
    }

    /**
     *  初始化标题栏
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
                
                var tempLastLabel = UILabel()
                if titleLabelsArray.count == 0 {
                    labelX = titleMargin
                } else {
                    tempLastLabel = titleLabelsArray.lastObject as! UILabel
                    labelX = titleMargin + tempLastLabel.frame.maxX
                }
                
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
    
    // MARK: - Events Response
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

