//
//  KYActionSheetItem.h
//  KYForm
//
//  Created by mac on 2017/12/28.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KYActionSheetItemType) {
    KYActionSheetItemTypeNormal = 0,  // 普通
    KYActionSheetItemTypeHighlight    // 高亮
};

@interface KYActionSheetItem : NSObject

@property (nonatomic, copy  ) NSString *title;  // 标题
@property (nonatomic, strong) UIImage  *image;  // 图片
@property (nonatomic, assign) KYActionSheetItemType type;  // item的状态

+ (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                         type:(KYActionSheetItemType)type;

@end
