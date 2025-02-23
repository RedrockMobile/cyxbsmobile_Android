//
//  SportAttendanceTableViewCell.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/3.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SportAttendanceItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface SportAttendanceTableViewCell : UITableViewCell

///打卡日期
@property (nonatomic, strong) UILabel *dateLab;
///打卡时间
@property (nonatomic, strong) UILabel *timeLab;
///打卡地点
@property (nonatomic, strong) UILabel *spotLab;
///打卡类型
@property (nonatomic, strong) UILabel *typeLab;
///有效图标
@property (nonatomic, strong) UIImageView *valiImgView;
///奖励图标
@property (nonatomic, strong) UIImageView *awardImgView;
///是否有效
@property (nonatomic, assign) bool valid;
///是否奖励
@property (nonatomic, assign) bool is_award;

/// Item数据模型
@property (nonatomic, strong) SportAttendanceItem *sa;

@end

NS_ASSUME_NONNULL_END
