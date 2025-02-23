//
//  MainPageNumBtn.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/2/22.
//  Copyright © 2021 Redrock. All rights reserved.
//  带个小红点、标题、显示标题对应的模块的数据个数，标题如@"动态"、@"评论"、@"获赞"

#import "MainPageNumBtn.h"

@interface MainPageNumBtn()

/// 小红点
@property(nonatomic, strong)UIView *tipView;
@end
@implementation MainPageNumBtn
- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont fontWithName:@"Impact" size:35];
        if (@available(iOS 11.0, *)) {
            [self setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]] forState:UIControlStateNormal];
        } else {
            [self setTitleColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1] forState:UIControlStateNormal];
        }
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addBtnNameLabel];
        [self addTipView];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(MAIN_SCREEN_W * 0.12);
            make.width.greaterThanOrEqualTo(self.btnNameLabel);
            make.width.greaterThanOrEqualTo(self.titleLabel);
        }];
        
//        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)addBtnNameLabel {
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    self.btnNameLabel = label;
    
    label.font = [UIFont fontWithName:PingFangSCRegular size:11];
    
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1];
    }
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_bottom);
    }];
}

- (void)addTipView {
    UIView *view = [[UIView alloc] init];
    self.tipView = view;
    [self addSubview:view];
    
    CGFloat radius = 0.009333333335*SCREEN_WIDTH;
    view.layer.cornerRadius = radius;
    view.backgroundColor = RGBColor(109, 104, 255, 1);
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(-5);
        make.centerY.equalTo(self.titleLabel.mas_top).offset(8);
        make.width.height.mas_equalTo(2*radius);
    }];
}

- (void)setHideTipView:(BOOL)hideTipView {
    self.tipView.hidden = hideTipView;
}

- (BOOL)hideTipView {
    return self.tipView.hidden;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    if (title.longValue > 9999) {
        [super setTitle:@"9999" forState:state];
    }else {
        [super setTitle:title forState:state];
    }
}
@end
