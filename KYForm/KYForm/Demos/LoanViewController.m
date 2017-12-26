//
//  LoanViewController.m
//  KYForm
//
//  Created by mac on 2017/12/21.
//

#import "LoanViewController.h"

@interface LoanViewController ()

@end

@implementation LoanViewController

- (instancetype)init {
    if (self = [super init]) {
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *modelArray = JsonToModel(@"Loaninfo.json");
        
        for (NSDictionary *dict in modelArray) {
            FormSectionModel *sectionModel = [FormSectionModel modelWithDictionary:dict];
            [array addObject:sectionModel];
        }
        
        KYFormObject *form = [KYFormObject formCreateWithTitle:@"贷款机构"];
        form.dataSource = array;
        self.form = form;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
