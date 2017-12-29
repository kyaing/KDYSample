//
//  KYActionSheetCell.m
//  KYForm
//
//  Created by mac on 2017/12/28.
//

#import "KYActionSheetCell.h"

@interface KYActionSheetCell ()

@property (nonatomic, strong) UIButton *titleButton;

@end

@implementation KYActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.titleButton];
}

#pragma mark - Properties

- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.frame = self.contentView.bounds;
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _titleButton.titleLabel.textColor = [UIColor lightGrayColor];
    }
    
    return _titleButton;
}

- (void)setSheetItem:(KYActionSheetItem *)sheetItem {
    _sheetItem = sheetItem;
    
    [_titleButton.titleLabel setText:sheetItem.title];
    [_titleButton setImage:sheetItem.image forState:UIControlStateNormal];
}

@end
