//
//  NextStationBtn.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "NextStationBtn.h"

@implementation NextStationBtn

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lineLabel];
        [self addSubview:self.imgView];
    }
    return self;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, 38, 20)];
        _lineLabel.font = [UIFont fontWithName:PingFangSCSemibold size:14];
    }
    return _lineLabel;
}
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(54, 10, 14.05, 10.26)];
    }
    return _imgView;
}

@end
