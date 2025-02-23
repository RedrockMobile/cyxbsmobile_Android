//
//  MineMSSEnterBtn.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/9/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 消息中心、邮票中心、意见与反馈都是这个按钮
@interface MineMSSEnterBtn : UIButton

/// 按钮名字，如@"消息中心"
@property (nonatomic, strong)UILabel *nameLabel;

/// 按钮图标
@property (nonatomic, strong)UIImageView *iconImgView;

/// 未读消息数
@property (nonatomic)NSString *msgCnt;
@end

NS_ASSUME_NONNULL_END
