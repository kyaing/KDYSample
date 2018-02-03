//
//  KYTableViewDataSource.h
//  KYForm
//
//  Created by mac on 2018/1/4.
//

#import <UIKit/UIKit.h>

@class KYTableViewItemObject;
@protocol KYTableViewDataSource <UITableViewDataSource>

@optional

- (KYTableViewItemObject *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;
- (Class)tableView:(UITableView *)tableView cellClassForObject:(KYTableViewItemObject *)itemObject;

@end
