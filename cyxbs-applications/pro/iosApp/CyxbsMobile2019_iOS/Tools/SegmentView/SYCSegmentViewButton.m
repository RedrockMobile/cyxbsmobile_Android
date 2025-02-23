//
//  SYCSegmentViewButton.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2019/3/10.
//  Copyright © 2019年 Shi Yucheng. All rights reserved.
//

#import "SYCSegmentViewButton.h"

@implementation SYCSegmentViewButton

- (void)drawRect:(CGRect)rect {
    CGFloat backgroundWidth = self.frame.size.width * 0.85;
    CGFloat backgroundHeight = self.frame.size.height * 0.7;
    // 设置 backgroundView 在一个合理的位置（不依赖第三方库，也可以使用autolayout）
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - backgroundWidth) / 2.0, (self.frame.size.height - backgroundHeight) / 2.0, backgroundWidth, backgroundHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    // core animation
    backgroundView.layer.cornerRadius = 6.0;
    backgroundView.layer.shadowOffset = CGSizeMake(0, 2);
    backgroundView.layer.shadowOpacity = 0.05;
    backgroundView.layer.shadowColor = [UIColor grayColor].CGColor;
    
    // 文字，代替 self.titleLabel
    CGFloat labelWidth = backgroundWidth * 0.9;
    CGFloat labelHeight = backgroundHeight * 0.8;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - labelWidth) / 2.0, (self.frame.size.height - labelHeight) / 2.0, labelWidth, labelHeight)];
    nameLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    if (self.state == UIControlStateSelected) {
        nameLabel.textColor = [UIColor blueColor];
    }
    nameLabel.text = self.title;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    
    [self.layer addSublayer:backgroundView.layer];
    [self addSubview:nameLabel];

    
}
@end
