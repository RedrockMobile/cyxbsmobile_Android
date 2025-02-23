//
//  LessonNumLabel.m
//  Demo
//
//  Created by 李展 on 2016/12/8.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "LessonNumLabel.h"
#import "UIFont+AdaptiveFont.h"
@implementation LessonNumLabel

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
        self.font = [UIFont adaptFontSize:12];
        self.textColor = [UIColor colorWithHexString:@"#7097FA"];
        self.backgroundColor = [UIColor colorWithHexString:@"#EEF6FD"];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
@end
