//
//  KYFormSectionObject.m
//  KYForm
//
//  Created by mac on 2017/12/19.
//

#import "KYFormSectionObject.h"

@implementation KYFormSectionObject

- (instancetype)init {
    if (self = [super init]) {
        self.title = nil;
        self.footerTitle = nil;
        self.formRows = [NSMutableArray array];
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [self init]) {
        self.title = title;
    }
    
    return self;
}

+ (instancetype)formSection {
    return [[self class] formSectionWithTitle:nil];
}

+ (instancetype)formSectionWithTitle:(NSString *)title {
    return [[[self class] alloc] initWithTitle:title];
}

@end
