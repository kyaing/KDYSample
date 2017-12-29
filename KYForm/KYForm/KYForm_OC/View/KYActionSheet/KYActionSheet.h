//
//  KYActionSheet.h
//  KYForm
//
//  Created by mac on 2017/12/26.
//

#import <UIKit/UIKit.h>

@class KYActionSheet;
@protocol KYActionSheetDelegate <NSObject>
- (void)kyAtionSheetClickWith:(KYActionSheet *)actonSheet atIndex:(NSInteger)index;

@end

typedef void(^KYActionSheetBlock)(NSInteger sheetIndex);

@interface KYActionSheet : UIView

- (instancetype)initWithTitles:(NSArray *)otherTitles;

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
                  otherTitles:(NSArray *)otherTitles;

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
                  otherTitles:(NSArray *)otherTitles
                  sheetDelegate:(id<KYActionSheetDelegate>)delegate;

- (void)showSheet;
- (void)showSheetWithBlock:(KYActionSheetBlock)sheetBlock;

@end
