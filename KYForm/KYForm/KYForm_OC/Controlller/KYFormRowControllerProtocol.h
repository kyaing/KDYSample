//
//  KYFormRowControllerProtocol.h
//  KYForm
//
//  Created by mac on 2018/1/4.
//

#import <UIKit/UIKit.h>

@class KYFormObject;

@protocol KYFormRowControllerProtocol <NSObject>

@property (nonatomic, strong) KYFormObject  *formObject;

@end
