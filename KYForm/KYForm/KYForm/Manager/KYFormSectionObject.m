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
        _title = nil;
        _footerTitle = nil;
        _formRows = [NSMutableArray array];
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [self init]) {
        _title = title;
    }
    
    return self;
}

- (instancetype)initWithModel:(FormSectionModel *)model {
    if (self = [self init]) {
        self.sectionModel = model;
        self.formRows = [NSMutableArray array];
        
        _title = model.title;
        _footerTitle = model.footerTitle;
    }
    
    return self;
}

+ (instancetype)formSection {
    return [[self class] formSectionWithTitle:nil];
}

+ (instancetype)formSectionWithTitle:(NSString *)title {
    return [[[self class] alloc] initWithTitle:title];
}

+ (instancetype)formSectoinWithModel:(FormSectionModel *)model {
    return [[[self class] alloc] initWithModel:model];
}

#pragma mark - Properties

- (void)setFormRows:(NSMutableArray<KYFormRowObject *> *)formRows {
    _formRows = formRows;
    
    for (FormRowModel *rowModel in self.sectionModel.rows) {
        KYFormRowObject *rowObj = [KYFormRowObject formRowWithModel:rowModel];
        [self.formRows addObject:rowObj];
    }
}

@end
