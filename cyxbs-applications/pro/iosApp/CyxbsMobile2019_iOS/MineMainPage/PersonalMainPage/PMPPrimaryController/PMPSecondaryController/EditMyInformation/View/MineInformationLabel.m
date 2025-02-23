//
//  MineEditTextField.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/11/14.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import "MineInformationLabel.h"

@interface MineInformationLabel ()

@property (nonatomic, weak) UIView *underLine;

@end

@implementation MineInformationLabel

- (instancetype)init
{
    self = [super init];
    self.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B"] darkColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    self.font = [UIFont fontWithName:PingFangSCRegular size:15];
    if (self) {
        UIView *underLine = [[UIView alloc] init];
        underLine.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:0.10] darkColor:[UIColor colorWithHexString:@"#474A50" alpha:1.00]];
        [self addSubview:underLine];
        self.underLine = underLine;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self);
        make.height.equalTo(@1.3);
    }];
}



@end
