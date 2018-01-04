//
//  KYFormListViewController.m
//  KYForm
//
//  Created by mac on 2017/12/22.
//

#import "KYFormListViewController.h"

@interface KYFormListViewController ()

@property (nonatomic, strong) UITableView    *listTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation KYFormListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.listTableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (UITableView *)listTableView {
    if (!_listTableView) {
        
    }
    
    return _listTableView;
}

@end
