//
//  SlideTabController.swift
//  SlideTabBar
//
//  Created by mac on 17/2/20.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

protocol SlideConcig {
    
}

open class SlideTabController: UIViewController {

    public enum SlideTabBarStyle {
        case `default`(UIColor?, UIColor?, CGFloat?, CGFloat?, CGFloat?)
        case underline(UIColor?, CGFloat?, CGFloat?, Bool)
        case titleScale
        case coverTitle
    }
    
    // MARK: - Properties
    
    /// 滑动的类型
    var style: SlideTabBarStyle?
    
    static let cellIdentifier = "slideCell"
    
    /// 标题字体大小
    var titleFont: UIFont = .systemFont(ofSize: 15)
    
    /// 标题默认颜色
    var titleNormalColor = UIColor.gray
    
    /// 标题选中颜色
    var titleSelectColor = UIColor.gray
    
    /// 标题高度
    public var titleHeight: CGFloat = 44.0
    
    /// 标题宽度
    var titleWidth: CGFloat = 0.0
    
    /// 标题间距
    public var titleMargin: CGFloat = 20.0
    
    /// 下划线高度
    var underlineHieght: CGFloat = 3.0
    
    /// 下划线颜色
    var underlineColor: UIColor = .red
    
    /// 选中的下标
    private var selectIndex: Int = 0
    
    /// 最后一次的偏移量
    var lastXOffset: CGFloat = 0
    
    let kFrameWidth  = UIScreen.main.bounds.width
    let kFrameHeight = UIScreen.main.bounds.height
    
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
        scrollView.backgroundColor = UIColor(white: 1, alpha: 0.6)
        scrollView.scrollsToTop = false
        
        scrollView.showsVerticalScrollIndicator   = false
        scrollView.showsHorizontalScrollIndicator = false
    
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
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.contentBgView.addSubview(collectionView)
        
