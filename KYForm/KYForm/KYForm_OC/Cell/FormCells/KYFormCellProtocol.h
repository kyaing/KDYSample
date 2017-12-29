//
//  KYFormCellProtocol.h
//  KYForm
//
//  Created by mac on 2017/12/26.
//

#import <UIKit/UIKit.h>

@class KYFormRowItem;
@class KYFormViewController;

@protocol KYFormCellProtocol <NSObject>

@required
- (void)setupView;
- (void)configure;

@optional
- (void)formCellDidSelectedWithController:(KYFormViewController *)controller;
+ (CGFloat)formCellHeightForRowObject:(KYFormRowItem *)rowObject;

@end


