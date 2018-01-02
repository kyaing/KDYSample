//
//  KYActionSheet.h
//  KYForm
//
//  Created by mac on 2017/12/26.
//

#import <UIKit/UIKit.h>

@class KYActionSheet;
@protocol KYActionSheetDelegate <NSObject>
- (void)kyAtionSheetClick:(KYActionSheet *)actonSheet atIndex:(NSInteger)index;

@end

typedef void(^KYActionSheetBlock)(NSInteger sheetIndex);

@interface KYActionSheet : UIView

- (instancetype)initWithTitles:(NSArray *)otherTitles;

- (instancetype)initWithTitles:(NSArray *)otherTitles hightlightTitle:(NSString *)hightlightTitle;

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
                  otherTitles:(NSArray *)otherTitles
              hightlightTitle:(NSString *)hightlightTitle;

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
              hightlightTitle:(NSString *)hightlightTitle
                  otherTitles:(NSArray *)otherTitles
                  sheetDelegate:(id<KYActionSheetDelegate>)delegate;

- (void)showSheet;
- (void)showSheetWithBlock:(KYActionSheetBlock)sheetBlock;

@end