        return collectionView
    }()
    
    /// 下划线视图
    lazy var underlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = self.underlineColor
        
        self.titleScrollView.addSubview(underlineView)
        
        return underlineView
    }()

    // MARK: - Life Cycle
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        collectionView.reloadData()
        
        setupTitleWidths()
        setupTitlesArray()
    }
    
    // MARK: - Public Methods
    
    /**
     *  设置顶部标题样式
     */
    public func setSlideSytle(_ slideStyle: SlideTabBarStyle) {
        
        style = slideStyle
        
        switch slideStyle {
        case .default(let color, let selColor, let font, let width, let height):
            setTitleDefaultStyle(color, selColor, font, width, height)
            
        case .underline(let color, let width, let height, let isEqual):
            setTitleUnderlineStyle(color, width, height, isEqual)
            
        case .titleScale: break
        case .coverTitle: break
        }
    }
    
    func setTitleDefaultStyle(_ norColor: UIColor?, _ selColor: UIColor?, _ font: CGFloat?, _ width: CGFloat?, _ height: CGFloat?) {
        if let norColor = norColor { titleNormalColor = norColor }
        
        if let selColor = selColor { titleSelectColor = selColor }
        
        if let font = font { titleFont = UIFont.systemFont(ofSize: font) }
        
        if let width = width { titleWidth = width }
        
        if let height = height { titleHeight = height }
    }
    
    func setTitleUnderlineStyle(_ color: UIColor?, _ width: CGFloat?, _ height: CGFloat?, _ isEqualToTitle: Bool = true) {
        if let color = color { underlineColor = color }
        
        if let height = height { underlineHieght = height }
    }
    
    func setTitleScaleStyle() {
        
    }
    
    func setTitleCoverStyle() {
        
    }
    
    // MARK: - Private Methods
    
    /**
     *  根据label字符串计算宽
     */
    private func getLableWidth(labelStr: String, font: UIFont) -> CGFloat {
        
        let statusLabelText = labelStr as NSString
        let size = CGSize(width: 800, height: 0)
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
        let margin = (totalWidth > kFrameWidth) ? titleMargin : (kFrameWidth - totalWidth) / CGFloat(marginCounts)
        
        titleScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: margin)
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
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickTitleAction(_:)))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(tapGesture)
            
            // 默认选中第一个title
            if index == selectIndex {
                clickTitleAction(tapGesture)
            }
            
            // 存储到顶部标题数组
            titleLabelsArray.add(label)
            titleScrollView.addSubview(label)
        }
    
        let lastLabel = titleLabelsArray.lastObject as! UILabel
        titleScrollView.contentSize = CGSize(width: lastLabel.frame.maxX, height: 0)
        
        let counts = self.childViewControllers.count
        collectionView.contentSize = CGSize(width: CGFloat(counts) * self.view.width, height: 0)
    }
    
    func setupUnderline(_ selLabel: UILabel) {
        let width = getLableWidth(labelStr: selLabel.text!, font: titleFont)
        
        // 设置下划线frame
        underlineView.y       = titleHeight - underlineHieght
        underlineView.width   = width
        underlineView.height  = underlineHieght
        
        // 初始化时不做动画
        if underlineView.x == 0 {
            underlineView.x = selLabel.x
            
        } else {
            UIView.animate(withDuration: 0.25) {
                self.underlineView.centerX = selLabel.centerX
            }
        }
    }
    
    // MARK: - Events Response
    
    /**
     *  点击标题事件
     */
    func clickTitleAction(_ sender: UITapGestureRecognizer) {
        
        let titleLabel = sender.view as! UILabel
        let index = titleLabel.tag
        
        let xOffset = CGFloat(index) * kFrameWidth
        collectionView.contentOffset = CGPoint(x: xOffset, y: 0)
        
        // 改变标题状态
        titleStateSelecting(titleLabel, style: style!)
        
        // 记录索引和偏移量
        selectIndex = index
        lastXOffset = xOffset
    }
    
    /**
     *  选中标题时更改样式
     */
    func titleStateSelecting(_ selLabel: UILabel,
                             style: SlideTabBarStyle = .default(nil, nil, nil, nil, nil)) {
        
        selLabel.textColor = titleSelectColor
        for lable in titleLabelsArray {
            if selLabel == (lable as! UILabel) {
                continue
            }
            (lable as! UILabel).textColor = titleNormalColor
        }
        
        // 居中显示
        setSeltitleToCenter(selLabel)
        
        switch style {
        case .underline(_, _, _, _):
            setupUnderline(selLabel)
        default:
            break
        }
    }
    
    /**
     *  设置选中标题居中
     */
    func setSeltitleToCenter(_ selLabel: UILabel) {
        
        var currentOffsetX = selLabel.center.x - kFrameWidth * 0.5
        var maxOffsetX = titleScrollView.contentSize.width - kFrameWidth + titleMargin
        
        // 滚动不足半屏
        if currentOffsetX < 0 {
            currentOffsetX = 0
        }
        
        // 滚动区域不足一屏
        if maxOffsetX < 0 {
            maxOffsetX = 0
        }
        
        // 超过最大滚动区域
        if currentOffsetX > maxOffsetX {
            currentOffsetX = maxOffsetX
        }
        
        titleScrollView.setContentOffset(CGPoint(x: currentOffsetX, y: 0), animated: true)
    }
    
    /**
     *  设置下划线动画
     */
    func setUnderlineAnimation(_ leftLabel: UILabel, _ rightLabel: UILabel, _ offset: CGFloat) {
        
        let centerDiff = rightLabel.x - leftLabel.x
        let offsetDiff = offset - lastXOffset
        
        let widthDiff  = getLableWidth(labelStr: rightLabel.text!, font: titleFont) - getLableWidth(labelStr: leftLabel.text!, font: titleFont)
        
        // xPos和增长的宽度的比例值
        let xTransform  = centerDiff * (offsetDiff / kFrameWidth)
        let updateWidth = widthDiff * (offsetDiff / kFrameWidth)
        
        underlineView.x += xTransform
        underlineView.width += updateWidth
    }
}

// MARK: -
extension SlideTabController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childViewControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideTabController.cellIdentifier, for: indexPath)
        
        let controller = self.childViewControllers[indexPath.item] as UIViewController
        controller.view.frame = CGRect(x: 0, y: 0, width: collectionView.width, height: collectionView.height)
        cell.contentView.addSubview(controller.view)
        
        return cell
    }
}

extension SlideTabController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - 
extension SlideTabController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let xOffset = scrollView.contentOffset.x
        let index = xOffset / kFrameWidth
        
        let leftLabel = titleLabelsArray[Int(index)] as! UILabel
        var rightLabel: UILabel? = nil
        
        // 最后一个标题后面没有 rightLabel
        if Int(index) < titleLabelsArray.count - 1 {
            rightLabel = titleLabelsArray[Int(index)+1] as? UILabel
        }
        
        // 先设置下划线动画
        if let rightLabel = rightLabel {
            setUnderlineAnimation(leftLabel, rightLabel, xOffset)
        }
        
        // 再更新偏移量
        lastXOffset = xOffset
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let xOffset = scrollView.contentOffset.x
        let index = xOffset / kFrameWidth
    
        // 选中标题
        titleStateSelecting(titleLabelsArray[Int(index)] as! UILabel)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}

