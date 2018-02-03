//
//  KYTableViewCell.m
//  KYForm
//
//  Created by mac on 2018/2/3.
//

#import "KYTableViewCell.h"

@implementation KYTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    
    return self;
}

- (void)setItemObject:(KYTableViewItemObject *)itemObject {
    _itemObject = itemObject;
    
    self.textLabel.text = itemObject.title;
    self.detailTextLabel.text = itemObject.subTitle;
}

+ (CGFloat)rowHeightForObject:(KYTableViewItemObject *)itemObject {
    return 44.f;
}

@end
