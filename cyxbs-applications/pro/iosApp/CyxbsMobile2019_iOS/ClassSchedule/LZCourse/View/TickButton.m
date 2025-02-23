//
//  TickButton.m
//  Demo
//
//  Created by 李展 on 2016/12/8.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "TickButton.h"
#import "UIImage+Color.h"
#import "UIFont+AdaptiveFont.h"

@implementation TickButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont adaptFontSize:16];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [self setTitleColor:[UIColor colorWithHexString:@"#464646"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHexString:@"#e9f3fd"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor colorWithHexString:@"#e9f3fd"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor colorWithHexString:@"#e9f3fd"] forState:UIControlStateSelected|UIControlStateHighlighted];


        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fbfbfb"]] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageNamed:@"选择"] forState:(UIControlStateSelected|UIControlStateHighlighted)];

        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)click{
    self.selected = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
