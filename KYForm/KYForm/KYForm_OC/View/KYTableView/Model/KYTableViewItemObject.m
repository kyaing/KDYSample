//
//  KYTableViewItemObject.m
//  KYForm
//
//  Created by mac on 2018/2/2.
//

#import "KYTableViewItemObject.h"

@implementation KYTableViewItemObject

- (instancetype)init {
    if (self = [super init]) {
        self.title    = @"";
        self.subTitle = @"";
        self.image    = nil;
        self.cellHeight = 0;
    }
    
    return self;
}

@end
