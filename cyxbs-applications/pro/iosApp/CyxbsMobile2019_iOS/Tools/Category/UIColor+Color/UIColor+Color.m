//
//  UIColor+Color.m
//  Encapsulation
//
//  Created by SSR on 2022/2/15.
//

#import "UIColor+Color.h"

#pragma mark - UIColor (Color)

@implementation UIColor (Color)

/**
 16进制颜色转换为UIColor
 @param hexColor 16进制字符串（可以以0x开头，可以以#开头，也可以就是6位的16进制）
 @param opacity 透明度
 @return 16进制字符串对应的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColor
                          alpha:(CGFloat)opacity {
    //删除字符串中的空格
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6){
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6){
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:opacity];
}

/**十六进制数值转换为UIColor*/
+ (UIColor*)colorWith0xUInteger:(NSUInteger)hex
                          alpha:(CGFloat)alpha {
    float r, g, b, a;
    a = alpha;
    b = hex & 0x0000FF;
    hex = hex >> 8;
    g = hex & 0x0000FF;
    hex = hex >> 8;
    r = hex;

    return [UIColor
            colorWithRed:r/255.0f
                   green:g/255.0f
                    blue:b/255.0f
                   alpha:a];
}

/**类方法比较两个color*/
+ (BOOL)color:(UIColor *)oneColor isEquelToAnotherColor:(UIColor *)anotherColor {
    return (CGColorEqualToColor(oneColor.CGColor, anotherColor.CGColor));
}

/**成员方法比较两个color*/
- (BOOL)isEquelToAnotherColor:(UIColor *)anotherColor {
    return (CGColorEqualToColor(self.CGColor, anotherColor.CGColor));
}

/**直接RGB和alpha得到*/
+ (UIColor *)xFF_R:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue Alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red / 255 green:green / 255 blue:blue / 255 alpha:alpha];
}

@end
