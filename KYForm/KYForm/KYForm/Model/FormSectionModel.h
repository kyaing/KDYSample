//
//  FormSectionModel.h
//  KYForm
//
//  Created by mac on 2017/12/21.
//

#import <Foundation/Foundation.h>
#import "FormRowModel.h"

@interface FormSectionModel : NSObject

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *footerTitle;

@property (nonatomic, strong) FormRowModel *rowModel;

@end
