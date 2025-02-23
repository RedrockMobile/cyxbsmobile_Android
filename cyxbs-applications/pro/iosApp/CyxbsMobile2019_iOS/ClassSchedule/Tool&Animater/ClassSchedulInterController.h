//
//  ClassSchedulInterController.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/24.
//  Copyright © 2020 Redrock. All rights reserved.
//过渡手势管理者，作用：更新转场动画进度、在恰当的时机取消转场或者完成转场

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassSchedulInterController : UIPercentDrivenInteractiveTransition


/// 初始化
/// @param panGesture 传入一个pan手势，通过
- (instancetype)initWithPanGesture:(UIPanGestureRecognizer *)panGesture;
@end

NS_ASSUME_NONNULL_END
