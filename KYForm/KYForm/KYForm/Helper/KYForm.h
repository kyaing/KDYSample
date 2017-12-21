//
//  KYForm.h
//  KYForm
//
//  Created by mac on 2017/12/20.
//

#import <Foundation/Foundation.h>

// Manager
#import "KYFormObject.h"
#import "KYFormSectionObject.h"
#import "KYFormRowObject.h"

// Cells
#import "KYFormBaseCell.h"
#import "KYFormDateCell.h"
#import "KYFormImageCell.h"
#import "KYFormSwitchCell.h"
#import "KYFormPickViewCell.h"
#import "KYFormTextFieldCell.h"
#import "KYFormTextViewCell.h"

// Libs
#import "NSObject+YYModel.h"

extern NSString *const kFormRowTypeText;
extern NSString *const kFormRowTypePhone;
extern NSString *const kFormRowTypeNumber;
extern NSString *const kFormRowTypePassword;
extern NSString *const kFormRowTypeDate;
extern NSString *const kFormRowTypePicker;
extern NSString *const kFormRowTypeSwitch;
extern NSString *const kFormRowTypeTextView;
