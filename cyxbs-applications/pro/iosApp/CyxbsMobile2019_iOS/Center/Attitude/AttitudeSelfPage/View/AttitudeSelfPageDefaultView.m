//
//  AttitudeSelfPageDefaultView.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/19.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "AttitudeSelfPageDefaultView.h"

@implementation AttitudeSelfPageDefaultView

- (instancetype)initWithDefaultPage {
    if (self) {
        self = [super init];
        self.defaultView.image = [UIImage imageNamed:@"Attitude_selfPageDefault"];
        self.defaultLabel.text = @"菌似乎还没有发布过话题,点击右上角去发布吧!";
        [self addSubview:self.defaultView];
        [self addSubview:self.defaultLabel];
        [self setPosition];
    }
    return self;
}

- (void)setPosition {
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).mas_offset(-475);
        make.width.equalTo(@170);
        make.height.equalTo(@102);
    }];
    [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.defaultView.mas_bottom).mas_offset(27);
        make.width.equalTo(@201);
        make.height.equalTo(@50);
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
