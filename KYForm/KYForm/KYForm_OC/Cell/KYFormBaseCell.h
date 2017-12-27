//
//  KYFormBaseCell.h
//  KYForm
//
//  Created by mac on 2017/12/20.
//

#import <UIKit/UIKit.h>
#import "FormRowModel.h"
#import "KYFormCellProtocol.h"

@interface KYFormBaseCell : UITableViewCell <KYFormCellProtocol>

@property (nonatomic, strong) FormRowModel *rowModel;

@end
