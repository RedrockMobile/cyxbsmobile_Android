//
//  ScoreTwoTitleView.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/2/13.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ScoreTwoTitleView.h"

@interface ScoreTwoTitleView()
@property (nonatomic, weak)UILabel *scoreLabel;
@property (nonatomic, weak)UILabel *averangeLabel;
@property (nonatomic, weak)UIButton *triangleButton;
@end
@implementation ScoreTwoTitleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        [self addScoreLabel];//学分成绩
        [self addAverangeLabel];//平均绩点
        [self addTriangle];//三角
    }
    return self;
}
- (void)addScoreLabel {
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont fontWithName:PingFangSCSemibold size:22];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    label.text = @"学分成绩";
    self.scoreLabel = label;
    [self addSubview:label];
}
- (void)addAverangeLabel {
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont fontWithName:PingFangSCSemibold size:18];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    label.text = @"平均绩点";
    self.averangeLabel = label;
    [self addSubview:label];
}
- (void)addTriangle {
    UIButton *button = [[UIButton alloc]init];
    self.triangleButton = button;
//    button.backgroundColor = UIColor.blueColor;
}
- (void)layoutSubviews {
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(9.5);
    }];
    [self.averangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreLabel);
        make.top.equalTo(self.scoreLabel.mas_bottom).offset(22);
    }];
    [self.triangleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.averangeLabel);
        make.width.equalTo(@8);
        make.height.equalTo(@4);
    }];
}
@end
