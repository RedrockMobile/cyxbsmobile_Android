//
//  ScheduleCollectionViewLayout.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/4.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**ScheduleCollectionViewLayout视图布局
 * 设置所有陈列出来的属性，来达到最佳的视觉效果
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ScheduleCollectionViewLayout;

#pragma mark - ScheduleCollectionViewLayoutDelegate

@protocol ScheduleCollectionViewLayoutDataSource <NSObject>

@required

/// 星期几
/// @param collectionView 视图
/// @param layout 布局
/// @param indexPath 下标
- (NSUInteger)collectionView:(UICollectionView *)collectionView
                      layout:(ScheduleCollectionViewLayout *)layout
      weekForItemAtIndexPath:(NSIndexPath *)indexPath;

/// 第几节-长度
/// @param collectionView 视图
/// @param layout 布局
/// @param indexPath 下标
- (NSRange)collectionView:(UICollectionView *)collectionView
                   layout:(ScheduleCollectionViewLayout *)layout
  rangeForItemAtIndexPath:(NSIndexPath *)indexPath;




- (NSComparisonResult)collectionView:(UICollectionView *)collectionView
                              layout:(ScheduleCollectionViewLayout *)layout
              compareOriginIndexPath:(NSIndexPath *)originIndexPath
               conflictWithIndexPath:(NSIndexPath *)conflictIndexPath
                   relayoutWithBlock:(void (^)(NSRange originRange, NSRange comflictRange))block;

@end

#pragma mark - ScheduleCollectionViewLayout

@interface ScheduleCollectionViewLayout : UICollectionViewLayout

/// 代理
@property (nonatomic, weak) id <ScheduleCollectionViewLayoutDataSource> dataSource;

/// 行间距
@property (nonatomic) CGFloat lineSpacing;

/// 列间距
@property (nonatomic) CGFloat columnSpacing;

/// 前部装饰视图宽
@property (nonatomic) CGFloat widthForLeadingSupplementaryView;

/// 头部装饰视图高
@property (nonatomic) CGFloat heightForHeaderSupplementaryView;

@end

NS_ASSUME_NONNULL_END
