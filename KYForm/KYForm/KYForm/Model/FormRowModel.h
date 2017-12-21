//
//  FormRowModel.h
//  KYForm
//
//  Created by mac on 2017/12/21.
//

#import <Foundation/Foundation.h>

@class FormRowListModel;

@interface FormRowModel : NSObject

@property (nonatomic, copy) NSString *key;       // key
@property (nonatomic, copy) NSString *title;     // 标题
@property (nonatomic, copy) NSString *value;     // 值
@property (nonatomic, copy) NSString *tip;       // 默认的提示语
@property (nonatomic, copy) NSString *verifyTip; // 合法性提示语

@property (nonatomic, strong) FormRowListModel *listModel;  // 选择列表的数据源

@end

@interface FormRowListModel: NSObject

@property (nonatomic, strong) NSString *key;     // @"key": @"value"，如 0: @"男"，1: @"女"
@property (nonatomic, strong) NSString *value;

@end
