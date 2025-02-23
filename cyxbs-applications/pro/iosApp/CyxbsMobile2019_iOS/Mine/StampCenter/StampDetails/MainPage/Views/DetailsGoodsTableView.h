//
//  goodsTableView.h
//  Details
//
//  Created by Edioth Jin on 2021/8/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 兑换详情的table
 * 用来展示用户兑换的商品明细
 * 使用 dataAry的setter方法更新数据
 */
@interface DetailsGoodsTableView : UITableView

/// 数据
@property (nonatomic, copy) NSArray * dataAry;

@end

NS_ASSUME_NONNULL_END
