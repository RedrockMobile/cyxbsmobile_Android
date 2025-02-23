//
//  ScheduleCollectionViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/5.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleCollectionViewCell.h"

NSString *ScheduleCollectionViewCellReuseIdentifier = @"ScheduleCollectionViewCell";

#pragma mark - ScheduleCollectionViewCell ()

@interface ScheduleCollectionViewCell ()

/// 标题
@property (nonatomic, strong) UILabel *titleLab;

/// 细节
@property (nonatomic, strong) UILabel *contentLab;

/// 多人
@property (nonatomic, strong) UIView *multyView;

@end

#pragma mark - ScheduleCollectionViewCell

@implementation ScheduleCollectionViewCell

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _drawType = -1;
        self.backgroundColor = UIColor.clearColor;
        self.contentView.layer.cornerRadius = 8;
        self.contentView.clipsToBounds = YES;
        [self.contentView addSubview:self.multyView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentLab];
    }
    return self;
}

#pragma mark - Method

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    CGRect frame = layoutAttributes.frame;
    
    self.multyView.right = frame.size.width - 5;
    
    self.titleLab.width = frame.size.width - 2 * self.titleLab.left;
    
    self.contentLab.left = self.titleLab.left;
    self.contentLab.width = self.titleLab.width;
    self.contentLab.bottom = frame.size.height - 8;
}

#pragma mark - Getter

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, -1, -1)];
        _titleLab.backgroundColor = UIColor.clearColor;
        _titleLab.numberOfLines = 3;
        _titleLab.font = [UIFont fontWithName:PingFangSC size:10];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (_contentLab == nil) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.backgroundColor = UIColor.clearColor;
        _contentLab.numberOfLines = 3;
        _contentLab.font = [UIFont fontWithName:PingFangSC size:10];
        _contentLab.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLab;
}

- (UIView *)multyView {
    if (_multyView == nil) {
        _multyView = [[UIView alloc] initWithFrame:CGRectMake(-1, 4, 8, 2)];
        _multyView.layer.cornerRadius = _multyView.height / 2;
        _multyView.clipsToBounds = YES;
        _multyView.alpha = 0;
    }
    return _multyView;
}

- (NSString *)courseTitle {
    return self.titleLab.text.copy;
}

- (NSString *)courseContent {
    return self.contentLab.text.copy;
}

#pragma mark - Setter

- (void)setCourseTitle:(NSString *)courseTitle {
    self.titleLab.text = courseTitle.copy;
    CGFloat width = self.titleLab.width;
    [self.titleLab sizeToFit];
    self.titleLab.width = width;
}

- (void)setCourseContent:(NSString *)courseContent {
    self.contentLab.text = courseContent.copy;
    CGFloat width = self.contentLab.width;
    CGFloat bottom = self.contentLab.bottom;
    [self.contentLab sizeToFit];
    self.contentLab.width = width;
    self.contentLab.bottom = bottom;
}

- (void)setMultipleSign:(BOOL)multipleSign {
    if (_multipleSign != multipleSign) {
        return;
    }
    _multipleSign = multipleSign;
    
    self.multyView.alpha = multipleSign ? 1 : 0;
}

- (void)setDrawType:(ScheduleCollectionViewCellDrawType)drawType {
    if (_drawType == drawType) {
        return;
    }
    _drawType = drawType;
    
    switch (drawType) {
        /*ScheduleCollectionViewCellDrawMorning*/
        case ScheduleCollectionViewCellDrawMorning: {
            self.contentView.backgroundColor =
            [UIColor dm_colorWithLightColor:UIColorHex(#F9E7D8)
                                  darkColor:UIColorHex(#FFCCA126)];
            
            self.titleLab.textColor = self.contentLab.textColor = self.multyView.backgroundColor =
            [UIColor dm_colorWithLightColor:UIColorHex(#FF8015)
                                  darkColor:UIColorHex(#F0F0F2CC)];
        } break;
            
        /*ScheduleCollectionViewCellDrawAfternoon*/
        case ScheduleCollectionViewCellDrawAfternoon: {
            self.contentView.backgroundColor =
            [UIColor dm_colorWithLightColor:UIColorHex(#F9E3E4)
                                  darkColor:UIColorHex(#FF979B26)];
            
            self.titleLab.textColor = self.contentLab.textColor = self.multyView.backgroundColor =
            [UIColor dm_colorWithLightColor:UIColorHex(#FF6262)
                                  darkColor:UIColorHex(#F0F0F2CC)];
        } break;
            
        /*ScheduleCollectionViewCellDrawNight*/
        case ScheduleCollectionViewCellDrawNight: {
            self.contentView.backgroundColor =
            [UIColor dm_colorWithLightColor:UIColorHex(#DDE3F8)
                                  darkColor:UIColorHex(#9BB2FB26)];
            
            self.titleLab.textColor = self.contentLab.textColor = self.multyView.backgroundColor =
            [UIColor dm_colorWithLightColor:UIColorHex(#4066EA)
                                  darkColor:UIColorHex(#F0F0F2CC)];
        } break;
            
        /*ScheduleCollectionViewCellDrawOthers*/
        case ScheduleCollectionViewCellDrawOthers: {
            self.contentView.backgroundColor =
            [UIColor dm_colorWithLightColor:UIColorHex(#DFF3FC)
                                  darkColor:UIColorHex(#90DBFB26)];
            
            self.titleLab.textColor = self.contentLab.textColor = self.multyView.backgroundColor =
            [UIColor dm_colorWithLightColor:UIColorHex(#06A3FC)
                                  darkColor:UIColorHex(#F0F0F2CC)];
        } break;
            
        /*ScheduleCollectionViewCellDrawCustom*/
        case ScheduleCollectionViewCellDrawCustom: {
            self.contentView.backgroundColor =
            [UIColor dm_colorWithLightColor:UIColorHex(#E9ECF0)
                                  darkColor:UIColorHex(#3C4E70)];
            
            self.titleLab.textColor = self.contentLab.textColor = self.multyView.backgroundColor =
            [UIColor dm_colorWithLightColor:UIColorHex(#4D4D4D)
                                  darkColor:UIColorHex(#F0F0F2CC)];
        } break;
    }
}

@end
