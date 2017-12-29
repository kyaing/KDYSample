//
//  KYFormTextFieldCell.m
//  KYForm
//
//  Created by mac on 2017/12/26.
//

#import "KYFormTextFieldCell.h"

@implementation KYFormTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:NSStringFromClass([self class])]) {
        
    }
    
    return self;
}

#pragma mark - KYFormCellProtocol

- (void)setupView {
    [super setupView];
}

- (void)configure {
    [super configure];
}

- (void)formCellDidSelectedWithController:(KYFormViewController *)controller {
    NSLog(@"[Click: %@]", NSStringFromClass([self class]));
}

@end
