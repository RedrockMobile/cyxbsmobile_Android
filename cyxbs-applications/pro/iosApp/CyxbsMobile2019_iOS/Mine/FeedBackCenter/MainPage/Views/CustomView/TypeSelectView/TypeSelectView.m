//
//  TypeSelectView.m
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/25.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "TypeSelectView.h"

@implementation TypeSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
        [self addSubview:self.otherBtn];
        [self addSubview:self.profileProblemBtn];
        [self addSubview:self.recommendBtn];
        [self addSubview:self.systemProblemBtn];
    }
    return self;
}

- (TypeButton *)recommendBtn{
    if (!_recommendBtn) {
        _recommendBtn = [[TypeButton alloc]initWithFrame:CGRectMake(0.042 * SCREEN_WIDTH, 24, 0.224*SCREEN_WIDTH, 30) AndTitle:@"意见建议"];
        _recommendBtn.tag = 0;
        _recommendBtn.delegate = self;
    }
    return _recommendBtn;
}

- (TypeButton *)systemProblemBtn{
    if (!_systemProblemBtn) {
        _systemProblemBtn = [[TypeButton alloc]initWithFrame:CGRectMake(0.298 * SCREEN_WIDTH, 24, 0.224*SCREEN_WIDTH, 30) AndTitle:@"系统问题"];
        _systemProblemBtn.tag = 1;
    }
    return _systemProblemBtn;
}

- (TypeButton *)profileProblemBtn{
    if (!_profileProblemBtn) {
        _profileProblemBtn = [[TypeButton alloc]initWithFrame:CGRectMake(0.552 *SCREEN_WIDTH, 24, 0.224*SCREEN_WIDTH, 30) AndTitle:@"账号问题"];
        _profileProblemBtn.tag = 2;
    }
    return _profileProblemBtn;
}

- (TypeButton *)otherBtn{
    if (!_otherBtn) {
        _otherBtn = [[TypeButton alloc]initWithFrame:CGRectMake(0.805 *SCREEN_WIDTH, 24, 0.149*SCREEN_WIDTH, 30) AndTitle:@"其他"];
        _otherBtn.tag = 3;
    }
    return _otherBtn;
}

#pragma mark - TypeButtonDelegate
- (void)selected:(TypeButton *)sender{
    self.select(sender);
}

@end
