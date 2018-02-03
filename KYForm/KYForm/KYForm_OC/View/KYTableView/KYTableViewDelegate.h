//
//  KYTableViewDelegate.h
//  KYForm
//
//  Created by mac on 2018/1/4.
//

#import <UIKit/UIKit.h>

@class KYTableViewSectionObject;
@protocol KYTableViewDelegate <UITableViewDelegate>

@optional

- (void)didSelectObject:(id)object forIndexPath:(NSIndexPath *)indexPath;
- (UIView *)headerViewForSectionObject:(KYTableViewSectionObject *)sectionObject forSection:(NSInteger)section;
- (UIView *)footerViewForSectionObject:(KYTableViewSectionObject *)sectionObject forSection:(NSInteger)section;

- (void)pullUpToRefresh;
- (void)pullDownToRefresh;

@end
