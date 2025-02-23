//
//  DLTextFiled.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/9.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DLTextFiled.h"

#define rateX [UIScreen mainScreen].bounds.size.width / 375
@implementation DLTextFiled

- (instancetype)init
{
    self = [super init];
    if (self) {
//        CGFloat rateY = [UIScreen mainScreen].bounds.size.height / 812;
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F7" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
        } else {
             self.backgroundColor = [UIColor colorWithHexString:@"#F2F3F7"];
            // Fallback on earlier versions
        }
        
        
        self.layer.cornerRadius = 0.033867*MAIN_SCREEN_H;
        self.layer.masksToBounds = YES;
        if (@available(iOS 11.0, *)) {
            self.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#122D55" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
             self.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
            // Fallback on earlier versions
        }
        self.font = [UIFont fontWithName:PingFangSCRegular size:20];
        if (@available(iOS 11.0, *)) {
            self.tintColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4841E2" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
             self.tintColor = [UIColor colorWithHexString:@"#4841E2"];
            // Fallback on earlier versions
        }
        self.leftView.frame = CGRectMake(28*rateX, 0, 3, 10);  //光标偏移
    }
    return self;
}

//设置光标偏移
- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.origin.x += 20 * rateX;
    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds.origin.x += 20 * rateX;
    return bounds;
}
@end
