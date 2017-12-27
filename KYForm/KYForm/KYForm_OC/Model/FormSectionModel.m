//
//  FormSectionModel.m
//  KYForm
//
//  Created by mac on 2017/12/21.
//

#import "FormSectionModel.h"
#import "FormRowModel.h"

@implementation FormSectionModel

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rows": [FormRowModel class]};
}

@end
