//
//  StationGuideView.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/13.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "StationGuideView.h"
#import "StationsCollectionViewCell.h"

@interface StationGuideView ()
@property (nonatomic, copy) NSArray *stationArray;
@property (nonatomic, strong) StationScrollView *stationScrollView;
@property (nonatomic, strong) UIImageView *busimgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *runtimeLabel;
@property (nonatomic, strong) UIButton *sendtypeBtn;
@property (nonatomic, strong) UIButton *runtypeBtn;
@property (nonatomic, copy) NSArray <NSString *> *defaultImgAry;

@end

@implementation StationGuideView

- (instancetype)initWithFrame:(CGRect)frame AndStationsData:(StationData *)data{
    self = [super initWithFrame: frame];
    if (self) {
        self.stationArray = data.stations;
        [self addSubview:self.busimgView];
        _busimgView.image = [UIImage imageNamed:self.defaultImgAry[data.line_id]];
        [self addSubview:self.titleLabel];
        _titleLabel.text = data.line_name;
        [self addSubview:self.runtimeLabel];
        _runtimeLabel.text = data.run_time;
        [self addSubview:self.runtypeBtn];
        [_runtypeBtn setTitle:data.run_type forState:UIControlStateNormal];
        [self addSubview:self.sendtypeBtn];
        [_sendtypeBtn setTitle:data.send_type forState:UIControlStateNormal];
        [self addSubview:self.stationScrollView];
        [self.stationScrollView setStationData:data];
    }
    return self;
}


#pragma mark - Getter
- (StationScrollView *)stationScrollView {
    if (!_stationScrollView) {
        _stationScrollView = [[StationScrollView alloc] initWithFrame:CGRectMake(0, 65, kScreenWidth, 163)];
        _stationScrollView.showsVerticalScrollIndicator = NO;
        _stationScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _stationScrollView;
}
- (UIImageView *)busimgView {
    if (!_busimgView) {
        _busimgView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 24, 36, 36)];
    }
    return _busimgView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(68, 27, 200, 31)];
        _titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size: 22];
        _titleLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:1]];
    }
    return _titleLabel;
}
- (UILabel *)runtimeLabel {
    if (!_runtimeLabel) {
        _runtimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, 160, 17)];
        _runtimeLabel.right = self.right - 16;
        _runtimeLabel.font = [UIFont fontWithName:PingFangSCLight size: 12];
        _runtimeLabel.textAlignment = NSTextAlignmentRight;
        _runtimeLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:1]];
    }
    return _runtimeLabel;
}
- (UIButton *)sendtypeBtn {
    if (!_sendtypeBtn) {
        _sendtypeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 62, 17)];
        _sendtypeBtn.titleLabel.font = [UIFont fontWithName:PingFangSCLight size: 11];
        [_sendtypeBtn setTitleColor: [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#07BFE1" alpha:1] darkColor:[UIColor colorWithHexString:@"#07BFE1" alpha:1]] forState:UIControlStateNormal];
        _sendtypeBtn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#07BFE1" alpha:0.09] darkColor:[UIColor colorWithHexString:@"#07BFE1" alpha:0.09]];
        _sendtypeBtn.right = _runtypeBtn.left - 8;
        _sendtypeBtn.top = _runtimeLabel.bottom + 8;
        _sendtypeBtn.layer.cornerRadius = _sendtypeBtn.height / 2;
        _sendtypeBtn.userInteractionEnabled = NO;
    }
    return _sendtypeBtn;
}
- (UIButton *)runtypeBtn {
    if (!_runtypeBtn) {
        _runtypeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 19)];
        _runtypeBtn.titleLabel.font = [UIFont fontWithName:PingFangSCLight size: 11];
        _runtypeBtn.right = self.right - 16;
        _runtypeBtn.top = _runtimeLabel.bottom + 8;
        _runtypeBtn.layer.cornerRadius = _runtypeBtn.height / 2;
        _runtypeBtn.userInteractionEnabled = NO;
        [_runtypeBtn setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FF45B9" alpha:1] darkColor:[UIColor colorWithHexString:@"#FF45B9" alpha:1]] forState:UIControlStateNormal];
        _runtypeBtn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FF45B9" alpha:0.08] darkColor:[UIColor colorWithHexString:@"#FF45B9" alpha:0.08]];
    }
    return _runtypeBtn;
}

- (NSArray<NSString *> *)defaultImgAry {
    if (_defaultImgAry == nil) {
        _defaultImgAry = @[
            @"PinkBus",
            @"OrangeBus",
            @"BlueBus",
            @"GreenBus",
            @"Compass"
        ];
    }
    return _defaultImgAry;
}
@end
