//
//  KYForm.h
//  KYForm
//
//  Created by mac on 2017/12/20.
//

#import <UIKit/UIKit.h>

@interface NSRandom : NSObject

+ (CGFloat)valueBoundary:(CGFloat)low To:(CGFloat)high;

@end

@interface UIColor(Extensions)

+ (UIColor *)black33;
+ (UIColor *)black35;
+ (UIColor *)black55;
+ (UIColor *)black65;
+ (UIColor *)black66;
+ (UIColor *)black95;

+ (UIColor *)colorWithRGB:(int)rgb;
+ (UIColor *)colorWithRedi:(Byte)red green:(Byte)green blue:(Byte)blue alpha:(Byte)alpha;
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor *)colorWithRedi:(Byte)red green:(Byte)green blue:(Byte)blue;
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)randomColor;

@end
