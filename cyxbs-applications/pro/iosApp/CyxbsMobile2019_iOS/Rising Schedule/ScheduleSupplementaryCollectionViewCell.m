//
//  ScheduleSupplementaryCollectionViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/19.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleSupplementaryCollectionViewCell.h"

NSString *ScheduleSupplementaryCollectionViewCellReuseIdentifier = @"ScheduleSupplementaryCollectionViewCell";

#pragma mark - ScheduleSupplementaryCollectionViewCell ()

@interface ScheduleSupplementaryCollectionViewCell ()

/// 标题
@property (nonatomic, strong) UILabel *titleLab;

/// 细节
@property (nonatomic, strong) UILabel *contentLab;

/// 布局
@property (nonatomic, strong) UICollectionViewLayoutAttributes *attributes;

@end

#pragma mark - ScheduleSupplementaryCollectionViewCell

@implementation ScheduleSupplementaryCollectionViewCell

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 8;
        self.contentView.clipsToBounds = YES;
        self.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentLab];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    _attributes = layoutAttributes;
    
    self.contentLab.left = self.titleLab.left = 0;
    self.contentLab.width = self.titleLab.width = layoutAttributes.size.width;
    
    if (self.isTitleOnly) {
        self.titleLab.centerY = _attributes.size.height / 2;
        self.contentLab.alpha = 0;
    } else {
        self.titleLab.top = 6;
        self.contentLab.alpha = 1;
    }
    
    self.contentLab.bottom = _attributes.size.height - 3;
}

#pragma mark - Method

- (void)setIsCurrent:(BOOL)isCurrent {
    if (_isCurrent == isCurrent) {
        return;
    }
    _isCurrent = isCurrent;
    
    if (isCurrent) {
        self.contentView.backgroundColor =
        [UIColor dm_colorWithLightColor:UIColorHex(#2A4E84)
                              darkColor:UIColorHex(#5A5A5ACC)];
        self.titleLab.textColor =
        [UIColor dm_colorWithLightColor:UIColorHex(#FFFFFF)
                              darkColor:UIColorHex(#F0F0F2)];
    } else {
        self.contentView.backgroundColor = UIColor.clearColor;
        self.titleLab.textColor =
        [UIColor dm_colorWithLightColor:UIColorHex(#15315B)
                              darkColor:UIColorHex(#F0F0F2)];
    }
}

#pragma mark - Getter

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, -1, 20)];
        _titleLab.backgroundColor = UIColor.clearColor;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont fontWithName:PingFangSC size:12];
        _titleLab.textColor =
        [UIColor dm_colorWithLightColor:UIColorHex(#15315B)
                              darkColor:UIColorHex(#F0F0F2)];
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (_contentLab == nil) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLab.left, -1, -1, 20)];
        _contentLab.backgroundColor = UIColor.clearColor;
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.font = [UIFont fontWithName:PingFangSC size:11];
        _contentLab.textColor =
        [UIColor dm_colorWithLightColor:UIColorHex(#606E8A)
                              darkColor:UIColorHex(#868686)];
    }
    return _contentLab;
}

- (NSString *)title {
    return self.titleLab.text.copy;
}

- (NSString *)content {
    return self.titleLab.text.copy;
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title {
    self.titleLab.text = title.copy;
}

- (void)setContent:(NSString *)content {
    self.contentLab.text = content.copy;
}

- (void)setIsTitleOnly:(BOOL)isTitleOnly {
    _isTitleOnly = isTitleOnly;
    if (_attributes) {
        [self applyLayoutAttributes:_attributes];
    }
}

@end
