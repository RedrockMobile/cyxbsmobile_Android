//
//  FakeTabBarView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/25.
//  Copyright © 2020 Redrock. All rights reserved.
//课表顶部一个长得和显示课信息的tabBar一模一样的bar，用来制造底部bar随课表拖动的假象

#import <UIKit/UIKit.h>
#import "FYHCycleLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FakeTabBarView : UIView

/// 当前课程名称
@property (nonatomic, weak) FYHCycleLabel *classLabel;

/// 时钟图片
@property (nonatomic, weak) UIImageView *clockImageView;

/// 当前课程时段
@property (nonatomic, weak) FYHCycleLabel *classTimeLabel;

/// 教室地点图片
@property (nonatomic, weak) UIImageView *locationImageView;

/// 教室地点
@property (nonatomic, weak) FYHCycleLabel *classroomLabel;
- (void)updateSchedulTabBarViewWithDic:(NSDictionary *)paramDict;
@end

NS_ASSUME_NONNULL_END
