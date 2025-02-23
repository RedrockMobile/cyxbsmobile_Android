//
//  CQUPTMapPlaceRect.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapPlaceRect.h"

@implementation CQUPTMapPlaceRect

MJExtensionCodingImplementation

- (BOOL)isIncludePercentagePoint:(CGPoint)point {
    
    // 后端返回的数据单位均为 px ，在iOS中要转换为 pt ，此处需要转换后才能判断。由于图片比例为 16:9，所以我们指定宽度为屏幕宽度，全面屏iPhone适配另考虑。
    CGFloat convertedWidth = MAIN_SCREEN_W;
    CGFloat convertedHeight = (self.totalHeight / self.totalWidth) * MAIN_SCREEN_W;
    
    if (point.x > self.percentageLeft * convertedWidth && point.x < self.percentageRight * convertedWidth) {
        if (point.y > self.percentageTop * convertedHeight && point.y < self.percentageBottom * convertedHeight) {
            return YES;
        }
    }
    
    return NO;
}

@end
