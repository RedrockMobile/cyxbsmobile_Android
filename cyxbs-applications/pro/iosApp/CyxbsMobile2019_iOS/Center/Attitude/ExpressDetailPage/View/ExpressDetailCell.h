//
//  ExpressDetailCell.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/21.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpressDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *checkImage;
@property (nonatomic, strong) UILabel *percentLabel;
/// 渐变层
@property (nonatomic, strong) UIView *gradientView;
/// 选项的投票比例
@property (nonatomic, strong) NSNumber *percent;
/// 选项的投票比例
@property (nonatomic, strong) NSNumber *prePercent;

/// 选中后的第一步是恢复初始状态
- (void)unselectedState;

/// 选中的cell的UI情况
- (void)selectCell;

/// 其他cell的UI情况
- (void)otherCell;

///动画
- (void)animationWithGetVoted:(BOOL)getVoted votedChoice:(NSString *)votedChoice;

@end

NS_ASSUME_NONNULL_END
