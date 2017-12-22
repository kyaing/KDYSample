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
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *modelArray = JsonToModel(@"personal.json");
        
        for (NSDictionary *dict in modelArray) {
            FormSectionModel *sectionModel = [FormSectionModel modelWithDictionary:dict];
            [array addObject:sectionModel];
        }
        
        KYFormObject *form = [KYFormObject formCreateWithTitle:@"个人中心"];
        form.dataSource = array;
        
        self.form = form;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
