//
//  PersonalViewController.m
//  KYForm
//
//  Created by mac on 2017/12/21.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (instancetype)init {
    if (self = [super init]) {
        KYFormObject *form = [KYFormObject formCreateWithTitle:@"个人中心"];
        self.form = form;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
