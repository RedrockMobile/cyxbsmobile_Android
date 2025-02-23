//
//  FoodCollectionReusableView.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/18.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "FoodHeaderCollectionReusableView.h"

NSString *FoodHeaderCollectionReusableViewCellReuseIdentifier = @"FoodHeaderCollectionReusableViewCellReuseIdentifier";

@interface FoodHeaderCollectionReusableView ()

@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UIImageView *remindImgView;
@property (nonatomic, strong) UILabel *lab2;

@end

@implementation FoodHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lab1];
        [self addSubview:self.remindImgView];
        [self addSubview:self.lab2];
        [self addSubview:self.refreshBtn];
    }
    return self;
}

- (UILabel *)lab1 {
    if (!_lab1) {
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 26, 56, 20)];
        _lab1.font = [UIFont fontWithName:PingFangSCMedium size:14];
        _lab1.textColor = [UIColor colorWithHexString:@"#15315B"];
    }
    return _lab1;
}

- (UILabel *)lab2 {
    if (!_lab2) {
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(94, 29, 60, 14)];
        _lab2.font = [UIFont fontWithName:PingFangSCMedium size:10];
        _lab2.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.4];
    }
    return _lab2;
}

- (UIImageView *)remindImgView {
    if (!_remindImgView) {
        _remindImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"美食提醒"]];
        _remindImgView.frame = CGRectMake(78, 29.5, 11, 13);
    }
    return _remindImgView;
}

- (UIButton *)refreshBtn {
    if (!_refreshBtn) {
        _refreshBtn = [[UIButton alloc] init];
        [_refreshBtn setImage:[UIImage imageNamed:@"美食刷新"] forState:UIControlStateNormal];
        _refreshBtn.frame = CGRectMake(SCREEN_WIDTH - 30, 29.5, 18, 16);
    }
    return _refreshBtn;
}

- (void)setTitleText:(NSString *)titleText {
    self.lab1.text = titleText;
}

- (void)setOtherText:(NSString *)otherText {
    self.lab2.text = otherText;
}

@end
