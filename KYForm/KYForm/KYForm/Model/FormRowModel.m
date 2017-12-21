//
//  FormRowModel.m
//  KYForm
//
//  Created by mac on 2017/12/21.
//

#import "FormRowModel.h"

@implementation FormRowModel

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"lists": [FormRowListModel class]};
}

@end

@implementation FormRowListModel

@end
