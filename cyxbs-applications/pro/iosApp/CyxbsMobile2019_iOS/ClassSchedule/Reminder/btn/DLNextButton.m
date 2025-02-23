//
//  DLNextButton.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/9.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DLNextButton.h"

@implementation DLNextButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat rateX = [UIScreen mainScreen].bounds.size.width / 375;
        self.layer.cornerRadius = 20 * rateX;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithHexString:@"#5D5DF7"];
//        渐变色
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(154.0,438.0,66.0,66.0);
        gl.startPoint = CGPointMake(0.03191028907895088, 0.9692919254302979);
        gl.endPoint = CGPointMake(3.1294407844543457, -1.995104193687439);
        gl.colors = @[
            (__bridge id)[UIColor colorWithHexString:@"#4841E2"].CGColor,
            (__bridge id)[UIColor colorWithHexString:@"#5D5DF7"].CGColor
        ];
        gl.locations = @[@(0),@(1.0f)];
        [self.layer addSublayer: gl];
        
        self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nextImage"]];
        self.image.backgroundColor = [UIColor clearColor];
        [self addSubview: self.image];
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(25*rateX);
            make.height.mas_equalTo(23*rateX);
        }];
        [self bringSubviewToFront: self.image];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
