//
//  KYFormRowObject.m
//  KYForm
//
//  Created by mac on 2017/12/19.
//

#import "KYFormRowObject.h"
#import "KYFormViewController.h"

@implementation KYFormRowObject

@synthesize rowHeight = _rowHeight;

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title rowType:(NSString *)rowType {
    if (self = [self init]) {
        self.title = title;
        self.rowType = rowType;
        self.cellStyle = UITableViewCellStyleValue1;
        self.validators = [NSMutableArray array];
        self.rowHeight = -2.f;
    }
    
    return self;
}

- (instancetype)initWithModel:(FormRowModel *)model {
    if (self = [self initWithTitle:model.title rowType:model.type]) {
        self.rowModel = model;
    }
    
    return self;
}

+ (instancetype)formRowWithTitle:(NSString *)title {
    return [[self class] formRowWithTitle:title rowType:nil];
}

+ (instancetype)formRowWithTitle:(NSString *)title rowType:(NSString *)rowType {
    return [[[self class] alloc] initWithTitle:title rowType:rowType];
}

+ (instancetype)formRowWithModel:(FormRowModel *)model {
    return [[[self class] alloc] initWithModel:model];
}

// MARK: - Public Methods

- (KYFormBaseCell *)cellForFormController:(KYFormViewController *)formController {
    if (!_baseCell) {
        id cellClass = self.cellClass ?: [KYFormViewController cellClassesForRowTypes][self.rowType];
        if ([cellClass isKindOfClass:[NSString class]]) {
            
        } else {
            _baseCell = [[cellClass alloc] initWithStyle:self.cellStyle reuseIdentifier:nil];
        }
    }
    
    return _baseCell;
}

#pragma mark - Properties

- (void)setRowHeight:(CGFloat)rowHeight {
    _rowHeight = rowHeight;
}

- (CGFloat)rowHeight {
    if (_rowHeight == -2.f) {
        if ([[self.baseCell class] respondsToSelector:@selector(formCellHeightForRowObject:)]) {
            return [[self.baseCell class] formCellHeightForRowObject:self];
        } else {
            return -2.f;
        }
    }
    
    return _rowHeight;
}

@end
