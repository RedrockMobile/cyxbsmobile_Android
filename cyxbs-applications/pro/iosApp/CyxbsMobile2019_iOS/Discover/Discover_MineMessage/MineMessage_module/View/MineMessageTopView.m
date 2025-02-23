//
//  MineMessageTopView.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "MineMessageTopView.h"

#import "SSRButton.h"

#pragma mark - MineMessageTopView ()

@interface MineMessageTopView ()

/// 多选
@property (nonatomic, strong) SSRButton *moreBtn;

/// 系统
@property (nonatomic, strong) UIButton *systemBtn;

/// 活动
@property (nonatomic, strong) UIButton *activeBtn;

/// 行程
@property (nonatomic, strong) UIButton *arrangeBtn;

// MARK: other

/// ball for system
@property (nonatomic, strong) UIView *systemBall;

/// ball for active
@property (nonatomic, strong) UIView *activeBall;

/// 多选的ball
@property (nonatomic, strong) UIView *moreBall;

@end

#pragma mark - MineMessageTopView

@implementation MineMessageTopView

- (instancetype)initWithSafeViewHeight:(CGFloat)height {
    self = [super initWithSafeViewHeight:height];
    if (self) {
        self.backgroundColor =
        [UIColor dm_colorWithLightColor:[UIColor xFF_R:255 G:255 B:255 Alpha:1]
                              darkColor:[UIColor xFF_R:29 G:29 B:29 Alpha:1]];
        
        [self addTitle:@"我的消息"
          withTitleLay:SSRTopBarBaseViewTitleLabLayLeft
             withStyle:nil];
        
        UIBezierPath *bezier =
        [UIBezierPath
         bezierPathWithRoundedRect:CGRectMake(0, 0, self.width, self.height)
         byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
         cornerRadii:CGSizeMake(20, 20)];
        
        CAShapeLayer *layer = CAShapeLayer.layer;
        layer.frame = CGRectMake(0, 0, self.width, self.height);
        layer.path = bezier.CGPath;
        self.layer.mask = layer;
        
        [self.safeView addSubview:self.moreBtn];
        [self.safeView addSubview:self.systemBtn];
        [self.safeView addSubview:self.activeBtn];
        [self.safeView addSubview:self.arrangeBtn];
        [self addSwithLineWithOrigin:CGPointMake(0, self.safeView.SuperBottom - 3)];
        self.swithLine.centerX = self.systemBtn.centerX;
        
        self.systemBtn.selected = YES;
        _lineIsScroll = NO;
        self.hadLine = NO;
        _moreHadSet = YES;
    }
    return self;
}

#pragma mark - Method

