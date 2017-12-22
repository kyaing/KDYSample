//
//  PersonalViewController.m
//  KYForm
//
//  Created by mac on 2017/12/21.
//

#import "PersonalViewController.h"

@interface PersonalViewController () {
    NSMutableArray *dataSource;
}

@end

@implementation PersonalViewController

- (instancetype)init {
    if (self = [super init]) {
        dataSource = [NSMutableArray array];
        
        NSMutableArray *modelArray = JsonToModel(@"personal.json");
        for (NSDictionary *dict in modelArray) {
            FormSectionModel *sectionModel = [FormSectionModel modelWithDictionary:dict];
            [dataSource addObject:sectionModel];
        }
        
        KYFormObject *form = [KYFormObject formCreateWithTitle:@"个人中心"];
        form.dataSource = dataSource;
        self.form = form;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
