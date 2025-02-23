//
//  DetailsTaskTableViewCell.h
//  Details
//
//  Created by Edioth Jin on 2021/8/6.
//

#import "DetailsBaseTableViewCell.h"
// model
#import "DetailsTaskModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 继承自 "DetailsBaseTableViewCell.h"
 * 隐藏 titleImgVie, rightIndicator
 */
@interface DetailsTaskTableViewCell : DetailsBaseTableViewCell

@property (nonatomic, strong) DetailsTaskModel * cellModel;

@end

NS_ASSUME_NONNULL_END
