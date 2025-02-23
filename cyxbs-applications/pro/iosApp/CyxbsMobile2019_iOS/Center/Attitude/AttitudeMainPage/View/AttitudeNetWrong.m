//
//  AttitudeNetWrong.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/27.
//  Copyright © 2023 Redrock. All rights reserved.
//
/// 网络错误页面
#import "AttitudeNetWrong.h"

@implementation AttitudeNetWrong
- (instancetype)initWithNetWrong {
    if (self) {
        self = [super init];
        self.backgroundColor = [UIColor whiteColor];
        self.defaultView.image = [UIImage imageNamed:@"Attitude_netDefaultImage"];
        self.defaultLabel.text = @"网络菌伺服西去了联系QwQ";
        [self addSubview:self.defaultView];
        [self addSubview:self.defaultLabel];
        [self setPosition];
    }
    return self;
}

- (void)setPosition {
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).mas_offset(-464);
        make.width.equalTo(@157);
        make.height.equalTo(@96);
    }];
    [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.defaultView.mas_bottom).mas_offset(16);
        make.height.equalTo(@22);
        make.width.equalTo(@197);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
