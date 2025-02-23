//
//  ActiveMessageCell.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/20.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ActiveMessageCell.h"

#import "NSString+UILabel.h"

CGFloat _activeMessageCellMaxHeight = 0;

#pragma mark - ActiveMessageCell ()

@interface ActiveMessageCell ()

/// 标题
@property (nonatomic, strong) UILabel *msgTitleLab;

/// 头像
@property (nonatomic, strong) UIImageView *headImgView;

/// 作者
@property (nonatomic, strong) UILabel *authorNameLab;

/// 发布时间
@property (nonatomic, strong) UILabel *msgTimeLab;

/// 内容/自动布局
@property (nonatomic, strong) UILabel *msgContentLab;

/// 一个细节图片
@property (nonatomic, strong) UIImageView *msgImgView;

/// 已读标志
@property (nonatomic, strong) UIView *readBall;

/// 文字高度，快速
@property (nonatomic) CGFloat fastContentHeight;

@end

#pragma mark - ActiveMessageCell

@implementation ActiveMessageCell

#pragma mark - Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        _hadRead = YES;
        
        [self.contentView addSubview:self.msgTitleLab];
        [self.contentView addSubview:self.headImgView];
        [self.contentView addSubview:self.authorNameLab];
        [self.contentView addSubview:self.msgTimeLab];
        [self.contentView addSubview:self.msgContentLab];
        [self.contentView addSubview:self.msgImgView];
        
    }
    return self.activeCellDefaultStyle;
}

#pragma mark - Method

- (void)drawRect:(CGRect)rect {
    [self.msgTitleLab stretchRight_toPointX:self.contentView.SuperRight offset:30];
    
    [self.authorNameLab stretchRight_toPointX:self.msgTitleLab.right offset:0];
    
    self.msgContentLab.width = self.msgTitleLab.width;
    CGFloat height =
    [self.msgContentLab.text
     heightForSize:CGSizeMake(SCREEN_WIDTH - 2 * 17, 0)
     font:[UIFont fontWithName:PingFangSC size:14]];
    self.msgContentLab.height = height < _activeMessageCellMaxHeight ? height : _activeMessageCellMaxHeight;
    
    self.msgImgView.top = self.msgContentLab.bottom + 12;
    self.msgImgView.width = self.msgContentLab.width;
    self.msgImgView.height = 193.0 / 343.0 * self.msgImgView.width;
}

- (instancetype)activeCellDefaultStyle {
    self.msgTitleLab.text = @"";
    self.headImgView.image = [UIImage imageNamed:@"默认头像"];
    self.authorNameLab.text = @"";
    self.msgTimeLab.text = @"";
    self.msgContentLab.text = @"\n\n";
    self.msgImgView.image = [UIImage imageNamed:@"default_background"];
    return self;
}

+ (CGFloat)heightForContent:(NSString *)content
                   forWidth:(CGFloat)width {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _activeMessageCellMaxHeight = [@"r\ni\ns\ne" heightForSize:CGSizeMake(width, 0) font:[UIFont fontWithName:PingFangSC size:14]];
    });
    CGFloat contentHeight = [content
                             heightForSize:CGSizeMake(width, 0)
                             font:[UIFont fontWithName:PingFangSC size:14]];
    /// 计算高度，由文字最小高度+固定的头部高度+imgeView的计算高度组成
    return (_activeMessageCellMaxHeight < contentHeight ? _activeMessageCellMaxHeight : contentHeight) + 140 + (SCREEN_WIDTH - 2 * 30) * 193.0 / 343.0;
}

- (CGSize)drawTitle:(NSString *)title
            headURL:(NSString *)headUrl
             author:(NSString *)authorName
               date:(NSString *)date
            content:(NSString *)content
          msgImgURL:(NSString *)imgUrl {
    [self setNeedsDisplay];
    self.msgTitleLab.text = title;
    
    [self.headImgView
     setImageWithURL:[NSURL URLWithString:headUrl]
     placeholder:[UIImage imageNamed:@"默认头像"]];
    
    self.authorNameLab.text = authorName;
    self.msgTimeLab.text = date;
    
    self.msgContentLab.text = content;
    
    [self.msgImgView setImageWithURL:[NSURL URLWithString:imgUrl] placeholder:[UIImage imageNamed:@"default_background"]];
    return CGSizeZero;
}

#pragma mark - Getter

- (UILabel *)msgTitleLab {
    if (_msgTitleLab == nil) {
        _msgTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 24, 0, 25)];
        _msgTitleLab.font = [UIFont fontWithName:PingFangSC size:18];
        
        _msgTitleLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1]
                              darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
    }
    return _msgTitleLab;
}

- (UIImageView *)headImgView {
    if (_headImgView == nil) {
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.msgTitleLab.left, self.msgTitleLab.bottom + 10, 28, 28)];
        _headImgView.layer.cornerRadius = _headImgView.width / 2;
        _headImgView.clipsToBounds = YES;
        _headImgView.backgroundColor = UIColor.grayColor;
    }
    return _headImgView;
}

- (UILabel *)authorNameLab {
    if (_authorNameLab == nil) {
        _authorNameLab = [[UILabel alloc] initWithFrame:CGRectMake(self.headImgView.right + 12, self.headImgView.top, 0, 17)];
        _authorNameLab.font = [UIFont fontWithName:PingFangSC size:12];
        
        _authorNameLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
    }
    return _authorNameLab;
}

- (UILabel *)msgTimeLab {
    if (_msgTimeLab == nil) {
        _msgTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.authorNameLab.left, self.authorNameLab.bottom, 100, 15)];
        _msgTimeLab.font = [UIFont fontWithName:PingFangSC size:11];
        
        _msgTimeLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#142C52" alpha:0.4]
                              darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:0.55]];
    }
    return _msgTimeLab;
}

- (UILabel *)msgContentLab {
    if (_msgContentLab == nil) {
        _msgContentLab = [[UILabel alloc] initWithFrame:CGRectMake(self.msgTitleLab.left, self.headImgView.bottom + 14, 0, 80)];
        _msgContentLab.numberOfLines = 4;
        _msgContentLab.font = [UIFont fontWithName:PingFangSC size:14];
        
        _msgContentLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
    }
    return _msgContentLab;
}

- (UIImageView *)msgImgView {
    if (_msgImgView == nil) {
        _msgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.msgTitleLab.left, self.msgContentLab.bottom + 12, 0, 0)];
        _msgImgView.layer.cornerRadius = 15;
        _msgImgView.clipsToBounds = YES;
        _msgImgView.contentMode = UIViewContentModeScaleToFill;
        _msgImgView.backgroundColor = UIColor.grayColor;
    }
    return _msgImgView;
}

- (UIView *)readBall {
    if (_readBall == nil) {
        _readBall = [[UIView alloc] initWithFrame:CGRectMake(-12, 0, 6, 6)];
        _readBall.centerY = self.msgTitleLab.SuperCenter.y;
        _readBall.backgroundColor = [UIColor xFF_R:255 G:98 B:98 Alpha:1];
        _readBall.layer.cornerRadius = _readBall.width / 2;
    }
    return _readBall;
}

#pragma mark - Setter

- (void)setHadRead:(BOOL)hadRead {
    if (_hadRead == hadRead) {
        return;
    }
    if (!hadRead) {
        [self.msgTitleLab addSubview:self.readBall];
    } else {
        [self.readBall removeFromSuperview];
    }
    _hadRead = hadRead;
}

@end
