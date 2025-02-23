//
//  UIColor+Rising.h
//  ByteDanceCampus_Weather
//
//  Created by SSR on 2022/7/28.
//

#import <UIKit/UIKit.h>

#if __has_include(<YYKit/UIColor+YYAdd.h>)
#import <YYKit/UIColor+YYAdd.h>

/*
 Create UIColor with a hex string.
 Example: UIColorHex(0xF0F), UIColorHex(66ccff), UIColorHex(#66CCFF88)
 
 Valid format: #RGB #ARGB #RRGGBB #AARRGGBB 0xRGB ...
 The `#` or "0x" sign is not required.
 */
#define UIColorHexARGB(_hex_)   [UIColor colorWithHexStringARGB:((__bridge NSString *)CFSTR(#_hex_))]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Rising_YY)

/**
 Creates and returns a color object from hex string.
 
 @discussion:
 Valid format: #RGB #ARGB #RRGGBB #AARRGGBB 0xRGB ...
 The `#` or "0x" sign is not required.
 The alpha will be set to 1.0 if there is no alpha component.
 It will return nil when an error occurs in parsing.
 
 @param hexStr  The hex string value for the new color.
 
 @return        An UIColor object from string, or nil if an error occurs.
 */
+ (nullable UIColor *)colorWithHexStringARGB:(NSString *)hexStr;

@end

NS_ASSUME_NONNULL_END

#endif

#if __has_include(<UIColor+DarkModeKit.h>)
#import <UIColor+DarkModeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Rising_DM)

/// dm_colorWithLightColor:darkColor:
+ (UIColor *)Light:(UIColor *)lightColor Dark:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END


#endif
