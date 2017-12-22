//
//  KYFormBaseCell.h
//  KYForm
//
//  Created by mac on 2017/12/20.
//

#import <UIKit/UIKit.h>
#import "FormRowModel.h"

@interface KYFormBaseCell : UITableViewCell

@property (nonatomic, strong) FormRowModel *rowModel;

- (void)setupView;
- (void)configure;

@end
