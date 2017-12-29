//
//  KYActionSheetItem.m
//  KYForm
//
//  Created by mac on 2017/12/28.
//

#import "KYActionSheetItem.h"

@implementation KYActionSheetItem

+ (instancetype)initWithTitle:(NSString *)title {
    return [KYActionSheetItem initWithTitle:title image:nil];
}

+ (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image {
    return [KYActionSheetItem initWithTitle:title image:image type:KYActionSheetItemTypeNormal];
}

+ (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image type:(KYActionSheetItemType)type {
    KYActionSheetItem *sheetItem = [[KYActionSheetItem alloc] init];
    sheetItem.title = title;
    sheetItem.image = image;
    sheetItem.type  = type;
    
    return sheetItem;
}

@end
