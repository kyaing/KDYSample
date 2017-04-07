//
//  KYAsset.swift
//  ImagePicker
//
//  Created by mac on 17/4/7.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Photos

/// 相册中一个资源
class KYAsset: NSObject {
    
    enum AssetType {
        case image
        case video
        case audio
        case unknow
    }
    
    var phAsset: PHAsset
    
    var phType: KYAsset.AssetType?
    
    init(phAsset asset: PHAsset) {
        phAsset = asset
    }
    
    // MARK: - Public Api
    
    /// 获取原图
    func originImage() -> UIImage {
        let imageRequestOption = PHImageRequestOptions()
        var resultImage = UIImage()
        
        KYAssetManager.default.phCachingImageManger.requestImage(for: phAsset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: imageRequestOption) { (image, dict) in
            if let _image = image {
                resultImage = _image
            }
        }
        
        return resultImage
    }
    
    /// 获取指定的缩略图 (注意targetSize)
    func thumbnailImage(_ size: CGSize) -> UIImage {
        let imageRequestOption = PHImageRequestOptions()
        var resultImage = UIImage()
        
        let scale = UIScreen.main.scale
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        KYAssetManager.default.phCachingImageManger.requestImage(for: phAsset, targetSize: newSize, contentMode: .aspectFill, options: imageRequestOption) { (image, dict) in
            if let _image = image {
                resultImage = _image
            }
        }
        
        return resultImage
    }
    
    /// 获取预览图
    func previewImage() -> UIImage {
        let imageRequestOption = PHImageRequestOptions()
        var resultImage = UIImage()
        
        let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        KYAssetManager.default.phCachingImageManger.requestImage(for: phAsset, targetSize: size, contentMode: .aspectFill, options: imageRequestOption) { (image, dict) in
            if let _image = image {
                resultImage = _image
            }
        }
        
        return resultImage
    }
}

