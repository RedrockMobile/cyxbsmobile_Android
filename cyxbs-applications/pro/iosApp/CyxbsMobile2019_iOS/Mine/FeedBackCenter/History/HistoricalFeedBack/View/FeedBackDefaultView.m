//
//  FeedBackDefaultView.m
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/9/2.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "FeedBackDefaultView.h"

@interface FeedBackDefaultView ()

@end

@implementation FeedBackDefaultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}

- (void)configureView {
    
    
    [self addSubview:self.tipImgView];
    [self.tipImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_centerY);
    }];
    
    [self addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.tipImgView.mas_bottom).offset(16);
    }];

}

- (void)setText:(NSString *)text ImgWithName:(NSString *)imgName {
    self.tipLabel.text = text;
    self.tipImgView.image = [UIImage imageNamed:imgName];
}

#pragma mark - getter

- (UIImageView *)tipImgView {
    if (_tipImgView == nil) {
        _tipImgView = [[UIImageView alloc] init];
        _tipImgView.backgroundColor = [UIColor clearColor];
        [_tipImgView sizeToFit];
    }
    return _tipImgView;
}

- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        UILabel * label = [[UILabel alloc] init];
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:PingFangSCMedium size:12];
        _tipLabel = label;
    }
    return _tipLabel;

}

@end
