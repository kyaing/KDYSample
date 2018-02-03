//
//  KYTableViewObject.h
//  KYForm
//
//  Created by mac on 2018/2/2.
//

#import <Foundation/Foundation.h>
#import "KYTableViewDataSource.h"

@interface KYTableViewModel : NSObject <KYTableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sections;

@end
