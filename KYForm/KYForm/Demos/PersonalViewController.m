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
    
    NSMutableArray *dataSource = [NSMutableArray array];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Personal" ofType:@"json"]];
    NSMutableDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *array = [dataDic objectForKey:@"details"];
    
    for (NSDictionary *dict in array) {
        FormSectionModel *sectionModel = [FormSectionModel modelWithDictionary:dict];
        [dataSource addObject:sectionModel];
    }
}

@end
