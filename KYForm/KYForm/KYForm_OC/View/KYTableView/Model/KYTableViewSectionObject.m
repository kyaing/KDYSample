//
//  KYTableViewSectionObject.m
//  KYForm
//
//  Created by mac on 2018/2/2.
//

#import "KYTableViewSectionObject.h"

@implementation KYTableViewSectionObject

- (instancetype)init {
    if (self = [super init]) {
        self.items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
