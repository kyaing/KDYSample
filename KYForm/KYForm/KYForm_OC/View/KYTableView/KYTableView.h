//
//  KYTableView.h
//  KYForm
//
//  Created by mac on 2018/1/4.
//

#import <UIKit/UIKit.h>
#import "KYTableViewDataSource.h"
#import "KYTableViewDelegate.h"

@interface KYTableView : UITableView <UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *datasArray;

@property (nonatomic, weak) id <KYTableViewDataSource> kyDataSource;
@property (nonatomic, weak) id <KYTableViewDelegate> kyDelegate;

@end
