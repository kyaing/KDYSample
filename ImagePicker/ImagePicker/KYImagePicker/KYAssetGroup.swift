//
//  KYAssetGroup.swift
//  ImagePicker
//
//  Created by mac on 17/4/7.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Photos

/// 相册或资源集合
class KYAssetGroup: NSObject {

    var phAssetCollection: PHAssetCollection
    
    var phFetchResult: PHFetchResult<AnyObject>
    
    /// 相册名称
    var groupName: String? {
        let resultName = phAssetCollection.localizedTitle
        return NSLocalizedString(resultName!, comment: resultName!)
    }
    
    /// 相册内资源数量
    var numberOfGroup: Int {
        return phFetchResult.count
    }
    
    typealias enumerationGroupBlock = (KYAsset?) -> Void
    
    init(phAssetCollection assetCollection: PHAssetCollection, phFetchOptions fetchOptions: PHFetchOptions?) {
        let fetchResult = PHAsset.fetchAssets(in: assetCollection, options: fetchOptions)
        phFetchResult = fetchResult as! PHFetchResult<AnyObject>
        
        phAssetCollection = assetCollection
    }
    
    // MARK: - Public Api
    
    /// 获取相册封面图
    func posterImage(_ size: CGSize) -> UIImage {
        var resultImage = UIImage()
        
        let imageRequestOption = PHImageRequestOptions()
        imageRequestOption.isSynchronous = true
        imageRequestOption.resizeMode = .exact
        
        // 取相册最后一张
        let phAsset = phFetchResult[numberOfGroup-1] as! PHAsset
        
        let scale = UIScreen.main.scale
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        KYAssetManager.default.phCachingImageManger.requestImage(for: phAsset, targetSize: newSize, contentMode: .aspectFill, options: imageRequestOption) { (image, dict) in
            if let _image = image {
                resultImage = _image
            }
        }
        
        return resultImage
    }
    
    /// 遍历相册中所有资源
    func enumerationGroupAssets(assetBlock block: enumerationGroupBlock) {
        for i in numberOfGroup-1...0 {
            let phAsset = phFetchResult[i] as! PHAsset
            let asset = KYAsset(phAsset: phAsset)
            
            block(asset)
        }
        
        block(nil)  // 遍历结束后，传入nil作为标志符
    }
}

