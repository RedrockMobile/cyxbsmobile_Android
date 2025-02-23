//
//  ScheduleSupplementaryCollectionViewCell.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/19.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 复用标志
UIKIT_EXTERN NSString *ScheduleSupplementaryCollectionViewCellReuseIdentifier;

#pragma mark - ScheduleSupplementaryCollectionViewCell

@interface ScheduleSupplementaryCollectionViewCell : UICollectionViewCell

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 重点
@property (nonatomic) BOOL isCurrent;

/// 单显示
@property (nonatomic) BOOL isTitleOnly;

/// 标题
@property (nonatomic, copy) NSString *title;

/// 细节
@property (nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
