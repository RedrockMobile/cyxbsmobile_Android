//
//  MainPageTableViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/2/22.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "MainPageTableViewCell.h"

@interface MainPageTableViewCell()

/// cell间的分割线，为什么不用原生的分割线？为了避免在cell不足的情况下影响美观
@property (nonatomic, strong)UIView *separateLine;
@end

@implementation MainPageTableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PraiseTableViewCellID"];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        [self addHeadImgView];
        [self addNickNameLabel];
        [self addInteractionInfoLabel];
        [self addTimeLabel];
        [self addSeparateLine];
    }
    return self;
}

/// 添加头像
- (void)addHeadImgView {
    UIImageView *imgView = [[UIImageView alloc] init];
    self.headImgView = imgView;
    [self.contentView addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0.0427*SCREEN_WIDTH);
        make.top.equalTo(self.contentView).offset(0.0533*SCREEN_WIDTH);
        make.width.height.mas_equalTo(0.128*SCREEN_WIDTH);
    }];
    imgView.layer.cornerRadius = 0.064*SCREEN_WIDTH;
    imgView.layer.masksToBounds = YES;
    [imgView setImage:[UIImage imageNamed:@"默认头像"]];
}

/// 设置用户昵称label的方法
- (void)addNickNameLabel {
    UILabel *label = [[UILabel alloc] init];
    [self.contentView addSubview:label];
    self.nickNameLabel = label;
    
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0.188*SCREEN_WIDTH);
        make.top.equalTo(self.contentView.mas_top).offset(0.0747*SCREEN_WIDTH);
        make.width.mas_equalTo(0.7*SCREEN_WIDTH);
    }];
    
    label.font = [UIFont fontWithName:PingFangSCRegular size:15];
}

/// 设置互动信息label方法
- (void)addInteractionInfoLabel {
    UILabel *label = [[UILabel alloc] init];
    [self.contentView addSubview:label];
    self.interactionInfoLabel = label;
    
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#748AAF" alpha:1] darkColor:[UIColor colorWithHexString:@"#838384" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:116/255.0 green:139/255.0 blue:176/255.0 alpha:1];
    }
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0.1867*SCREEN_WIDTH);
        make.top.equalTo(self.contentView.mas_top).offset(0.1373*SCREEN_WIDTH);
    }];
    
    label.font = [UIFont fontWithName:PingFangSCRegular size:11];
}

/// 添加时间戳label
- (void)addTimeLabel{
    UILabel *label = [[UILabel alloc] init];
    self.timeLabel = label;
    [self addSubview:label];
    
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#748AAF" alpha:1] darkColor:[UIColor colorWithHexString:@"#838384" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:116/255.0 green:139/255.0 blue:176/255.0 alpha:1];
    }
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.interactionInfoLabel.mas_right).offset(0.1*SCREEN_WIDTH);
        make.top.equalTo(self.contentView.mas_top).offset(0.1373*SCREEN_WIDTH);
    }];
    
    label.font = [UIFont fontWithName:PingFangSCRegular size:11];
}

/// 添加 底部分隔线 的方法
- (void)addSeparateLine{
    UIView *view = [[UIView alloc] init];
    self.separateLine = view;
    [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    if (@available(iOS 11.0, *)) {
        view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2C2C2C" alpha:0.2] darkColor:[UIColor colorWithHexString:@"#E6E6E6" alpha:0.4]];
    } else {
        view.backgroundColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:0.64];
    }
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
@end
