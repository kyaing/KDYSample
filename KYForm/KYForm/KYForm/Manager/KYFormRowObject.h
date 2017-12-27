//
//  KYFormRowObject.h
//  KYForm
//
//  Created by mac on 2017/12/19.
//

#import <UIKit/UIKit.h>

@class KYFormBaseCell;
@class FormRowModel;
@class KYFormViewController;

@interface KYFormRowObject : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *rowType;
@property (nonatomic, strong) id cellClass;
@property (nonatomic, strong) id value;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic) CGFloat rowHeight;
@property (nonatomic, strong) NSMutableArray *validators; // 校验数组

@property (nonatomic, strong) KYFormBaseCell *baseCell;  
@property (nonatomic, strong) FormRowModel   *rowModel;   // 行的数据源

+ (instancetype)formRowWithTitle:(NSString *)title;
+ (instancetype)formRowWithTitle:(NSString *)title rowType:(NSString *)rowType;
+ (instancetype)formRowWithModel:(FormRowModel *)model;

- (KYFormBaseCell *)cellForFormController:(KYFormViewController *)formController;

@end
