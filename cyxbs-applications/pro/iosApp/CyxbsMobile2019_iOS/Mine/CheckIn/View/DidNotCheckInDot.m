//
//  DidNotCheckInDot.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/1/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DidNotCheckInDot.h"

@interface DidNotCheckInDot ()

@property (nonatomic, weak) UIView *dot;

@end

@implementation DidNotCheckInDot

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *dot = [[UIView alloc] init];
        if (@available(iOS 11.0, *)) {
            dot.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E1E6EF" alpha:1] darkColor:[UIColor colorWithHexString:@"#5A5A5A" alpha:1]];
        } else {
            dot.backgroundColor = [UIColor colorWithRed:225/255.0 green:230/255.0 blue:240/255.0 alpha:1];
        }
        [self addSubview:dot];
        self.dot = dot;
    }
    return self;
}

- (void)layoutSubviews {
    self.dot.frame = CGRectMake(2, 2, 12, 12);
    self.dot.layer.cornerRadius = 6;
}

@end
