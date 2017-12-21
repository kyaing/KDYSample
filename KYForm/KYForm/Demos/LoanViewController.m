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
        KYFormObject *form = [KYFormObject formCreateWithTitle:@"贷款机构"];
        self.form = form;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
