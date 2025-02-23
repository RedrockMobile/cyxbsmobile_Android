//
//  SystemMessageCell.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/18.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SystemMessageCell.h"

#pragma mark - SystemMessageCell ()

@interface SystemMessageCell ()

/// 展示标题
@property (nonatomic, strong) UILabel *msgTitleLab;

/// 展示内容
@property (nonatomic, strong) UILabel *msgDetailLab;

/// 展示消息时间
@property (nonatomic, strong) UILabel *msgTimeLab;

/// 展示已读标记
@property (nonatomic, strong) UIView *readBall;

@end

#pragma mark - SystemMessageCell

@implementation SystemMessageCell

#pragma mark - Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.backgroundColor = UIColor.clearColor;
        _hadRead = YES;
        
        [self.contentView addSubview:self.msgTimeLab];
        [self.contentView addSubview:self.msgTitleLab];
        [self.contentView addSubview:self.msgDetailLab];
    }
    return self;
}

#pragma mark - Method

- (void)drawRect:(CGRect)rect {
    self.msgTimeLab.top = 26;
    self.msgTimeLab.right = self.contentView.SuperRight - 16;
    
    self.msgTitleLab.centerY = self.msgTimeLab.centerY;
    self.msgTitleLab.left = 30;
    self.msgTitleLab.width = 167;
    
    self.msgDetailLab.top = self.msgTitleLab.bottom + 6;
    self.msgDetailLab.left = self.msgTitleLab.left = 30;
    [self.msgDetailLab stretchRight_toPointX:self.msgTimeLab.right offset:5];
    
    self.readBall.center = CGPointMake(self.msgTitleLab.left / 2, self.msgTitleLab.centerY);
    
    [self customMultipleChioce];
}

- (void)drawWithTitle:(NSString *)title content:(NSString *)content date:(NSString *)date {
    self.msgTitleLab.text = title;
    self.msgDetailLab.text = content;
    self.msgTimeLab.text = date;
}

-(void)customMultipleChioce{
    if (self.editing) {
        UIImageView *imgView = self.subviews.lastObject.subviews.firstObject;
        imgView.tintColor = [UIColor xFF_R:88 G:82 B:255 Alpha:1];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (editing) {
        [self customMultipleChioce];
    }
    [UIView
     animateWithDuration:0.17
     animations:^{
        self.msgTimeLab.right = self.contentView.SuperRight - 16;
        [self.msgDetailLab stretchRight_toPointX:self.contentView.SuperRight offset:16];
    }];
}

#pragma mark - Getter

- (UILabel *)msgTimeLab {
    if (_msgTimeLab == nil) {
        _msgTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 70, 15)];
        _msgTimeLab.backgroundColor = UIColor.clearColor;
        _msgTimeLab.font = [UIFont fontWithName:PingFangSC size:12];
        
        _msgTimeLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.7] darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:0.55]];
    }
    return _msgTimeLab;
}

- (UILabel *)msgTitleLab {
    if (_msgTitleLab == nil) {
        _msgTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 28, 0, 22)];
        [_msgTitleLab stretchRight_toPointX:self.msgTimeLab.left offset:5];
        _msgTitleLab.backgroundColor = UIColor.clearColor;
        _msgTitleLab.font = [UIFont fontWithName:PingFangSCSemibold size:16];
        
        _msgTitleLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor xFF_R:17 G:44 B:84 Alpha:1]
                              darkColor:[UIColor xFF_R:240 G:240 B:240 Alpha:1]];
    }
    return _msgTitleLab;
}

- (UILabel *)msgDetailLab {
    if (_msgDetailLab == nil) {
        _msgDetailLab = [[UILabel alloc] initWithFrame:CGRectMake(self.msgTitleLab.left, self.msgTitleLab.bottom + 6, 0, 20)];
        _msgDetailLab.backgroundColor = UIColor.clearColor;
        _msgDetailLab.font = [UIFont fontWithName:PingFangSC size:14];
        _msgDetailLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor xFF_R:17 G:44 B:84 Alpha:1]
                              darkColor:[UIColor xFF_R:240 G:240 B:240 Alpha:1]];
    }
    return _msgDetailLab;
}

- (UIView *)readBall {
    if (_readBall == nil) {
        _readBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
        _readBall.backgroundColor = [UIColor xFF_R:255 G:98 B:98 Alpha:1];
        _readBall.layer.cornerRadius = _readBall.width / 2;
        _readBall.centerY = self.msgTitleLab.centerY;
        _readBall.right = self.msgTitleLab.left - 5;
    }
    return _readBall;
}

#pragma mark - Setter

- (void)setHadRead:(BOOL)hadRead {
    if (_hadRead == hadRead) {
        return;
    }
    if (!hadRead) {
        [self.contentView addSubview:self.readBall];
    } else {
        [self.readBall removeFromSuperview];
    }
    _hadRead = hadRead;
}

@end
