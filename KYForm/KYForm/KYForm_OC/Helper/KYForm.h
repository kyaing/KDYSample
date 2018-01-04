//
//  KYForm.h
//  KYForm
//
//  Created by mac on 2017/12/20.
//

#import <Foundation/Foundation.h>

// Manager
#import "KYFormObject.h"
#import "KYFormSectionItem.h"
#import "KYFormRowItem.h"

// Cells
#import "KYFormBaseCell.h"
#import "KYFormAvatarCell.h"
#import "KYFormSwitchCell.h"
#import "KYFormSelectorCell.h"
#import "KYFormTextFieldCell.h"

// Models
#import "FormRowModel.h"
#import "FormSectionModel.h"

// Views
#import "KYSwitch.h"
#import "KYDatePickView.h"
#import "KYActionSheet.h"
#import "KYAlertView.h"

// Libs
#import "Tools.h"
#import "NSObject+YYModel.h"

// Extension
#import "UIColor+Extensions.h"

extern NSString *const kFormRowTypeImage;
extern NSString *const kFormRowTypeText;
extern NSString *const kFormRowTypePhone;
extern NSString *const kFormRowTypeMail;
extern NSString *const kFormRowTypeNumber;
extern NSString *const kFormRowTypePassword;

extern NSString *const kFormRowTypeDate;
extern NSString *const kFormRowTypeSwitch;
extern NSString *const kFormRowTypeTextView;
extern NSString *const kFormRowTypePickerView;
extern NSString *const kFormRowTypeChoosePush;
extern NSString *const kFormRowTypeChoosePop;
extern NSString *const kFormRowTypeActionSheet;
