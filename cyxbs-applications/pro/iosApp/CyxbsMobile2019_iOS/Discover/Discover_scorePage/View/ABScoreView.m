//
//  ABScoreView.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/2/13.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ABScoreView.h"

@interface ABScoreView()
@property (nonatomic, weak)UILabel *AScoreLabel;
@property (nonatomic, weak)UILabel *BScoreLbabel;
@property (nonatomic, weak)UIView *seperateLine;
@end
@implementation ABScoreView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        [self addABScoreLabel];
        [self addABScore];
        [self addSeperateLine];
    }
    return self;
}
- (void)addABScoreLabel {
    UILabel *AScoreLabel = [[UILabel alloc]init];
    AScoreLabel.text = @"A学分";
    self.AScoreLabel = AScoreLabel;
    [self addSubview:AScoreLabel];
    AScoreLabel.font = [UIFont fontWithName:PingFangSCRegular size:11];
    if (@available(iOS 11.0, *)) {
        AScoreLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    
    UILabel *BScoreLabel = [[UILabel alloc]init];
    BScoreLabel.text = @"B学分";
    self.BScoreLbabel = BScoreLabel;
    [self addSubview:BScoreLabel];
    BScoreLabel.font = AScoreLabel.font;
    BScoreLabel.textColor = AScoreLabel.textColor;
    
}
- (void)addABScore {
    UILabel *AScore = [[UILabel alloc]init];
    AScore.text = @"Loading";
    self.AScore = AScore;
    [self addSubview:AScore];
    AScore.font = [UIFont fontWithName:@"Impact" size: 32];
    if (@available(iOS 11.0, *)) {
        AScore.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    UILabel *BScore = [[UILabel alloc] init];
    BScore.text = @"Loading";
    self.BScore = BScore;
    [self addSubview:BScore];
    BScore.font = AScore.font;
    BScore.textColor = AScore.textColor;
    
}
- (void)addSeperateLine {
    UIView *seperateLine = [[UIView alloc]init];
    self.seperateLine = seperateLine;
    if (@available(iOS 11.0, *)) {
        seperateLine.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    [seperateLine setAlpha:0.14];
    [self addSubview:seperateLine];
}
- (void)layoutSubviews {
    [self.AScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(-self.width/4.0));
        make.top.equalTo(self).offset(17);
    }];
    [self.AScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.AScoreLabel);
        make.top.equalTo(self.AScoreLabel.mas_bottom).offset(5);
    }];
    [self.BScoreLbabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(self.width /4.0));
        make.top.equalTo(self.AScoreLabel);
    }];
    [self.BScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.BScoreLbabel);
        make.top.equalTo(self.AScore);
    }];
    [self.seperateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@1);
        make.height.equalTo(@18.86);
        make.centerY.equalTo(self);
    }];
}

@end
