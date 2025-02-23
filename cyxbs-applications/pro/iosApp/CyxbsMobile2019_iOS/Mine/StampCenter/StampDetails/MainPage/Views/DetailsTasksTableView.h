//
//  DetailsTasksTableView.h
//  Details
//
//  Created by Edioth Jin on 2021/8/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 获取详情的table
 * 用来展示用户完成的任务明细
 * 使用 dataMAry的setter方法更新数据
 */
@interface DetailsTasksTableView : UITableView

/// 展示的数据
@property (nonatomic, copy) NSArray * dataAry;

@end

NS_ASSUME_NONNULL_END
