//
//  UIColor+Rising.m
//  ByteDanceCampus_Weather
//
//  Created by SSR on 2022/7/28.
//

#import "UIColor+Rising.h"

@implementation UIColor (Rising_YY)

+ (UIColor *)colorWithHexStringARGB:(NSString *)hexStr {
    hexStr = [hexStr stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].uppercaseString;
    if ([hexStr hasPrefix:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    } else if ([hexStr hasPrefix:@"0X"]) {
        hexStr = [hexStr substringFromIndex:2];
    }
    
    NSString *str = hexStr;
    NSUInteger length = str.length;
    // ARGB
    if (length == 4) {
        str = [NSString stringWithFormat:@"%@%@", [str substringWithRange:NSMakeRange(1, 3)], [hexStr substringWithRange:NSMakeRange(0, 1)]];
    }
    
    // AARRGGBB
    if (length == 8) {
        str = [NSString stringWithFormat:@"%@%@", [str substringWithRange:NSMakeRange(2, 6)], [hexStr substringWithRange:NSMakeRange(0, 2)]];
    }
    
    return [UIColor colorWithHexString:str];
}

@end

@implementation UIColor (Rising_DM)

+ (UIColor *)Light:(UIColor *)lightColor Dark:(UIColor *)darkColor {
    return [UIColor dm_colorWithLightColor:lightColor darkColor:darkColor];
}

@end
