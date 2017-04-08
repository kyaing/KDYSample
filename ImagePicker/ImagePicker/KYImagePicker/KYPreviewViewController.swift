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
    
    lazy var previewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.width, height: self.view.height)
        layout.scrollDirection = .horizontal
        
        return layout
    }()
    
    lazy var previewCollection: UICollectionView = {
        let collect: UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: self.view.width, height: self.view.height), collectionViewLayout: self.previewLayout)
        collect.register(UINib(nibName: "PreviewCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PreviewCell")
        collect.backgroundColor = .clear
        collect.showsHorizontalScrollIndicator = false
        collect.scrollsToTop = false
        
        collect.dataSource = self
        collect.delegate = self
        
        self.view.addSubview(collect)
        
        return collect
    }()
    
    var currentIndex: Int = 0
    
    var assetsArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupViews()
        previewCollection.contentOffset = CGPoint(x: 0, y: 0)
        previewCollection.contentSize = CGSize(width: CGFloat(assetsArray.count) * (self.view.width), height: 0)
        previewCollection.reloadData()
    }
    
    // MARK:
    
    func setupViews() {
        setupNaivgationBar()
        setupBottomToolBar()
    }
    
    func setupNaivgationBar() {
        
    }
    
    func setupBottomToolBar() {
        
    }
}

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

