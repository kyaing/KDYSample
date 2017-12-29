//
//  KYActionSheet.m
//  KYForm
//
//  Created by mac on 2017/12/26.
//

#import "KYActionSheet.h"
#import "KYActionSheetCell.h"

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
    return [self initWithTitle:nil cancelTitle:nil otherTitles:otherTitles];
}

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
                  otherTitles:(NSArray *)otherTitles {
    return [self initWithTitle:title cancelTitle:cancelTitle otherTitles:otherTitles];
}

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
                  otherTitles:(NSArray *)otherTitles
                sheetDelegate:(id<KYActionSheetDelegate>)delegate {
    
    if (self = [super init]) {
        self.title = title ?: @"";
        self.cancelTitle = cancelTitle ?: @"取消";
        self.sheetDelegate = delegate ?: nil;
        
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    
    
    [self addSubview:self.sheetTableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.sheetItems.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KYActionSheetCell *sheetCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return sheetCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - Public Methods

- (void)showSheet {
    [self showSheetWithBlock:nil];
}

- (void)showSheetWithBlock:(KYActionSheetBlock)sheetBlock {
    self.sheetBlock = sheetBlock;
    
    
}

#pragma mark - Setter & Getter

- (UITableView *)sheetTableView {
    if (!_sheetTableView) {
        _sheetTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_sheetTableView registerClass:[KYActionSheetCell class] forCellReuseIdentifier:cellIdentifier];
        _sheetTableView.separatorColor = [UIColor groupTableViewBackgroundColor];
        _sheetTableView.separatorInset = UIEdgeInsetsZero;
        _sheetTableView.dataSource = self;
        _sheetTableView.delegate = self;
        _sheetTableView.rowHeight = kCellHeight;
        
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
        _popWindow.frame = [UIScreen mainScreen].bounds;
        _popWindow.windowLevel = UIWindowLevelAlert;
        _popWindow.rootViewController = [[UIViewController alloc] init];
        
    }
    
    return _popWindow;
}

@end
