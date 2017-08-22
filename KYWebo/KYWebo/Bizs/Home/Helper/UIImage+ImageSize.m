//
//  UIImage+ImageSize.m
//  KYWebo
//
//  Created by KYCoder on 2017/8/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIImage+ImageSize.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (ImageSize)

+ (CGSize)getImageSizeWithURL:(id)URL {
    NSURL * url = nil;
    
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    
    if (!URL) {
        return CGSizeZero;
    }
    
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
            
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    
    return CGSizeMake(width, height);
}

@end

