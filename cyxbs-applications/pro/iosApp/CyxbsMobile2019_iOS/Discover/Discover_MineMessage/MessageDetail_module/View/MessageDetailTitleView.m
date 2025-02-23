//
//  MessageDetailTitleView.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/5/11.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "MessageDetailTitleView.h"

#pragma mark - MessageDetailTitleView ()

@interface MessageDetailTitleView ()

/// 标题
@property (nonatomic, strong) UILabel *titleLab;

/// 头像
@property (nonatomic, strong) UIImageView *headImgView;

/// 名字
@property (nonatomic, strong) UILabel *userLab;

/// 时间
@property (nonatomic, strong) UILabel *timeLab;

@end

#pragma mark - MessageDetailTitleView

@implementation MessageDetailTitleView

#pragma mark - Life cycle

- (instancetype)initWithWidth:(CGFloat)width specialUserPublishModel:(UserPublishModel *)model {
    self = [super initWithFrame:CGRectMake(0, 0, width, 0)];
    if (self) {
        _userPublishModel = model;
        [self addSubview:self.titleLab];
        if ((model.headURL && ![model.headURL isEqualToString:@""]) && model.author) {
            // 状态：多
            [self addSubview:self.headImgView];
            [self addSubview:self.userLab];
            [self addSubview:self.timeLab];
            self.timeLab.left = self.userLab.left;
            self.timeLab.top = self.userLab.bottom;
        } else {
            // 状态：少
            [self addSubview:self.timeLab];
            self.timeLab.left = self.titleLab.left;
            self.timeLab.top = self.titleLab.bottom + 8;
        }
        self.height = self.timeLab.bottom;
    }
    return self;
}

#pragma mark - Getter

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
        _titleLab.numberOfLines = 0;
        _titleLab.font = [UIFont fontWithName:PingFangSCSemibold size:22];
        _titleLab.height = [self.userPublishModel.title heightForFont:_titleLab.font width:self.width];
        _titleLab.backgroundColor = UIColor.clearColor;
        _titleLab.text = self.userPublishModel.title;
        
        _titleLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1]
                              darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:1]];
    }
    return _titleLab;
}

- (UIImageView *)headImgView {
    if (_headImgView == nil) {
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.titleLab.bottom + 12, 28, 28)];
        _headImgView.layer.cornerRadius = _headImgView.width / 2;
        _headImgView.clipsToBounds = YES;
        
        [_headImgView setImageWithURL:[NSURL URLWithString:self.userPublishModel.headURL]
                          placeholder:[UIImage imageNamed:@"默认头像"]];
    }
    return _headImgView;
}

- (UILabel *)userLab {
    if (_userLab == nil) {
        _userLab = [[UILabel alloc] initWithFrame:CGRectMake(self.headImgView.right + 12, self.headImgView.top, 0, 17)];
        [_userLab stretchRight_toPointX:self.titleLab.right offset:0];
        _userLab.font = [UIFont fontWithName:PingFangSC size:12];
        _userLab.text = self.userPublishModel.author;
        _userLab.backgroundColor = UIColor.clearColor;
        
        _userLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1]
                              darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:1]];
    }
    return _userLab;
}

- (UILabel *)timeLab {
    if (_timeLab == nil) {
        _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
        _timeLab.text = self.userPublishModel.uploadDate;
        _timeLab.font = [UIFont fontWithName:PingFangSC size:11];
        
        _timeLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#142C52" alpha:0.4]
                              darkColor:[UIColor colorWithHexString:@"F0F0F0" alpha:0.55]];
    }
    return _timeLab;
}

@end
