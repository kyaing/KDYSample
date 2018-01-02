//
//  KYActionSheet.m
//  KYForm
//
//  Created by mac on 2017/12/26.
//

#import "KYActionSheet.h"
#import "KYActionSheetCell.h"
#import "UIColor+Extensions.h"

static NSString *cellIdentifier = @"KYActionSheetCell";
static CGFloat kCellHeight = 44;

@interface KYActionSheet () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy  ) NSString       *title;
@property (nonatomic, copy  ) NSString       *cancelTitle;
@property (nonatomic, strong) NSMutableArray *sheetItems;
@property (nonatomic, weak  ) id <KYActionSheetDelegate> sheetDelegate;
@property (nonatomic, copy  ) KYActionSheetBlock sheetBlock;

@property (nonatomic, strong) UIWindow    *popWindow;       // 弹出的UIWindow
@property (nonatomic, strong) UIView      *controllerView;  // 弹出控制器的View
@property (nonatomic, strong) UIView      *coverBgView;     // 遮盖背景View
@property (nonatomic, strong) UITableView *sheetTableView;
@property (nonatomic, strong) UILabel     *sheetTitleLabel;

@end

@implementation KYActionSheet

#pragma mark - Life Cycle

- (instancetype)initWithTitles:(NSArray *)otherTitles {
    return [self initWithTitles:otherTitles hightlightTitle:nil];
}

- (instancetype)initWithTitles:(NSArray *)otherTitles hightlightTitle:(NSString *)hightlightTitle {
    return [self initWithTitle:nil cancelTitle:nil
               hightlightTitle:hightlightTitle otherTitles:otherTitles sheetDelegate:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
                  otherTitles:(NSArray *)otherTitles
              hightlightTitle:(NSString *)hightlightTitle {
    
    return [self initWithTitle:title cancelTitle:cancelTitle
               hightlightTitle:hightlightTitle otherTitles:otherTitles sheetDelegate:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
              hightlightTitle:(NSString *)hightlightTitle
                  otherTitles:(NSArray *)otherTitles
                sheetDelegate:(id<KYActionSheetDelegate>)delegate {
    
    if (self = [super init]) {
        self.title = title ?: @"";
        self.cancelTitle = cancelTitle ?: @"取消";
        self.sheetDelegate = delegate ?: nil;
        self.backgroundColor = [UIColor colorWithHexString:@"#e3e3e3"];
        
        self.sheetItems = [NSMutableArray array];
        for (NSString *title in otherTitles) {
            KYActionSheetItem *item = [KYActionSheetItem initWithTitle:title];
            [_sheetItems addObject:item];
        }
        
        if (hightlightTitle.length > 0) {
            KYActionSheetItem *item =
                [KYActionSheetItem initWithTitle:hightlightTitle image:nil type:KYActionSheetItemTypeHighlight];
            [_sheetItems addObject:item];
        }
        
        [self addSubview:self.sheetTableView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.sheetTableView.frame = self.bounds;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.sheetItems.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KYActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[KYActionSheetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.sheetItem = _sheetItems[indexPath.row];
    } else {
        KYActionSheetItem *cancelItem = [KYActionSheetItem initWithTitle:_cancelTitle];
        cell.sheetItem = cancelItem;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideSheetWithBlock:^{
            if (indexPath.section == 0) {
                if (weakSelf.sheetBlock) {
                    weakSelf.sheetBlock(indexPath.row);
                }
                
                if (weakSelf.sheetDelegate && [weakSelf.sheetDelegate respondsToSelector:@selector(kyAtionSheetClick:atIndex:)]) {
                    [weakSelf.sheetDelegate kyAtionSheetClick:self atIndex:indexPath.row];
                }
            }
        }];
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 0) ? CGFLOAT_MIN : 10;
}

#pragma mark - Sheet Methods

- (void)showSheet {
    [self showSheetWithBlock:nil];
}

- (void)showSheetWithBlock:(KYActionSheetBlock)sheetBlock {
    self.sheetBlock = sheetBlock;
    
    [self.sheetTableView reloadData];
    [self.popWindow makeKeyAndVisible];
    
    [_controllerView addSubview:self.coverBgView];
    [_controllerView addSubview:self];
    
    CGFloat xPos  = 0;
    CGFloat yPos  = CGRectGetMaxY(_controllerView.frame);
    CGFloat width = CGRectGetWidth(_controllerView.frame);
    CGFloat hight = _sheetTableView.contentSize.height;
    self.frame = CGRectMake(xPos, yPos, width, hight);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _coverBgView.alpha = 0.5;
        
        CGRect newFrame = self.frame;
        newFrame.origin.y = CGRectGetMaxY(_controllerView.frame) - hight;
        self.frame = newFrame;
        
    } completion:^(BOOL finished) {
    }];
}

- (void)hideSheet {
    [self hideSheetWithBlock:nil];
}

- (void)hideSheetWithBlock:(void(^)(void))block {
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _coverBgView.alpha = 0;
        
        CGRect newFrame = self.frame;
        newFrame.origin.y = CGRectGetMaxY(_controllerView.frame);
        self.frame = newFrame;
        
    } completion:^(BOOL finished) {
        [self.sheetTableView removeFromSuperview];
        [self.coverBgView removeFromSuperview];
        [self.popWindow removeFromSuperview];
        
        self.sheetTableView = nil;
        self.coverBgView = nil;
        self.popWindow = nil;
        
        if (block) {
            block();
        }
    }];
}

#pragma mark - Events Response

- (void)clickCoverBgGesture:(UIGestureRecognizer *)gesture {
    [self hideSheetWithBlock:nil];
}

#pragma mark - Setter & Getter

- (UITableView *)sheetTableView {
    if (!_sheetTableView) {
        _sheetTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _sheetTableView.backgroundColor = self.backgroundColor;
        _sheetTableView.separatorColor = [UIColor groupTableViewBackgroundColor];
        _sheetTableView.separatorInset = UIEdgeInsetsZero;
        _sheetTableView.scrollEnabled = NO;
        _sheetTableView.dataSource = self;
        _sheetTableView.delegate = self;
        
        _sheetTableView.rowHeight = kCellHeight;
        _sheetTableView.estimatedRowHeight = 0;
        _sheetTableView.estimatedSectionHeaderHeight = 0;
        _sheetTableView.estimatedSectionFooterHeight = 0;
        
        if (_title.length > 0) {  // 有标题时创建头视图
            _sheetTableView.tableHeaderView = [self sheetHeaderView];
        }
    }
    
    return _sheetTableView;
}

- (UIView *)sheetHeaderView {
    UIView *headerView = [[UIView alloc] init];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [headerView addSubview:label];
    
    self.sheetTitleLabel = label;
    
    return headerView;
}

- (UIWindow *)popWindow {
    if (!_popWindow) {
        _popWindow = [[UIWindow alloc] init];
        _popWindow.backgroundColor = [UIColor clearColor];
        _popWindow.frame = [UIScreen mainScreen].bounds;
        _popWindow.rootViewController = [[UIViewController alloc] init];
        
        _controllerView = _popWindow.rootViewController.view;
    }
    
    return _popWindow;
}

- (UIView *)coverBgView {
    if (!_coverBgView) {
        _coverBgView = [[UIView alloc] init];
        _coverBgView.frame = _controllerView.bounds;
        _coverBgView.backgroundColor = [UIColor blackColor];
        _coverBgView.userInteractionEnabled = YES;
        _coverBgView.alpha = 0;
        
        [_coverBgView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(clickCoverBgGesture:)]];
    }
    
    return _coverBgView;
}

@end
