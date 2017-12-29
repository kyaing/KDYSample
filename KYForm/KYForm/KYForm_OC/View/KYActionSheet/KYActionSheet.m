//
//  KYActionSheet.m
//  KYForm
//
//  Created by mac on 2017/12/26.
//

#import "KYActionSheet.h"

@interface KYActionSheet () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *sheetTableView;
@property (nonatomic, strong) UIView      *sheetTitleView;

@end

@implementation KYActionSheet

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)setupViews {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - Properties

- (UITableView *)sheetTableView {
    if (!_sheetTableView) {
        _sheetTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _sheetTableView.dataSource = self;
        _sheetTableView.delegate = self;
    }
    
    return _sheetTableView;
}

- (UIView *)sheetTitleView {
    if (!_sheetTitleView) {
        _sheetTitleView = [[UIView alloc] init];
    }
    
    return _sheetTitleView;
}

@end
