//
//  StationsCollectionViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/12.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "StationsCollectionViewCell.h"

@implementation StationsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self addSubview: self.backImageView];
        [self addSubview: self.stationLabel];
        [self addSubview:self.frontImageView];
    }
    return self;
}
- (UIImageView *)frontImageView {
    if (!_frontImageView) {
        _frontImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _frontImageView;
}
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 46, 6)];
    }
    return _backImageView;
}
- (UILabel *)stationLabel {
    if (!_stationLabel) {
        _stationLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 22, 18, 145)];
        _stationLabel.textAlignment = NSTextAlignmentLeft;
        _stationLabel.numberOfLines = 0;
        _stationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _stationLabel;
}
@end
