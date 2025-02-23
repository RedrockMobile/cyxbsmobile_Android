//
//  MainPageTableViewCell.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/2/22.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



/// 个人页面的评论和动态页面的cell的父类，实现了头像、昵称、时间戳、xx了你的动态/评论，其余不同的地方，子类自己实现
@interface MainPageTableViewCell : UITableViewCell

/// 时间label
@property (nonatomic, strong)UILabel *timeLabel;

/// 用户昵称
@property (nonatomic, strong)UILabel *nickNameLabel;

/// 赞/评论 了你的 评论/动态
@property (nonatomic, strong)UILabel *interactionInfoLabel;

/// 头像
@property(nonatomic,strong)UIImageView *headImgView;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end

NS_ASSUME_NONNULL_END
