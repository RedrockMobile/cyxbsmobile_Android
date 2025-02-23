//
//  DLReminderView+Reset.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/10.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DLReminderView+Reset.h"

#define kRateX [UIScreen mainScreen].bounds.size.width/375   //以iPhoneX为基准
#define kRateY [UIScreen mainScreen].bounds.size.height/812  //以iPhoneX为基准

@implementation DLReminderView (Reset)


- (void)resetConstrains{
    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).mas_offset(173*kRateY);
        make.left.equalTo(self.mas_left).mas_offset(18*kRateX);
        make.width.mas_equalTo(70*kRateX);
        make.height.mas_equalTo(66*kRateX);
    }];
    [self.textFiled mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(15*kRateY);
        make.left.equalTo(self.mas_left).mas_offset(16*kRateX);
        make.width.mas_equalTo(343*kRateX);
        make.height.mas_equalTo(55*kRateY);
    }];
    self.nextBtn.image.image = [UIImage imageNamed:@"reminderDone"];
    [self.nextBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFiled.mas_bottom).mas_offset(227*kRateY);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(66*kRateX);
        make.height.mas_equalTo(66*kRateX);
    }];
    [self.nextBtn.image mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(33.15*kRateX);
        make.height.mas_equalTo(24*kRateY);
    }];
}

- (void)loadAddButton{
    self.addImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeAddImage"]];
    self.addImage.layer.cornerRadius = 13*kRateX;
    self.addImage.layer.masksToBounds = YES;
    self.addImage.backgroundColor = [UIColor clearColor];
    [self addSubview: self.addImage];
    [self.addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFiled.mas_bottom).mas_offset(81*kRateY);
        make.right.equalTo(self.mas_right).mas_offset(-39*kRateX);
        make.width.mas_equalTo(26*kRateX);
        make.height.mas_equalTo(26*kRateX);
    }];
    self.addButton = [[UIButton alloc] init];
    self.addButton.layer.cornerRadius = 13*kRateX;
    self.addButton.layer.masksToBounds = YES;
    self.addButton.backgroundColor = [UIColor clearColor];
    [self addSubview: self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFiled.mas_bottom).mas_offset(81*kRateY);
        make.right.equalTo(self.mas_right).mas_offset(-39*kRateX);
        make.width.mas_equalTo(26*kRateX);
        make.height.mas_equalTo(26*kRateX);
    }];
}
@end
