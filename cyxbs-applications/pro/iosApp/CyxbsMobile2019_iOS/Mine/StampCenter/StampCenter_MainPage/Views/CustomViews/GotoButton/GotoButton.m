//
//  GotoButton.m
//  Demo5
//
//  Created by 钟文韬 on 2021/8/10.
//

#import "GotoButton.h"

@implementation GotoButton

- (instancetype)initWithFrame:(CGRect)frame AndTitle:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#4A44E4"];
        self.layer.cornerRadius = frame.size.height * 0.5;
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:14];
    }
    return self;
}

@end
