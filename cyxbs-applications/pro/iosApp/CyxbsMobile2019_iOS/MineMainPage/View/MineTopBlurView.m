//
//  TopBlurView.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/9/22.
//  Modified by Max Xu on 2024/4/1
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "MineTopBlurView.h"
#define YOUSHE @"YouSheBiaoTiHei"

@interface MineTopBlurView ()

@property (nonatomic, strong)UIView *headWhiteEdgeView;

@end

@implementation MineTopBlurView

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0.9066666667*SCREEN_WIDTH);
            make.height.mas_equalTo(0.5546666667*SCREEN_WIDTH);
        }];
        [self addSubview:self.blurImgView];
        [self addSubview:self.realNameLabel];
        [self addSubview:self.headWhiteEdgeView];
        [self addSubview:self.introductionLabel];
        [self.headWhiteEdgeView addSubview:self.headImgBtn];
        [self addSubview:self.homePageBtn];
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints {
    [self.blurImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.realNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgBtn.mas_right).offset(0.01866666667*SCREEN_WIDTH);
        make.centerY.equalTo(self.headWhiteEdgeView);
        make.width.lessThanOrEqualTo(@(0.5*SCREEN_WIDTH));
    }];
    [self.headWhiteEdgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0.03466666667*SCREEN_WIDTH);
        make.top.equalTo(self).offset(0.096*SCREEN_WIDTH);
        make.width.height.equalTo(@(0.1706666667*SCREEN_WIDTH));
    }];
    [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headWhiteEdgeView.mas_left).offset(10);
        make.top.equalTo(self.realNameLabel.mas_bottom).offset(0.04679802955665*SCREEN_HEIGHT);
        make.width.lessThanOrEqualTo(@(0.6*SCREEN_WIDTH));
    }];
    [self.headImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.headWhiteEdgeView);
        make.width.height.equalTo(@(0.16*SCREEN_WIDTH));
    }];
    [self.homePageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0.152*SCREEN_WIDTH);
        make.right.equalTo(self).offset(-0.04666666667*SCREEN_WIDTH);
    }];
}

///背景图片
- (UIImageView *)blurImgView {
    if(!_blurImgView) {
        _blurImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mineBackImgBlur"]];
        _blurImgView.layer.shadowOffset = CGSizeMake(0, -0.005997001499*SCREEN_HEIGHT);
        _blurImgView.layer.shadowColor = RGBColor(46, 89, 152, 0.05).CGColor;
        _blurImgView.layer.shadowOpacity = 1;
    }
    return _blurImgView;
}

///真实姓名label
- (UILabel *)realNameLabel {
    if(!_realNameLabel) {
        _realNameLabel = [[UILabel alloc] init];
        _realNameLabel.font = [UIFont boldSystemFontOfSize:22];
        _realNameLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B"] darkColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        
    }
    return _realNameLabel;
}


///头像的背景板
- (UIView *)headWhiteEdgeView {
    if(!_headWhiteEdgeView) {
        _headWhiteEdgeView = [[UIView alloc] init];
        _headWhiteEdgeView.backgroundColor = [UIColor whiteColor];
        _headWhiteEdgeView.layer.cornerRadius = 0.08533333333*SCREEN_WIDTH;
        _headWhiteEdgeView.clipsToBounds = YES;
    }
    return _headWhiteEdgeView;
}


///"快来红岩网校和我一起玩吧～"label
- (UILabel *)introductionLabel {
    if(!_introductionLabel) {
        _introductionLabel = [[UILabel alloc] init];
        _introductionLabel.font = [UIFont boldSystemFontOfSize:15];
        _introductionLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B"] darkColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        _introductionLabel.numberOfLines = 2;
    }
    return _introductionLabel;
}

///头像按钮
- (UIButton *)headImgBtn {
    if(!_headImgBtn) {
        _headImgBtn = [[UIButton alloc] init];
        _headImgBtn.clipsToBounds = YES;
        [_headImgBtn setImage:[UIImage imageNamed:@"cat"] forState:UIControlStateNormal];
        _headImgBtn.layer.cornerRadius = 0.08*SCREEN_WIDTH;
    }
    return _headImgBtn;
}

///小箭头按钮
- (UIButton *)homePageBtn {
    if (!_homePageBtn) {
        _homePageBtn = [[UIButton alloc] init];
        [_homePageBtn setImage:[UIImage imageNamed:@"btn2homePage"] forState:UIControlStateNormal];
    }
    return _homePageBtn;
}
    

@end
