//
//  ExpressDetailCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/21.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "ExpressDetailCell.h"

@implementation ExpressDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;  // 无黑夜模式
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#0028FC" alpha:0.05];
    }
    [self.contentView addSubview:self.gradientView];
    [self.contentView addSubview:self.titleLab];
    [self setTitlePosition];
    return self;
}

#pragma mark - Method

/// 选中后的第一步是恢复初始状态
- (void)unselectedState {
    [UIView animateWithDuration:1.0 animations:^{
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#0028FC" alpha:0.05];
        self.gradientView.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
        self.gradientView.backgroundColor = [UIColor colorWithHexString:@"#4A44E4" alpha:0.1];
        // 颜色改变
        self.titleLab.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.7];
        self.percentLabel.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.5];
    } completion:^(BOOL finished) {
        [self.checkImage removeFromSuperview];
        [self.percentLabel removeFromSuperview];
    }];
}

/// 选中的cell的UI情况
- (void)selectCell {
    [self.contentView addSubview:self.percentLabel];
    [self addViewsAndPosition];
    [UIView animateWithDuration:0.5 animations:^{
            self.gradientView.backgroundColor = [UIColor colorWithHexString:@"#534EF3" alpha:1.0];
            [self setCheckImagePosition];  // 加入对勾
            self.titleLab.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:1.0];
            self.percentLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:1.0];
            self.contentView.backgroundColor = [UIColor colorWithHexString:@"#6C68EE" alpha:1.0];
    }];
}

/// 其他cell的UI情况
- (void)otherCell {
    [self.contentView addSubview:self.percentLabel];
    [self addViewsAndPosition];
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#0028FC" alpha:0.05];
        self.gradientView.backgroundColor = [UIColor colorWithHexString:@"#4A44E4" alpha:0.1];
        // 颜色改变
        self.titleLab.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.7];
        self.percentLabel.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.5];
    } completion:^(BOOL finished) {
        [self.checkImage removeFromSuperview];
    }];
}

/// 动画
- (void)animationWithGetVoted:(BOOL)getVoted votedChoice:(NSString *)votedChoice {
    if (getVoted) {
        // 分别得到gradientWidth
        CGFloat gradientWidth = self.bounds.size.width * self.percent.floatValue;
        if (self.titleLab.text == votedChoice) {
            // 是选中的cell
            [self selectCell];
        } else {
            [self otherCell];
        }
        self.userInteractionEnabled = NO;
        // 渐变动画
        [UIView animateWithDuration:1.5 animations:^{
            self.gradientView.frame = CGRectMake(0, 0, gradientWidth, self.bounds.size.height);
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
        }];
    } else {
        [self unselectedState];
    }
}

/// title与百分比
- (void)addViewsAndPosition {
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.percentLabel];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(36);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-71);
    }];
    
    [self.percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(35, 17));
    }];
}

/// 对勾图片
- (void)setCheckImagePosition {
    [self.contentView addSubview:self.checkImage];
    [self.checkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-51);
        make.size.mas_equalTo(CGSizeMake(17, 14));
    }];
}

- (void)setTitlePosition {
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(36);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-71);
    }];
}

-(void)setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.origin.y += 20;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 2 * frame.origin.x;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 30;
    self.clipsToBounds = YES;
    
    [super setFrame:frame];
}


#pragma mark - Getter

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(36, 16, self.contentView.bounds.size.width - 36 - 78, 20)];
        _titleLab.textColor = [UIColor colorWithHexString:@"#15315B"];
        _titleLab.font = [UIFont fontWithName:PingFangSCRegular size:14];
        // test
        _titleLab.text = @"你是否支持iPhone的接口将要统—接口";
    }
    return _titleLab;
}
- (UIImageView *)checkImage {
    if (_checkImage == nil) {
        _checkImage = [[UIImageView alloc] init];
        _checkImage.image = [UIImage imageNamed:@"Express_vector"];
    }
    return _checkImage;
}
- (UILabel *)percentLabel {
    if (_percentLabel == nil) {
        _percentLabel = [[UILabel alloc] init];
        _percentLabel.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.5];
        _percentLabel.font = [UIFont fontWithName:PingFangSCMedium size:12];
        _percentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _percentLabel;
}

- (UIView *)gradientView {
    if (_gradientView == nil) {
        _gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
    }
    return _gradientView;
}

@end
