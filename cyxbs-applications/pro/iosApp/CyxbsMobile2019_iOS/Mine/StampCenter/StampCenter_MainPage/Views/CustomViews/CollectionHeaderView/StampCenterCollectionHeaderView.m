//
//  CollectionTableView.m
//  Demo5
//
//  Created by 钟文韬 on 2021/8/11.
//

#import "StampCenterCollectionHeaderView.h"
#import "PrefixHeader.pch"
@implementation StampCenterCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self addSubview:self.mainLabel];
        [self addSubview:self.detailLabel];
    }
    return self;
}

- (UILabel *)mainLabel{
    if (!_mainLabel) {
        UILabel *mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.04*SCREEN_WIDTH, 14, 40, 28)];
        mainLabel.font = [UIFont fontWithName:PingFangSCSemibold size:20];
        mainLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        mainLabel.text = @"邮货";
        _mainLabel = mainLabel;
    }
    return _mainLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.63*SCREEN_WIDTH, 18, 140, 16)];
        detailLabel.font = [UIFont fontWithName:PingFangSCRegular size:12];
        detailLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.4] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:0.4]];
        detailLabel.text = @"需要到红岩网校领取哦";
        _detailLabel = detailLabel;
    }
    return _detailLabel;
}

- (void)setup{
    self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FBFCFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    UIBezierPath  *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame =self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
