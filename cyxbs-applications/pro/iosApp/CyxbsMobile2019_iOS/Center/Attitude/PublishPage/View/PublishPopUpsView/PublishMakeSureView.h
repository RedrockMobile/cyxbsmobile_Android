//
//  PublishMakeSureView.h
//  CyxbsMobile2019_iOS
//
//  Created by 宋开开 on 2023/3/17.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishMakeSureView : UIView

/// “我再想想”按钮
@property (nonatomic, strong) UIButton *cancelBtn;

/// “确认发布”按钮
@property (nonatomic, strong) UIButton *sureBtn;

@end

NS_ASSUME_NONNULL_END
