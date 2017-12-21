//
//  KYFormRowObject.m
//  KYForm
//
//  Created by mac on 2017/12/19.
//

#import "KYFormRowObject.h"

@implementation KYFormRowObject

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title rowType:(NSString *)rowType {
    if (self = [self init]) {
        self.text = title;
        self.rowType = rowType;
        self.cellStyle = UITableViewCellStyleValue1;
    }
    
    return self;
}

+ (nonnull instancetype)formRowWithTitle:(nonnull NSString *)title {
    return [[self class] formRowWithTitle:title rowType:nil];
}

+ (nonnull instancetype)formRowWithTitle:(nonnull NSString *)title rowType:(nonnull NSString *)rowType {
    return [[[self class] alloc] initWithTitle:title rowType:rowType];
}

- (KYFormBaseCell *)cellForFormController:(KYFormViewController *)formController {
    return nil;
}

@end
