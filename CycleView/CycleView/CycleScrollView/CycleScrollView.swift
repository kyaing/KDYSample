//
//  CycleScrollView.swift
//  CycleView
//
//  Created by mac on 17/2/24.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class CycleScrollView: UIView {
    
    // MARK: - Propertiesvar  
    
    /// 是否自动滚动
    open var isAutoScroll: Bool! {
        willSet {
            if newValue == true {
                setupTimer()
            }
        }
    }
    
    /// 是否无限滚动
    open let isInfiniteScroll: Bool = true

    /// 滚动间隔时间
    open let autoScrollTime: TimeInterval = 5
    
    /// 倍数
    open let scrolTimes = 100
    
    /// 传入轮播图urls (至少一个)
    open var imgUrlsArray: NSMutableArray! {
        willSet {
            invalidateTimer()
            
            imgItemCounts = isInfiniteScroll ? (newValue.count * scrolTimes) : newValue.count
            pageControl.numberOfPages = newValue.count
            
            collectionView.reloadData()
        }
    }
    
    /// 占位图
    open var placehodlerImage: UIImage? = nil
    
    fileprivate let cellIdentifier = "cycleCell"
    
    /// layout
    fileprivate var flowLayout: UICollectionViewFlowLayout!
    
    /// 轮播承载视图
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = self.frame.size
        self.flowLayout = layout
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(CycleScrollCell.classForCoder(), forCellWithReuseIdentifier: self.cellIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate   = self
        
        self.addSubview(collectionView)
        
        return collectionView
    }()
    
    /// pageControl
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 0, y: self.bounds.height - 25, width: self.bounds.width, height: 30)
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .red
        pageControl.currentPageIndicatorTintColor = .blue
        
        self.insertSubview(pageControl, aboveSubview: self.collectionView)
        
        return pageControl
    }()
    
    /// 定时器
    fileprivate var timer: Timer?
    
    /// 具体显示个数
    fileprivate var imgItemCounts = 0
    
    // MARK: - Life Cycle 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        invalidateTimer()
    }
    
    // MARK: - Private Methods
    
    func cycleScrollViewAction() {
        let index = getItemIndex()
        let nextIndex = index + 1
        
        let indexPath = IndexPath(row: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func getImageIndex(_ index: Int) -> Int {
        return index % (imgUrlsArray.count)
    }
    
    func getItemIndex() -> Int {
        var index = 0
        let width = flowLayout.itemSize.width
        index = Int((collectionView.contentOffset.x + width * 0.5)) / Int(width)
        
        return index
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: self.autoScrollTime, repeats: true) { (_) in
            self.cycleScrollViewAction()
        }
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    func invalidateTimer() {
        if let _timer = timer {
            _timer.invalidate()
        }
    }
}

// MARK: - 
extension CycleScrollView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgItemCounts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CycleScrollCell
        
        //let item = indexPath.item % imgUrlsArray.count
        //let imgUrl = imgUrlsArray.object(at: item)
        
        cell.imageView.image = UIImage(named: "placeholder")
        
        return cell
    }
}

extension CycleScrollView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

// MARK: - 
extension CycleScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = getItemIndex()
        let imageIndex = getImageIndex(index)
        
        pageControl.currentPage = imageIndex
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}

