//
//  ScheduleCollectionViewCell.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/5.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**ScheduleCollectionViewCellDrawType课程表视图
 * 请在每次dequeueReusable后设置所有值
 * 否则会在下一次复用的时候，用上一次的值
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 复用标志
UIKIT_EXTERN NSString *ScheduleCollectionViewCellReuseIdentifier;

#pragma mark - ENUM(ScheduleCollectionViewCellDrawType)

typedef NS_ENUM(NSUInteger, ScheduleCollectionViewCellDrawType) {
    ScheduleCollectionViewCellDrawMorning,   // 早上
    ScheduleCollectionViewCellDrawAfternoon, // 下午
    ScheduleCollectionViewCellDrawNight,     // 晚上
    ScheduleCollectionViewCellDrawOthers,    // 他人
    ScheduleCollectionViewCellDrawCustom     // 事务
};

#pragma mark - ScheduleCollectionViewCell

@interface ScheduleCollectionViewCell : UICollectionViewCell

/// 绘制类型
@property (nonatomic) ScheduleCollectionViewCellDrawType drawType;

/// 标题(计算属性)
@property (nonatomic, copy) NSString *courseTitle;

/// 细节(计算属性)
@property (nonatomic, copy) NSString *courseContent;

/// 多人标识
@property (nonatomic) BOOL multipleSign;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
