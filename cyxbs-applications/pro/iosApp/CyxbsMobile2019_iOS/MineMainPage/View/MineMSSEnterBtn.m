//
//  MineMSSEnterBtn.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/9/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "MineMSSEnterBtn.h"
#import "MineMsgCntView.h"

@interface MineMSSEnterBtn ()
@property (nonatomic, strong)MineMsgCntView *msgCntView;
@end


@implementation MineMSSEnterBtn
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addIconImgView];
        [self addNameLabel];
        [self addMsgCntView];
    }
    return self;
}

- (void)addIconImgView {
    UIImageView *imgView = [[UIImageView alloc] init];
    [self addSubview: imgView];
    self.iconImgView = imgView;
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.width.height.equalTo(@(0.1466666667*SCREEN_WIDTH));
    }];
}

- (void)addNameLabel {
    UILabel *label = [[UILabel alloc] init];
    self.nameLabel = label;
    [self addSubview:label];
    
    label.font = [UIFont fontWithName:PingFangSCRegular size:14];
    [label setTextColor:[UIColor dm_colorWithLightColor:RGBColor(21, 49, 91, 1) darkColor:KUIColorFromRGB(0xf0f0f2)]];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.top.equalTo(self.iconImgView.mas_bottom);
    }];
}

- (void)addMsgCntView {
    MineMsgCntView *ballView = [[MineMsgCntView alloc] init];
    self.msgCntView = ballView;
    [self addSubview:ballView];

    ballView.backgroundColor = RGBColor(109, 104, 255, 1);
    
//    ballView.msgCount = @"23";
    
    [ballView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImgView);
        make.left.equalTo(self.iconImgView.mas_right);
    }];
}

- (NSString *)msgCnt {
    return self.msgCntView.msgCount;
}

- (void)setMsgCnt:(NSString *)msgCnt {
    self.msgCntView.msgCount = msgCnt;
}
@end
