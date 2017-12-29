//
//  KYFormSectionItem.h
//  KYForm
//
//  Created by mac on 2017/12/19.
//

#import <Foundation/Foundation.h>
#import "KYFormRowItem.h"
#import "FormSectionModel.h"

@interface KYFormSectionItem : NSObject

@property (nonatomic, copy )  NSString  *title;
@property (nonatomic, copy )  NSString  *footerTitle;

@property (nonatomic, strong) NSMutableArray<KYFormRowItem *> *formRows;
@property (nonatomic, strong) FormSectionModel *sectionModel;  // 分组的数据源

+ (instancetype)formSection;
+ (instancetype)formSectionWithTitle:(NSString *)title;
+ (instancetype)formSectoinWithModel:(FormSectionModel *)model;

@end
