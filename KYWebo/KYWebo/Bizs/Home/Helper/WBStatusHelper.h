//
//  WBStatusHelper.h
//  YYKitExample
//
//  Created by ibireme on 15/9/5.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import <YYKit/YYKit.h>

@interface WBStatusHelper : NSObject

/// 微博图片 cache
+ (YYMemoryCache *)imageCache;

/// 从path创建图片 (有缓存)
+ (UIImage *)imageWithPath:(NSString *)path;

@end
