//
//  AttitudeHomeCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/7.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "AttitudeHomeCell.h"
@interface AttitudeHomeCell()
@property (nonatomic, strong) UIImageView *imageLeft;
@property (nonatomic, strong) UIImageView *imageRight;
@end

@implementation AttitudeHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.imageLeft];
        [self.contentView addSubview:self.imageRight];
        [self setPosition];
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFF"];
    }
    return self;
}


// 间隙+圆角
-(void)setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.origin.y += 20;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 2 * frame.origin.x;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15;
    self.clipsToBounds = YES; // 添加之后点击cell就不会发生圆角消失
    [super setFrame:frame];
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont fontWithName:PingFangSCMedium size:18];
        _title.numberOfLines = 0;
        _title.textColor = [UIColor colorWithHexString:@"#242172"];
    }
    return _title;
}

- (UIImageView *)imageLeft {
    if (!_imageLeft) {
        _imageLeft = [[UIImageView alloc] init];
        _imageLeft.image = [UIImage imageNamed:@"Attitude_cellImageLeft"];
    }
    return _imageLeft;
}

- (UIImageView *)imageRight {
    if (!_imageRight) {
        _imageRight = [[UIImageView alloc] init];
        _imageRight.image = [UIImage imageNamed:@"Attitude_cellImageRight"];
    }
    return _imageRight;
}

- (void)setPosition {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(29);
        make.right.equalTo(self).mas_offset(-35);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    [self.imageLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(5);
        make.top.equalTo(self);
        make.width.equalTo(@54);
        make.height.equalTo(@41);
    }];
    [self.imageRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(@105);
        make.height.equalTo(@65);
    }];
}
@end
