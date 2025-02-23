//
//  DataContentView.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/9.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "DataContentView.h"

@interface DataContentView()

@property(nonatomic, strong)UILabel *dataLab;

@property(nonatomic, strong)UILabel *unitLab;

@property(nonatomic, strong)UILabel *detailLab;

@end

@implementation DataContentView
#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dataLab];
        [_dataLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@44);
            make.height.equalTo(@44);
        }];
        
        [self addSubview:self.unitLab];
        [_unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.dataLab);
            make.left.equalTo(self.dataLab.mas_right).offset(8);
        }];
        
        [self addSubview:self.detailLab];
        [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dataLab.mas_bottom);
            make.centerX.equalTo(self.dataLab);
        }];
        
    }
    return self;
}

#pragma mark - Method

// MARK: SEL

#pragma mark - Getter

- (UILabel *)dataLab{
    if (!_dataLab) {
        _dataLab = [[UILabel alloc] init];
        _dataLab.font = [UIFont fontWithName:ImpactMedium size:36];
        _dataLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84"] darkColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        _dataLab.textAlignment = NSTextAlignmentCenter;
    }
    return _dataLab;
}

- (UILabel *)unitLab{
    if (!_unitLab) {
        _unitLab = [[UILabel alloc] init];
        _unitLab.font = [UIFont fontWithName:PingFangSCMedium size:12];
        _unitLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84"] darkColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    }
    return _unitLab;
}

- (UILabel *)detailLab{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] init];
        _detailLab.font = [UIFont fontWithName:PingFangSCMedium size:12];
        _detailLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.6] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:0.4]];
        _detailLab.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLab;
}

#pragma mark - Setter

+ (instancetype)loadViewWithData:(NSString *)data unit:(NSString *)unit detail:(NSString *)detail{
    DataContentView *view = [[DataContentView alloc] init];
    view.dataLab.text = data;
    view.unitLab.text = unit;
    view.detailLab.text = detail;
    return view;
}

@end