- (void)addMoreBtnTarget:(id)target action:(SEL)action {
    [self.moreBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

// MARK: SEL

- (void)selectBtn:(UIButton *)btn {
    // 当前没被选中，说明line在另一个位置，需要滑动到这个位置
    if (btn.selected == NO) {
        CGFloat more = 0;
        UIButton *button = self.activeBtn;
        // 如果在第一个位置，位移为正，反之
        if (btn == self.systemBtn) {
            more = -10;
        }
        if (btn == self.arrangeBtn) {
            more = 10;
        }
        if (btn == self.activeBtn) {
            if ([self.systemBtn isSelected]) {
                more = 10;
                button = self.systemBtn;
            } else if ([self.arrangeBtn isSelected]) {
                more = -10;
                button = self.arrangeBtn;
            }
        }
        // 如果在滑动，那就等0.7秒
        (self.lineIsScroll ?
         dispatch_after(0.5, dispatch_get_main_queue(), ^{
            [self lineScrollToCenterX:btn.centerX more:more];
         }) :
         [self lineScrollToCenterX:btn.centerX more:more]);
        if (self.delegate) {
            [self.delegate
             mineMessageTopView:self
             willScrollFrom:button
             toBtn:btn];
        }
    }
    // 设置一下选中状态
    btn.selected = YES;
    UIColor *unselectedColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#142C52" alpha:0.4] darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:55]];
    if (btn == self.systemBtn) {
        self.activeBtn.selected = NO;
        self.arrangeBtn.selected = NO;
        [self.activeBtn setTitleColor:unselectedColor forState:UIControlStateNormal];
        [self.arrangeBtn setTitleColor:unselectedColor forState:UIControlStateNormal];
    } else if (btn == self.activeBtn) {
        self.systemBtn.selected = NO;
        self.arrangeBtn.selected = NO;
        [self.systemBtn setTitleColor:unselectedColor forState:UIControlStateNormal];
        [self.arrangeBtn setTitleColor:unselectedColor forState:UIControlStateNormal];
    } else {
        self.systemBtn.selected = NO;
        self.activeBtn.selected = NO;
        [self.systemBtn setTitleColor:unselectedColor forState:UIControlStateNormal];
        [self.activeBtn setTitleColor:unselectedColor forState:UIControlStateNormal];
    }
    self.moreBtn.tag = (btn == self.activeBtn);
    
    [btn setTitleColor:
     [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1]
                           darkColor:[UIColor colorWithHexString:@"#DFDFE3"alpha:1]]
              forState:UIControlStateNormal];
}

- (void)lineScrollToCenterX:(CGFloat)centerX more:(CGFloat)more{
    _lineIsScroll = YES;
    [UIView
     animateWithDuration:0.4 animations:^{
        self.swithLine.centerX = centerX + more;
    }
     completion:^(BOOL finished) {
        if (finished) {
            [UIView
             animateWithDuration:0.2
             animations:^{
                self.swithLine.centerX = centerX;
            }
             completion:^(BOOL finished1) {
                if (finished1 && self.lineIsScroll) {
                    self->_lineIsScroll = NO;
                }
            }];
        }
    }];
}

#pragma mark - Getter

- (UIButton *)moreBtn {
    if (_moreBtn == nil) {
        _moreBtn = [[SSRButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        [_moreBtn setImage:[UIImage imageNamed:@"more_d"] forState:UIControlStateNormal];
        _moreBtn.right = self.SuperRight - 26;
        _moreBtn.centerY = 20;
        _moreBtn.expandHitEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        
        _moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        _moreBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _moreBtn.tag = 0;
    }
    return _moreBtn;
}

- (UIButton *)systemBtn {
    if (_systemBtn == nil) {
        _systemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width / 3, 30)];
        _systemBtn.bottom = self.safeView.SuperBottom - 10;
        [_systemBtn setTitle:@"系统通知" forState:UIControlStateNormal];
        _systemBtn.titleLabel.font = [UIFont fontWithName:PingFangSC size:18];
        
        [_systemBtn setTitleColor:
         [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1]
                               darkColor:[UIColor colorWithHexString:@"#DFDFE3"alpha:1]]
         forState:UIControlStateNormal];
        
        [_systemBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _systemBtn;
}

- (UIButton *)activeBtn {
    if (_activeBtn == nil) {
        _activeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.systemBtn.right, 0, self.width / 3, 30)];
        _activeBtn.bottom = self.systemBtn.bottom;
        [_activeBtn setTitle:@"活动通知" forState:UIControlStateNormal];
        _activeBtn.titleLabel.font = [UIFont fontWithName:PingFangSC size:18];
        
        [_activeBtn setTitleColor:
         [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#142C52" alpha:0.4]
                               darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:55]]
                  forState:UIControlStateNormal];
        
        [_activeBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _activeBtn;
}

- (UIButton *)arrangeBtn {
    if (_arrangeBtn == nil) {
        _arrangeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.activeBtn.right, 0, self.width / 3, 30)];
        _arrangeBtn.bottom = self.activeBtn.bottom;
        [_arrangeBtn setTitle:@"行程通知" forState:UIControlStateNormal];
        _arrangeBtn.titleLabel.font = [UIFont fontWithName:PingFangSC size:18];
        [_arrangeBtn setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#142C52" alpha:0.4] darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:55]] forState:UIControlStateNormal];
        [_arrangeBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrangeBtn;
}

- (UIView *)systemBall {
    if (_systemBall == nil) {
        _systemBall = [[UIView alloc] initWithFrame:CGRectMake(_systemBtn.titleLabel.right, -1, 6, 6)];
        _systemBall.layer.cornerRadius = _systemBall.width / 2;
        _systemBall.backgroundColor = [UIColor xFF_R:255 G:98 B:98 Alpha:1];
    }
    return _systemBall;
}

- (UIView *)activeBall {
    if (_activeBall == nil) {
        _activeBall = [[UIView alloc] initWithFrame:CGRectMake(_activeBtn.titleLabel.right, -1, 6, 6)];
        _activeBall.layer.cornerRadius = _activeBall.width / 2;
        _activeBall.backgroundColor = [UIColor xFF_R:255 G:98 B:98 Alpha:1];
    }
    return _activeBall;
}

- (UIView *)moreBall {
    if (_moreBall == nil) {
        _moreBall = [[UIView alloc] initWithFrame:CGRectMake(_moreBtn.imageView.right, 0, 6, 6)];
        _moreBall.layer.cornerRadius = _moreBall.width / 2;
        _moreBall.backgroundColor = [UIColor xFF_R:255 G:98 B:98 Alpha:1];
    }
    return _moreBall;
}

#pragma mark - Setter

- (void)setActiveHadMsg:(BOOL)activeHadMsg {
    if (_activeHadMsg == activeHadMsg) {
        return;
    }
    if (activeHadMsg) {
        [self.activeBtn addSubview:self.activeBall];
    } else {
        [self.activeBall removeFromSuperview];
    }
    _activeHadMsg = activeHadMsg;
}

- (void)setSystemHadMsg:(BOOL)systemHadMsg {
    if (_systemHadMsg == systemHadMsg) {
        return;
    }
    if (systemHadMsg) {
        [self.systemBtn addSubview:self.systemBall];
    } else {
        [self.systemBall removeFromSuperview];
    }
    _systemHadMsg = systemHadMsg;
}

- (void)setMoreHadSet:(BOOL)moreHadSet {
    if (_moreHadSet == moreHadSet) {
        return;
    }
    if (!moreHadSet) {
        [self.moreBtn addSubview:self.moreBall];
    } else {
        [self.moreBall removeFromSuperview];
    }
    _moreHadSet = moreHadSet;
}

@end
