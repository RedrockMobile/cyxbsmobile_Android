//
//  WeekChooseButton.m
//  Demo
//
//  Created by 李展 on 2016/12/9.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "WeekChooseButton.h"
#import "UIImage+Color.h"
#import "UIFont+AdaptiveFont.h"
@implementation WeekChooseButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = self.frame.size.width/2;
        self.layer.masksToBounds = YES;
        [self setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#41a2ff"]] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor colorWithHexString:@"#595959"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont adaptFontSize:14];
        [self addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)select:(WeekChooseButton *)sender{
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
