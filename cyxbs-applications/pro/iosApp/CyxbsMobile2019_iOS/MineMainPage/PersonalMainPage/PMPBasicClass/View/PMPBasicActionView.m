//
//  PMPBasicActionView.m
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/9/15.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "PMPBasicActionView.h"

@implementation PMPBasicActionView

- (instancetype)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if (self) {
        [self basic_configView];
    }
    return self;
}

- (void)basic_configView {
    self.backgroundColor = [UIColor clearColor];
}

/// 请注意, 这里 SEL 的第一个对象不是View本身, 是手势, 所以要用 .view 来获取这个控件对象!!!
- (void)addTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

@end
