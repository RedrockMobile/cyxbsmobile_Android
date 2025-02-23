//
//  AttitudeMainDefaultView.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/8.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "AttitudeMainDefaultView.h"
@implementation AttitudeMainDefaultView

- (instancetype)initWithDefaultPage {
    if (self) {
        self = [super init];
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [self addSubview:self.defaultView];
        [self addSubview:self.defaultLabel];
        [self setPosition];
    }
    return self;
}

- (UIImageView *)defaultView {
    if (!_defaultView) {
        _defaultView = [[UIImageView alloc] init];
        _defaultView.image = [UIImage imageNamed:@"Attitude_MainPageDefault"];
    }
    return _defaultView;
}

- (UILabel *)defaultLabel {
    if (!_defaultLabel) {
        _defaultLabel = [[UILabel alloc] init];
        _defaultLabel.text = @"话题菌伺服偷懒了";
        _defaultLabel.font = [UIFont fontWithName:PingFangSC size:16];
        _defaultLabel.textColor = [UIColor colorWithHexString:@"#112C54" alpha:0.6];
        _defaultLabel.numberOfLines = 0;
    }
    return _defaultLabel;
}

- (void)setPosition {
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).mas_offset(-449);
        make.width.equalTo(@185);
        make.height.equalTo(@141);
    }];
    [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.defaultView.mas_bottom).mas_offset(16);
        make.height.equalTo(@22);
        make.width.equalTo(@128);
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
