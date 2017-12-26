//
//  KYFormViewController.m
//  KYForm
//
//  Created by mac on 2017/12/18.
//

#import "KYFormViewController.h"
#import "KYForm.h"

@interface KYFormViewController ()

@property (nonatomic, assign) UITableViewStyle style;

@end

@implementation KYFormViewController

#pragma mark - Life Cycle

- (instancetype)initWithForm:(KYFormObject *)form {
    return [self initWithForm:form tableStyle:UITableViewStylePlain];
}

- (instancetype)initWithForm:(KYFormObject *)form tableStyle:(UITableViewStyle)style {
    if (self = [super init]) {
        self.form = form;
        self.style = style;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _form.title;
    [self.view addSubview:self.fromTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)dealloc {
    self.fromTableView.dataSource = nil;
    self.fromTableView.delegate = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.form.formSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.form.formSections objectAtIndex:section].formRows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KYFormRowObject *formRow = [self.form formRowAtIndex:indexPath];
    [self updateWithRow:formRow];
    
    return [formRow cellForFormController:self];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KYFormRowObject *formRow = [self.form formRowAtIndex:indexPath];
    [self didSelectFormRow:formRow];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.form.formSections objectAtIndex:section].title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [self.form.formSections objectAtIndex:section].footerTitle;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    header.textLabel.textColor = [UIColor black33];
    header.textLabel.font = BFont(14);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

#pragma mark - Public Methods

- (KYFormBaseCell *)updateWithRow:(KYFormRowObject *)rowObject {
    KYFormBaseCell *cell = [rowObject cellForFormController:self];
    cell.rowModel = rowObject.rowModel;
    
    return cell;
}

- (void)didSelectFormRow:(KYFormRowObject *)rowObject {
    KYFormBaseCell *cell = [rowObject cellForFormController:self];
}

+ (NSMutableDictionary *)cellClassesForRowTypes {
    static NSMutableDictionary *shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [@{
                           kFormRowTypeAvatar:  [KYFormAvatarCell class],
                           kFormRowTypeText:    [KYFormTextFieldCell class],
                           kFormRowTypePhone:   [KYFormTextFieldCell class],
                           kFormRowTypeMail:    [KYFormTextFieldCell class],
                           kFormRowTypeNumber:  [KYFormTextFieldCell class],
                           kFormRowTypePassword: [KYFormBaseCell class],
                           kFormRowTypeDate:    [KYFormBaseCell class],
                           kFormRowTypePicker:  [KYFormBaseCell class],
                           kFormRowTypeSwitch:  [KYFormBaseCell class],
                           kFormRowTypeTextView:    [KYFormBaseCell class],
                           kFormRowTypeChoosePush:  [KYFormBaseCell class],
                           kFormRowTypeChoosePop:   [KYFormBaseCell class],
                           kFormRowTypeActionSheet: [KYFormBaseCell class]
                          } mutableCopy];
    });
    
    return shareInstance;
}

#pragma mark - Properties

- (UITableView *)fromTableView {
    if (!_fromTableView) {
        _fromTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _fromTableView.backgroundColor = [UIColor whiteColor];
        _fromTableView.separatorColor = [UIColor colorWithHexString:@"#f3f3f3"];
        _fromTableView.showsVerticalScrollIndicator = NO;
        _fromTableView.dataSource = self;
        _fromTableView.delegate = self;
    }
    
    return _fromTableView;
}

- (void)setForm:(KYFormObject *)form {
    _form = form;

    if (self.isViewLoaded) {
        [self.fromTableView reloadData];
    }    
}

@end
