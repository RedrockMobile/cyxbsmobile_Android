//
//  PublishTableHeadView.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/21.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "PublishTableHeadView.h"
@interface PublishTableHeadView()

@end
@implementation PublishTableHeadView

- (instancetype)initWithHeaderView {
    if (self) {
        self = [super init];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backView];
        [self addSubview:self.headerLabel];
        [self setPosition];
    }
    return self;
}

- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.text = @"请输入话题";
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        _headerLabel.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.6];
        _headerLabel.font = [UIFont fontWithName:PingFangSC size:16];
        _headerLabel.userInteractionEnabled = YES;
    }
    return _headerLabel;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithHexString:@"#E8F1FC" alpha:0.5];
        _backView.layer.cornerRadius = 10;
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}

- (void)setPosition {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@293);
        make.height.equalTo(@45);
    }];
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@183);
        make.height.equalTo(@22);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
