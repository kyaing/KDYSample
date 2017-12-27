//
//  KYForm.h
//  KYForm
//
//  Created by mac on 2017/12/20.
//

#import "UIColor+Extensions.h"

@implementation NSRandom
+ (CGFloat)valueBoundary:(CGFloat)low To:(CGFloat)high {
    CGFloat val = rand();
    val /= RAND_MAX;
    val = val * (high - low) + low;
    return val;
}
@end

@implementation UIColor(Extensions)
const float FLOAT_1_255 = 1.f / 255;

# define RGB2FLOAT(val) ((val) * FLOAT_1_255)
# define FLOAT2RGB(val) ((val) * 255)

# define ARGB_ALPHA(val) (((val) & 0xff000000) >> 24)
# define RGB_RED(val) (((val) & 0xff0000) >> 16)
# define RGB_GREEN(val) (((val) & 0xff00) >> 8)
# define RGB_BLUE(val) ((val) & 0xff)

+ (UIColor *)black33 {
    return [UIColor colorWithRGB:0x333333];
}

+ (UIColor *)black35 {
    return [UIColor colorWithRGB:0x353535];
}

+ (UIColor *)black55 {
    return [UIColor colorWithRGB:0x555555];
}

+ (UIColor *)black65 {
    return [UIColor colorWithRGB:0x656565];
}

+ (UIColor *)black66 {
    return [UIColor colorWithRGB:0x666666];
}

+ (UIColor *)black95 {
    return [UIColor colorWithRGB:0x959595];
}

+ (UIColor*)colorWithRGB:(int)rgb {
    return [UIColor colorWithRed:RGB2FLOAT(RGB_RED(rgb)) green:RGB2FLOAT(RGB_GREEN(rgb)) blue:RGB2FLOAT(RGB_BLUE(rgb)) alpha:1];
}

+ (UIColor*)colorWithRedi:(Byte)red green:(Byte)green blue:(Byte)blue alpha:(Byte)alpha {
    return [UIColor colorWithRed:RGB2FLOAT(red) green:RGB2FLOAT(green) blue:RGB2FLOAT(blue) alpha:RGB2FLOAT(alpha)];
}

+ (UIColor*)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIColor*)colorWithRedi:(Byte)red green:(Byte)green blue:(Byte)blue {
    return [self colorWithRedi:red green:green blue:blue alpha:255];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    NSInteger location = [hexString rangeOfString:@"#"].length;
    location = location >0?([hexString rangeOfString:@"#"].location+1):0;
    [scanner setScanLocation:location];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRGB:rgbValue];
}

+ (UIColor*)randomColor {
    CGFloat r = [NSRandom valueBoundary:0 To:1];
    CGFloat g = [NSRandom valueBoundary:0 To:1];
    CGFloat b = [NSRandom valueBoundary:0 To:1];
    return [UIColor colorWithRed:r green:g blue:b];
}

@end
