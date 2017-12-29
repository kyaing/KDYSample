//
//  KYFormPickViewCell.m
//  KYForm
//
//  Created by mac on 2017/12/20.
//

#import "KYFormPickViewCell.h"

@implementation KYFormPickViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:NSStringFromClass([self class])]) {
        
    }
    
    return self;
}

#pragma mark - KYFormCellDelegate

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
