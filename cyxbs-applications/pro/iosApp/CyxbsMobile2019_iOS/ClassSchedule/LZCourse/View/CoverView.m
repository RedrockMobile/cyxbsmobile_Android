//
//  CoverView.m
//  Demo
//
//  Created by 李展 on 2016/12/10.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

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
        self.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f];
        self.alpha = 0.4;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.passTap){
        self.passTap(touches,event);
    }
    
}
@end
