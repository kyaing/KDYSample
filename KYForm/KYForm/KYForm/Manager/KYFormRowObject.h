//
//  KYFormRowObject.h
//  KYForm
//
//  Created by mac on 2017/12/19.
//

#import <UIKit/UIKit.h>

@class KYFormBaseCell;
@class KYFormViewController;

@interface KYFormRowObject : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *rowType;
@property (nonatomic, assign) CGFloat   height;
@property (nonatomic, strong) id cellClass;
@property (nonatomic, strong) id value;
@property (nonatomic, assign)   UITableViewStyle cellStyle;

+ (instancetype)formRowWithTitle:(NSString *)title;
+ (instancetype)formRowWithTitle:(NSString *)title rowType:(NSString *)rowType;

- (KYFormBaseCell *)cellForFormController:(KYFormViewController *)formController;

@end
