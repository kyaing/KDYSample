//
//  KYFormSectionObject.h
//  KYForm
//
//  Created by mac on 2017/12/19.
//

#import <Foundation/Foundation.h>

@class KYFormRowObject;

@interface KYFormSectionObject : NSObject

@property (nonatomic, copy )  NSString  *title;
@property (nonatomic, copy )  NSString  *footerTitle;
@property (nonatomic, strong) NSMutableArray<KYFormRowObject *> *formRows;

+ (instancetype)formSection;
+ (instancetype)formSectionWithTitle:(NSString *)title;

@end
