//
//  KYFormObject.m
//  KYForm
//
//  Created by mac on 2017/12/20.
//

#import "KYFormObject.h"

@implementation KYFormObject

#pragma mark - Life Cycle

- (instancetype)init {
    return [self initWithTitle:nil];
}

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
        self.formSections = [NSMutableArray array];
    }
    
    return self;
}

+ (instancetype)formCreate {
    return [[self class] formCreateWithTitle:nil];
}

+ (instancetype)formCreateWithTitle:(NSString *)title {
    return [[[self class] alloc] initWithTitle:title];
}

#pragma mark - Public Methods

- (KYFormRowObject *)formRowAtIndex:(NSIndexPath *)indexPath {
    if ([self.formSections count] > indexPath.section &&
        [[[self.formSections objectAtIndex:indexPath.section] formRows] count] > indexPath.row) {
        return [[[self.formSections objectAtIndex:indexPath.section] formRows] objectAtIndex:indexPath.row];
    }
    
    return nil;
}

- (KYFormSectionObject *)formSectionAtIndex:(NSIndexPath *)indexPath {
    if ([self.formSections count] > indexPath.section) {
        return [self.formSections objectAtIndex:indexPath.section];
    }
    
    return nil;
}

@end
