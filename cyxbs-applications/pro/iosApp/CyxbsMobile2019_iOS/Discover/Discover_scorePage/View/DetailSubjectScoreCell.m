//
//  DetailSubjectScoreCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/8/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DetailSubjectScoreCell.h"

@implementation DetailSubjectScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        [self addNameLabel];
        [self addScoreLabel];
        [self addMajorLabel];
    }
    return self;
}
-(void)addNameLabel {
    UILabel *label = [[UILabel alloc]init];
    self.nameLabel = label;
    label.font = [UIFont fontWithName:PingFangSCRegular size:11];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }

    [self.contentView addSubview:label];
    label.text = @"大学计算机应用实践";
}
-(void)addScoreLabel {
    UILabel *label = [[UILabel alloc]init];
    self.scoreLabel = label;
    label.font = [UIFont fontWithName:PingFangSCRegular size:11];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }

    [self.contentView addSubview:label];
    label.text = @"83";
}
-(void)addMajorLabel {
    UILabel *label = [[UILabel alloc]init];
    self.majorLabel = label;
    label.font = [UIFont fontWithName:PingFangSCRegular size:11];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }


    [self.contentView addSubview:label];
    label.text = @"必修";
}

- (void)layoutSubviews {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(18);
    }];
    [self.majorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.right.equalTo(self).offset(-18);
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.right.equalTo(self.majorLabel.mas_left).offset(-15);
    }];
}
@end
