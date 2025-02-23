//
//  MessageMoreCell.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/19.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "MessageMoreCell.h"

#pragma mark - MessageMoreCell ()

@interface MessageMoreCell ()

/// 图片
@property (nonatomic, strong) UIImageView *moreImgView;

/// 文字
@property (nonatomic, strong) UILabel *moreTitleLab;

@end

#pragma mark - MessageMoreCell

@implementation MessageMoreCell

#pragma mark - Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.moreImgView];
        [self.contentView addSubview:self.moreTitleLab];
        self.needBall = NO;
    }
    return self;
}

#pragma mark - Method

- (void)drawRect:(CGRect)rect {
    self.moreImgView.centerY = self.contentView.SuperCenter.y;
    self.moreTitleLab.left = self.moreImgView.right + 15;
    
    self.moreTitleLab.top = self.moreImgView.top;
    [self.moreTitleLab stretchRight_toPointX:self.contentView.right offset:15];
}

- (void)drawImg:(UIImage *)img title:(NSString *)title {
    self.moreImgView.image = img;
    self.moreTitleLab.text = title;
}

#pragma mark - Setter

- (UIImageView *)moreImgView {
    if (_moreImgView == nil) {
        _moreImgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 18, 18)];
    }
    return _moreImgView;
}

- (UILabel *)moreTitleLab {
    if (_moreTitleLab == nil) {
        _moreTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 20)];
        _moreTitleLab.font = [UIFont fontWithName:PingFangSC size:14];
        
        _moreTitleLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1]
                              darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
    }
    return _moreTitleLab;
}

#pragma mark - Getter

- (void)setNeedBall:(BOOL)needBall {
    if (needBall) {
        self.moreImgView.image = [UIImage imageNamed:@"setting_s"];
    } else {
        self.moreImgView.image = [UIImage imageNamed:@"setting"];
    }
    _needBall = needBall;
}

@end
