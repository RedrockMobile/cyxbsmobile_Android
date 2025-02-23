//
//  FeedBackTableViewCell.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
// model
#import "FeedBackModel.h"

NS_ASSUME_NONNULL_BEGIN
/**
 展示历史反馈的 cell
 */
@interface FeedBackTableViewCell : UITableViewCell

/// 标题
@property (nonatomic, strong) UILabel * titleLabel;
/// 小标题
@property (nonatomic, strong) UILabel * subtitleLabel;
/// 右侧的图片
@property (nonatomic, strong) UIImageView * rightImgView;
/// separator
@property (nonatomic, strong) UIView * separateLine;
/// 小红点
@property (nonatomic, strong) UIView * redSpotView;

@property (nonatomic, strong) FeedBackModel * cellModel;

@end

NS_ASSUME_NONNULL_END
