//
//  updatePopView.h
//  CyxbsMobile2019_iOS
//
//  Created by Clutch Powers on 2022/3/22.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///更新工具代理
@protocol updatePopViewDelegate <NSObject>

///取消更新
- (void) Cancel;

///更新
- (void) Update;

@end

@interface updatePopView : UIView

///主View
@property (nonatomic, strong) UIView *AlertView;

///背景
@property (nonatomic, strong) UIView *backView;

///代理
@property (nonatomic, weak) id<updatePopViewDelegate> delegate;

///初始化方法
- (instancetype) initWithFrame:(CGRect)frame WithUpdateInfo:(NSDictionary *)info;
@end

NS_ASSUME_NONNULL_END
