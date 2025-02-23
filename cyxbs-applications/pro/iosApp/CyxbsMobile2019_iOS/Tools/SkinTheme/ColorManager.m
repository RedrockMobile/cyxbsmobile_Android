//
//  ColorManager.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/4/25.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager
+ (UIColor *)xxBtnBackColor {
    NSInteger mark = [NSUserDefaults.standardUserDefaults integerForKey:@"skinkey"];
    switch (mark) {
        case 1:
            return [UIColor redColor];
            break;
        default:
            return  UIColor.clearColor;
            break;
    }
}
@end
