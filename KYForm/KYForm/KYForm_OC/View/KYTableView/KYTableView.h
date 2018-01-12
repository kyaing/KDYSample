//
//  KYTableView.h
//  KYForm
//
//  Created by mac on 2018/1/4.
//

#import <UIKit/UIKit.h>
#import "KYTableViewDataSource.h"
#import "KYTableViewDelegate.h"

@interface KYTableView : UIView <KYTableViewDataSource, KYTableViewDelegate>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *datasArray;

@property (nonatomic, weak) id <KYTableViewDataSource> dataSource;
@property (nonatomic, weak) id <KYTableViewDelegate> delegate;

@end
