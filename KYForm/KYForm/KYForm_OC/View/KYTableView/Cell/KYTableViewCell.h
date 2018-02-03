//
//  KYTableViewCell.h
//  KYForm
//
//  Created by mac on 2018/2/3.
//

#import <UIKit/UIKit.h>
#import "KYTableViewItemObject.h"

@interface KYTableViewCell : UITableViewCell

@property (nonatomic, strong) KYTableViewItemObject *itemObject;

+ (CGFloat)rowHeightForObject:(KYTableViewItemObject *)itemObject;

@end
