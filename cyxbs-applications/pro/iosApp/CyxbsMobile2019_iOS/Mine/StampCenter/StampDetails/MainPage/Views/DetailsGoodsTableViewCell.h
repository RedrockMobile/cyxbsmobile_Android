//
//  DetailsgoodsTableViewCell.h
//  Details
//
//  Created by Edioth Jin on 2021/8/6.
//

#import "DetailsBaseTableViewCell.h"
// model
#import "DetailsGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 继承自 "DetailsBaseTableViewCell.h"
 * 隐藏 titleImgVie, rightIndicator
 */
@interface DetailsGoodsTableViewCell : DetailsBaseTableViewCell

/// 模型
@property (nonatomic, strong) DetailsGoodsModel * cellModel;

@end

NS_ASSUME_NONNULL_END
