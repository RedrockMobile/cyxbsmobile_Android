//
//  MainPageNumBtn.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/2/22.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 带个小红点、标题、显示标题对应的模块的数据个数，标题如@"动态"、@"评论"、@"获赞"
@interface MainPageNumBtn : UIButton

/// 按钮名称如@"动态"
@property(nonatomic, strong)UILabel *btnNameLabel;

/// 动态个数是用UIButton的titleLabel来显示的

/// 是否隐藏蓝色的点，YES则隐藏
@property(nonatomic)BOOL hideTipView;
@end

NS_ASSUME_NONNULL_END
