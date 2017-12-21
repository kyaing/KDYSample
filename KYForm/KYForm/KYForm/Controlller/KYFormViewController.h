//
//  KYFormViewController.h
//  KYForm
//
//  Created by mac on 2017/12/18.
//

#import <UIKit/UIKit.h>
#import "KYForm.h"

@interface KYFormViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) KYFormObject  *form;
@property (nonatomic, strong) UITableView   *fromTableView;

- (instancetype)initWithForm:(KYFormObject *)form;
- (instancetype)initWithForm:(KYFormObject *)form tableStyle:(UITableViewStyle)style;

+ (NSMutableDictionary *)cellClassesForRowTypes;

@end
