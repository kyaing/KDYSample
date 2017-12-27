//
//  KYFormAvatarCell.m
//  KYForm
//
//  Created by mac on 2017/12/26.
//

#import "KYFormAvatarCell.h"

@interface KYFormAvatarCell()

@end

@implementation KYFormAvatarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:NSStringFromClass([self class])]) {
    }
    
    return self;
}

#pragma mark - KYFormCellDelegate

- (void)setupView {
    [super setupView];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    avatarImage.contentMode = UIViewContentModeScaleAspectFit;
    avatarImage.image = [UIImage imageNamed:@"defaultAvatar"];
    
    self.accessoryView = avatarImage;
}

- (void)configure {
    [super configure];
}

- (void)formCellDidSelectedWithController:(KYFormViewController *)controller {
    NSLog(@"[Click: %@]", NSStringFromClass([self class]));
}

+ (CGFloat)formCellHeightForRowObject:(KYFormRowObject *)rowObject {
    return 60.f;
}

@end
