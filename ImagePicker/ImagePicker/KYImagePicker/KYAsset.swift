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
    
    var phAsset: PHAsset
    
    init(phAsset asset: PHAsset) {
        phAsset = asset
    }
    
    typealias assetSuccessBlock = (UIImage, NSDictionary) -> Void
    
    // MARK: - Public Api
    
    /// 原图
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
    
    /// 指定的缩略图 (注意targetSize)
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
    
    /// 预览图
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
    
    /// 请求原图
    func requestOriginImage(assetBlock block: @escaping assetSuccessBlock) -> PHImageRequestID {
        return KYAssetManager.default.phCachingImageManger.requestImage(for: phAsset, targetSize:       PHImageManagerMaximumSize, contentMode: .default, options: nil) { (result, info) in
            if let _result = result, let _info = info {
                block(_result, _info as NSDictionary)
            }
        }
    }
    
    /// 请求指定大小图
    func requestThumbnailImage(_ size: CGSize, assetBlock block: @escaping assetSuccessBlock) -> PHImageRequestID {
        let scale = UIScreen.main.scale
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        return KYAssetManager.default.phCachingImageManger.requestImage(for: phAsset, targetSize: newSize, contentMode: .aspectFill, options: nil, resultHandler: { (result, info) in
            if let _result = result, let _info = info {
                block(_result, _info as NSDictionary)
            }
        })
    }
    
    /// 请求预览图
    func requestPreviewImage(assetBlock block: @escaping assetSuccessBlock) -> PHImageRequestID {
        
        return 0
    }
}

