//
//  FormSectionModel.h
//  KYForm
//
//  Created by mac on 2017/12/21.
//

#import <Foundation/Foundation.h>

@class FormRowModel;

@interface FormSectionModel : NSObject

@property (nonatomic, copy)  NSString *key;         // key
@property (nonatomic, copy)  NSString *title;       // 头标题
@property (nonatomic, copy)  NSString *footerTitle; // 尾标题

@property (nonatomic, strong) NSArray<FormRowModel *> *rows;  // 所有行的数据

@end
