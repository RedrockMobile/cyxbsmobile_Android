//
//  DetailsMainViewController.h
//  Details
//
//  Created by Edioth Jin on 2021/8/3.
//

#import "TopBarBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 邮票明细界面
 * 界面顶部一个自定义 topBar
 * 其次是一个选择控制器 segmentView - "SegmentView.h" ，控制切换用户可以看到的不同的视图
 * 选择控制器控制一个横向滑动，界面对应的 scrollView，用户可以看到不同的数据
 * scrollView包含两个界面，"DetailsTasksTableView.h", "DetailsgoodsTableView.h",分别对应任务记录和兑换记录
 */
@interface DetailsMainViewController : TopBarBasicViewController

@end

NS_ASSUME_NONNULL_END
