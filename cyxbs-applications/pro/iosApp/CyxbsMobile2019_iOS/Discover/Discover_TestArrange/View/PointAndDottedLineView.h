//
//  PointAndDottedLineView.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 用来装饰考试安排页面tableView的圆点点和虚线
@interface PointAndDottedLineView : UIView
/// 圆点点由一个大圆和一个小圆堆叠而成，这个是大圆
@property (nonatomic, weak)UIView *bigCircle;
/// 圆点点由一个大圆和一个小圆堆叠而成，这个是小圆
@property (nonatomic, weak)UIView *smallCircle;
@property(nonatomic)BOOL isNoExam;
/// 这是一个用来装饰考试安排页面tableView 的圆点点和虚线的结合
/// @param pointCount 圆点点的个数
/// @param spacing 两个圆点点之间的距离
- (instancetype) initWithPointCount:(int) pointCount Spacing: (CGFloat) spacing;
@end

NS_ASSUME_NONNULL_END
