//
//  KYTableViewItemObject.h
//  KYForm
//
//  Created by mac on 2018/2/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KYTableViewItemObject : NSObject

@property (nonatomic, copy  ) NSString *identifier;
@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *subTitle;
@property (nonatomic, strong) UIImage  *image;
@property (nonatomic, assign) CGFloat   cellHeight;

@end
