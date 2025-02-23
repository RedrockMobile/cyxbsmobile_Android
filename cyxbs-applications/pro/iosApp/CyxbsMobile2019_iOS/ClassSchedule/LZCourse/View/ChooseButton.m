//
//  ChooseButton.m
//  Demo
//
//  Created by 李展 on 2016/11/27.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "ChooseButton.h"
#import "UIImage+Color.h"
@implementation ChooseButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:251/255.f green:251/255.f blue:251/255.f alpha:1]] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:65/255.f green:162/255.f blue:255/255.f alpha:1]] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)select:(ChooseButton *)sender{
    sender.selected = !sender.selected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
