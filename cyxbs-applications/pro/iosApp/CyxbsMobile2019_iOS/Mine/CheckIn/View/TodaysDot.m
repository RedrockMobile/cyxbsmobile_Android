//
//  TodaysDot.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/1/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "TodaysDot.h"

@interface TodaysDot ()

@property (nonatomic, weak) UIImageView *dot;

@end

@implementation TodaysDot

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImageView *dot = [[UIImageView alloc] init];
        dot.image = [UIImage imageNamed:@"积分"];
        [self addSubview:dot];
        self.dot = dot;
    }
    return self;
}

- (void)layoutSubviews {
    self.dot.frame = CGRectMake(0, 0, 21, 21);
    self.dot.layer.cornerRadius = 10.5;
}

@end
