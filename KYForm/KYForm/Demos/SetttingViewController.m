//
//  SetttingViewController.m
//  KYForm
//
//  Created by mac on 2017/12/21.
//

#import "SetttingViewController.h"

@interface SetttingViewController ()

@end

@implementation SetttingViewController

- (instancetype)init {
    if (self = [super init]) {
        KYFormObject *form = [KYFormObject formCreateWithTitle:@"设置中心"];
        self.form = form;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
