//
//  DayLabel.m
//  Demo
//
//  Created by 李展 on 2016/11/8.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "DayLabel.h"
#import "UIFont+AdaptiveFont.h"
@implementation DayLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#EEF6FD"];
        self.textColor = [UIColor colorWithHexString:@"#8395A4"];
        self.font = [UIFont adaptFontSize:12];
        self.textAlignment = NSTextAlignmentCenter;
        self.numberOfLines = 0;
    }
    return self;
}
@end
