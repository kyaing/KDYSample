//
//  NSArray+extension.m
//  KYForm
//
//  Created by mac on 2018/2/3.
//

#import "NSArray+extension.h"

@implementation NSArray (extension)

- (id)objectAtIndexSafe:(NSUInteger)index {
    if (self.count > index) {
        id ret = [self objectAtIndex:index];
        if ([ret isKindOfClass:[NSNull class]])
            return nil;
        return ret;
    }
    
    return nil;
}

@end
