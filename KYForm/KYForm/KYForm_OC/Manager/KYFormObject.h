//
//  KYFormObject.h
//  KYForm
//
//  Created by mac on 2017/12/20.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "KYFormSectionItem.h"
#import "KYFormObject.h"

@interface KYFormObject : NSObject

@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, strong) NSMutableArray<KYFormSectionItem *> *formSections;
@property (nonatomic, strong) NSMutableArray *dataSource;

+ (instancetype)formCreate;
+ (instancetype)formCreateWithTitle:(NSString *)title;

- (KYFormRowItem *)formRowAtIndex:(NSIndexPath *)indexPath;
- (KYFormSectionItem *)formSectionAtIndex:(NSIndexPath *)indexPath;

@end
