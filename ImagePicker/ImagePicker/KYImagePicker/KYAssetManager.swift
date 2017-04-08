//
//  KYAssetManager.swift
//  ImagePicker
//
//  Created by mac on 17/4/7.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Photos

/// 相册的管理类
class KYAssetManager: NSObject {
    
    let phCachingImageManger = PHCachingImageManager()
    
    static var `default` = KYAssetManager()
    
    fileprivate override init() {
        super.init()
    }
    
    typealias enumerationAllGroupBlock = (KYAssetGroup?) -> Void
    
    // MARK: - Public Api
    
    /// 遍历所有相册中所有资源
    func enumerationGroupAssets(groupBlock block: enumerationAllGroupBlock) {
        let albumsArray = NSMutableArray()
        
        let fetchOptions = PHFetchOptions()
        let smartResults = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
        
        // 遍历系统相册
        for i in 0..<smartResults.count {
            let collection: PHCollection = smartResults[i]
            
            if collection.isKind(of: PHAssetCollection.classForCoder()) {
                let assetCollection = collection as! PHAssetCollection
                let fetchResult = PHAsset.fetchAssets(in: assetCollection, options: fetchOptions)
                
                // 过滤空相册
                if fetchResult.count > 0 {
                    albumsArray.add(assetCollection)
                }
            }
        }
        
        let userResults = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        
        // 遍历用户创建的相册
        for i in 0..<userResults.count {
            let collection: PHCollection = userResults[i]
            
            if collection.isKind(of: PHAssetCollection.classForCoder()) {
                let assetCollection = userResults[i] as! PHAssetCollection
                let fetchResult = PHAsset.fetchAssets(in: assetCollection, options: fetchOptions)
                
                if fetchResult.count > 0 {
                    albumsArray.add(assetCollection)
                }
            }
        }
        
        // 遍历所有的相册
        for i in 0..<albumsArray.count {
            let assetColletion = albumsArray[i] as! PHAssetCollection
            let groups = KYAssetGroup(phAssetCollection: assetColletion, phFetchOptions: fetchOptions)
            block(groups)
        }
        
        block(nil)   // 结束遍历的标志
    }
}

