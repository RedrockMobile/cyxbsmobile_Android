//
//  MineTableViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/9/24.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "MineTableViewCell.h"

@interface MineTableViewCell ()
@property (nonatomic, strong)UIImageView *rightImgView;
@end

@implementation MineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
        [self addRightImgView];
    }
    return self;
}

- (void)addLabel {
    UILabel *label = [[UILabel alloc] init];
    self.label = label;
    [self.contentView addSubview:label];
    
    label.font = [UIFont fontWithName:PingFangSCRegular size:16];
    label.textColor = [UIColor dm_colorWithLightColor:RGBColor(21, 49, 91, 1) darkColor:KUIColorFromRGB(0xf0f0f2)];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0.04266666667*SCREEN_WIDTH);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)addRightImgView {
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的页面箭头按钮"]];
    self.rightImgView = imgView;
    [self.contentView addSubview:imgView];
    
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-0.04533333333*SCREEN_WIDTH);
        make.centerY.equalTo(self.contentView);
    }];
}
@end
