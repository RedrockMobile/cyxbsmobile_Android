//
//  TestCardTableViewCell.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestCardTableViewCell : UITableViewCell
@property (nonatomic, weak)UILabel *weekTimeLabel;//十一周周一
@property (nonatomic, weak)UILabel *leftDayLabel;//还剩五天考试
@property (nonatomic, weak)UIView *bottomView;//背景淡蓝色蹄片
@property (nonatomic, weak)UILabel *subjectLabel;//大学物理
@property (nonatomic, weak)UIImageView *clockImage;//钟表图片
@property (nonatomic, weak)UIImageView *locationImage;//坐标图片
@property (nonatomic, weak)UILabel *testNatureLabel;//半期or期末
@property (nonatomic, weak)UILabel *dayLabel;//11月8日
@property (nonatomic, weak)UILabel *timeLabel;//14:00-16:00
@property (nonatomic, weak)UILabel *classLabel;//3402
@property (nonatomic, weak)UILabel *seatNumLabel;//58号
@end

NS_ASSUME_NONNULL_END
