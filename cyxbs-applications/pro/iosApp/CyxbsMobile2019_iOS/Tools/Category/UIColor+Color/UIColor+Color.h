//
//  UIColor+Color.h
//  Encapsulation
//
//  Created by SSR on 2022/2/15.
//

#import <UIKit/UIKit.h>

#import <UIColor+YYAdd.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - UIColor (Color)

@interface UIColor (Color)

/// 十六进制字符串获取颜色
/// @param color 16进制色值  支持@“#123456”、 @“0X123456”、 @“123456”三种格式
/// @param alpha 透明度
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**十六进制数值转换为UIColor*/
//+ (UIColor*)colorWith0xUInteger:(NSUInteger)hex
//                          alpha:(CGFloat)alpha;

/**类方法比较两个color*/
+ (BOOL)color:(UIColor *)oneColor isEquelToAnotherColor:(UIColor *)anotherColor;

/**成员方法比较两个color*/
- (BOOL)isEquelToAnotherColor:(UIColor *)anotherColor;

/**0xFF即255为原的color*/
+ (UIColor *)xFF_R:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue Alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
