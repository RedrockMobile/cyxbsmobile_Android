//
//  SchoolBusMapSideBar.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/8.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SchoolBusMapSideBar.h"

@implementation SchoolBusMapSideBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview: self.zoomScaleBtn];
        [self addSubview: self.narrowScaleBtn];
        [self addSubview: self.orientationBtn];
    }
    return self;
}
#pragma mark - Getter
- (UIButton *)zoomScaleBtn {
    if (!_zoomScaleBtn) {
        _zoomScaleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        [_zoomScaleBtn setImage: [UIImage imageNamed:@"plus.circle"] forState:UIControlStateNormal];
    }
    return _zoomScaleBtn;
}
- (UIButton *)narrowScaleBtn {
    if (!_narrowScaleBtn) {
        _narrowScaleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,  70, 70)];
        _narrowScaleBtn.top = _zoomScaleBtn.bottom + 18;
        [_narrowScaleBtn setImage: [UIImage imageNamed:@"minus.circle"] forState:UIControlStateNormal];
    }
    return _narrowScaleBtn;
}
- (UIButton *)orientationBtn {
    if (!_orientationBtn) {
        _orientationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        _orientationBtn.top = _narrowScaleBtn.bottom + 18;
        [_orientationBtn setImage: [UIImage imageNamed:@"orientation"] forState:UIControlStateNormal];
    }
    return _orientationBtn;
}

@end
