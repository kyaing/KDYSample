//
//  KYActionSheetCell.m
//  KYForm
//
//  Created by mac on 2017/12/28.
//

#import "KYActionSheetCell.h"
#import "UIColor+Extensions.h"

@interface KYActionSheetCell ()

@property (nonatomic, strong) UIButton *titleButton;

@end

@implementation KYActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.titleButton];
    _titleButton.translatesAutoresizingMaskIntoConstraints = NO;
    _titleButton.userInteractionEnabled = NO;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleButton)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleButton)]];
}

#pragma mark - Properties

- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [[UIButton alloc] init];
        [_titleButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_titleButton setTitleColor:[UIColor black33] forState:UIControlStateNormal];
    }
    
    return _titleButton;
}

- (void)setSheetItem:(KYActionSheetItem *)sheetItem {
    _sheetItem = sheetItem;
    
    if (sheetItem.type == KYActionSheetItemTypeNormal) {
        [_titleButton setTitleColor:[UIColor black33] forState:UIControlStateNormal];
    } else {
        [_titleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    [_titleButton setTitle:sheetItem.title forState:UIControlStateNormal];
    [_titleButton setImage:sheetItem.image forState:UIControlStateNormal];
}

@end
