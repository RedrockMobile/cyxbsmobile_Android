//
//  StationView.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/15.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "StationView.h"

@implementation StationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backImageView];
        [self addSubview:self.stationBtn];
        [self addSubview:self.frontImageView];
    }
    return self;
}
- (UIImageView *)frontImageView {
    if (!_frontImageView) {
        _frontImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 0, 24, 24)];
        _frontImageView.image = [UIImage imageNamed:@"arrow"];
        _frontImageView.alpha = 0;
    }
    return _frontImageView;
}
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 46, 6)];
        _backImageView.image = [UIImage imageNamed:@"busline.arrow"];
    }
    return _backImageView;
}
//button变为label
- (UILabel *)stationBtn {
    if (!_stationBtn) {
        _stationBtn = [[UILabel alloc]initWithFrame:CGRectMake(16, 22, 18, 145)];
        _stationBtn.textAlignment = NSTextAlignmentCenter;
        _stationBtn.numberOfLines = 0;
//        _stationBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _stationBtn.font = [UIFont fontWithName:PingFangSCLight size: 12];
        _stationBtn.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:1]];
    }
    return _stationBtn;
}

@end
