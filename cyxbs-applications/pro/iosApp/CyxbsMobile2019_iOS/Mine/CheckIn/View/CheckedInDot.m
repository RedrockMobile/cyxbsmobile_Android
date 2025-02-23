//
//  CheckedInDot.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/1/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CheckedInDot.h"

@interface CheckedInDot ()

@property (nonatomic, weak) UIView *background;
@property (nonatomic, weak) UIView *foreground;

@end

@implementation CheckedInDot

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *background = [[UIView alloc] init];
        background.backgroundColor = [UIColor whiteColor];
        [self addSubview:background];
        self.background = background;
        
        UIView *foreground = [[UIView alloc] init];
        if (@available(iOS 11.0, *)) {
            foreground.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#3934D1" alpha:1] darkColor:[UIColor colorWithHexString:@"#2BDEFF" alpha:1]];
        } else {
            foreground.backgroundColor = [UIColor colorWithRed:58/255.0 green:53/255.0 blue:210/255.0 alpha:1];
        }
        [self addSubview:foreground];
        self.foreground = foreground;
    }
    return self;
}

- (void)layoutSubviews {
    self.background.frame = CGRectMake(0, 0, 16, 16);
    self.background.layer.cornerRadius = 8;
    
    self.foreground.frame = CGRectMake(4, 4, 8, 8);
    self.foreground.layer.cornerRadius = 4;
}

@end
