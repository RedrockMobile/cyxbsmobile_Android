//
//  PublishTopView.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/8.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "PublishTopView.h"
@interface PublishTopView()

@property (nonatomic, strong) UILabel *titleLbl;
@end

@implementation PublishTopView
- (instancetype)initWithTopView {
    if (self) {
        self = [super init];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backBtn];
        [self addSubview:self.titleLbl];
        [self setPosition];
    }
    return self;
}

- (void)setPosition {
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).mas_offset(getStatusBarHeight_Double / 2);
        make.left.equalTo(self).mas_offset(17);
        make.width.equalTo(@7);
        make.height.equalTo(@16);
    }];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn);
        make.left.equalTo(self.backBtn).mas_offset(13);
        make.width.equalTo(@88);
        make.height.equalTo(@31);
    }];
}


- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"Publish_backBtn"] forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.text = @"个人中心";
        _titleLbl.font = [UIFont fontWithName:PingFangSCMedium size:22];
        _titleLbl.textColor = [UIColor colorWithHexString:@"#15315B"];
    }
    return _titleLbl;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
