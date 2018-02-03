//
//  KYTableViewSectionObject.h
//  KYForm
//
//  Created by mac on 2018/2/2.
//

#import <Foundation/Foundation.h>

@interface KYTableViewSectionObject : NSObject

@property (nonatomic, copy  ) NSString *headerTitle;
@property (nonatomic, copy  ) NSString *footerTitle;

@property (nonatomic, strong) NSMutableArray *items;

@end
