//
//  DayBarView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/16.
//  Copyright © 2020 Redrock. All rights reserved.
//显示星期、月份、日期信息的view

#import <UIKit/UIKit.h>
//每一个小块的宽度
#define DAY_BAR_ITEM_W (MAIN_SCREEN_W*0.1227)
//每一个小块高度
#define DAY_BAR_ITEM_H (MAIN_SCREEN_W*0.1333)
NS_ASSUME_NONNULL_BEGIN

@interface DayBarView : UIView

/// 非整学期页用这个方法初始化
/// @param dataArray dataArray是一周7天的日期信息
- (instancetype)initWithDataArray:(NSArray*)dataArray;

///整学期页的dayBar创建后要用这个方法初始化
- (instancetype)initForWholeTerm;
@end

NS_ASSUME_NONNULL_END
