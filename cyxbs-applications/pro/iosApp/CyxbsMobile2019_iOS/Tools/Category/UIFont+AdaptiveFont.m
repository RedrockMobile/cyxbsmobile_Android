//
//  UIFont+AdaptiveFont.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/4.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "UIFont+AdaptiveFont.h"

@implementation UIFont (AdaptiveFont)
+ (UIFont *)adaptFontSize:(CGFloat)fontSize{
    CGFloat scale = [UIScreen mainScreen].bounds.size.width/375;
    UIFont *font = [UIFont systemFontOfSize:fontSize*scale];
    return font;
}

@end
