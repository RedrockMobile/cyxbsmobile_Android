//
//  FinderToolViewItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2019/11/15.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import "FinderToolViewItem.h"

@interface FinderToolViewItem()
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *myTitleLabel;//前缀加my是为了防止与原命名重名
@property (nonatomic, weak) UILabel *myDetailLabel;
@end

@implementation FinderToolViewItem

- (instancetype)initWithIconView:(NSString *)iconViewName Title:(NSString *)title Detail:(NSString *)detail {
    if (self = [super init]) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        self.layer.cornerRadius = 10;
        [self addIconView];
        [self addTitleLabel];
        [self addDetailLabel];
        self.iconView.image = [UIImage imageNamed:iconViewName];
        self.title = title;
        self.detail = detail;
        self.myTitleLabel.text = title;
        self.myDetailLabel.text = detail;
        self.isFavorite = NO;
        self.isChooingNow = NO;
    }
    return self;
}
- (void) addIconView {
    UIImageView *iconView = [[UIImageView alloc]init];
    self.iconView = iconView;
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:iconView];
}
- (void) addTitleLabel {
    UILabel *label = [[UILabel alloc]init];
    self.myTitleLabel = label;
    if (@available(iOS 11.0, *)) {
      label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    label.font = [UIFont fontWithName:PingFangSCSemibold size:24];
    [self addSubview:label];
}
- (void) addDetailLabel {
    UILabel *label =[[UILabel alloc]init];
    self.myDetailLabel = label;
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    label.font = [UIFont fontWithName:PingFangSCRegular size:11];
    label.numberOfLines = 0;
    [self addSubview:label];
}
- (void)layoutSubviews {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.myTitleLabel.mas_top).offset(-31);
        make.left.equalTo(self).offset(23);
        make.width.height.equalTo(@40);
    }];
    [self.myTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView);
        make.bottom.equalTo(self.myDetailLabel.mas_top).offset(-7);
    }];
    [self.myDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView);
        make.width.equalTo(@88);
        make.top.equalTo(self.mas_bottom).offset(-73);
    }];
}
- (void)changeBackgroundColorIfNeeded {
    if (self.isFavorite == YES) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E5EAF2" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
        }
    } else {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
        }
    }
}
- (void)toggleFavoriteStates {
    if (self.isFavorite == YES) {
        self.isFavorite = NO;
    } else {
        self.isFavorite = YES;
    }
    [self changeBackgroundColorIfNeeded];
}
@end
