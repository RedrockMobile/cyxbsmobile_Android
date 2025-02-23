//
//  MessageSettingCell.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/21.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "MessageSettingCell.h"

#pragma mark - MessageSettingCell ()

@interface MessageSettingCell ()

/// 标题
@property (nonatomic, strong) UILabel *msgTitleLab;

/// 开关
@property (nonatomic, strong) UISwitch *msgSwitch;

@end

#pragma mark - MessageSettingCell

@implementation MessageSettingCell

#pragma mark - Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = self.contentView.backgroundColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]
                              darkColor:[UIColor colorWithHexString:@"#2C2C2C" alpha:1]];
        
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        
        self.accessoryView = self.msgSwitch;
        [self.contentView addSubview:self.msgTitleLab];
    }
    return self;
}

#pragma mark - Method

- (void)drawRect:(CGRect)rect {
    self.msgTitleLab.centerY = self.contentView.SuperCenter.y;
}

- (void)drawWithTitle:(NSString *)title switchOn:(BOOL)switchOn {
    self.msgTitleLab.text = title;
    self.switchOn = switchOn;
}

// MARK: SEL

- (void)swipeSwitch:(UISwitch *)s {
    if (self.delegate) {
        [self.delegate messageSettingCell:self swipeSwitch:self.msgSwitch];
    }
}

#pragma mark - Getter

- (UILabel *)msgTitleLab {
    if (_msgTitleLab == nil) {
        _msgTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 14, 162, 22)];
        _msgTitleLab.font = [UIFont fontWithName:PingFangSCSemibold size:16];
        
        _msgTitleLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1]
                              darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:1]];
    }
    return _msgTitleLab;
}

- (UISwitch *)msgSwitch {
    if (_msgSwitch == nil) {
        _msgSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        _msgSwitch.onTintColor = [UIColor xFF_R:42 G:33 B:209 Alpha:1];
        
        _msgSwitch.subviews.firstObject.subviews.firstObject.backgroundColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#C3D4EE" alpha:1]
                              darkColor:[UIColor colorWithHexString:@"#5A5A5A" alpha:1]];
        
        [_msgSwitch addTarget:self action:@selector(swipeSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _msgSwitch;
}

- (BOOL)switchOn {
    return self.msgSwitch.on;
}

#pragma mark - Setter

- (void)setSwitchOn:(BOOL)switchOn {
    [self.msgSwitch setOn:switchOn animated:NO];
}

@end
