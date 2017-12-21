//
//  KYFormObject.h
//  KYForm
//
//  Created by mac on 2017/12/20.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "KYFormSectionObject.h"
#import "KYFormObject.h"

@interface KYFormObject : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<KYFormSectionObject *> *formSections;

+ (instancetype)formCreate;
+ (instancetype)formCreateWithTitle:(NSString *)title;

- (KYFormRowObject *)formRowAtIndex:(NSIndexPath *)indexPath;
- (KYFormSectionObject *)formSectionAtIndex:(NSIndexPath *)indexPath;

@end
