//
//  MessageDetailTitleView.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/5/11.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserPublishModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageDetailTitleView : UIView

/// 保存一下模型
@property (nonatomic, readonly) UserPublishModel *userPublishModel;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/// 使用这个来创建
/// @param width 指定宽度，高度自适应了
/// @param model 奇怪的模型
- (instancetype)initWithWidth:(CGFloat)width specialUserPublishModel:(UserPublishModel *)model;

@end

NS_ASSUME_NONNULL_END
