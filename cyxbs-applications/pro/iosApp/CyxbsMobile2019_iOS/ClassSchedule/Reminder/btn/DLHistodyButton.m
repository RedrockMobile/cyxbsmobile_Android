//
//  DLHistodyButton.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/10.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DLHistodyButton.h"

#define kRateX [UIScreen mainScreen].bounds.size.width/375   //以iPhoneX为基准
@implementation DLHistodyButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F7" alpha:1] darkColor:[UIColor colorWithHexString:@"#5E5E5E" alpha:1]];
        } else {
             self.backgroundColor = [UIColor colorWithHexString:@"#5E5E5E"];
        }
        self.layer.cornerRadius = 15*kRateX;
        self.layer.masksToBounds = YES;
        
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:PingFangSCRegular size:13];
        
        if (@available(iOS 11.0, *)) {
            [self setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF1" alpha:1]] forState:UIControlStateNormal];
        } else {
            [self setTitleColor:[UIColor colorWithHexString:@"F0F0F2"] forState:UIControlStateNormal];
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.height/2.0;
}

@end
