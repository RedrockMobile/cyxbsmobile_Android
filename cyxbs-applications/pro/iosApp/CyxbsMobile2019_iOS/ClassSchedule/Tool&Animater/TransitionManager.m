//
//  TransitionManager.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/24.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "TransitionManager.h"
#import "ClassSchedulPresentingAnimater.h"
#import "ClassSchedulInterController.h"

@implementation TransitionManager
//返回一个遵守<UIViewControllerAnimatedTransitioning>的转场动画管理者，present时调用
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return [[ClassSchedulPresentingAnimater alloc] init];
}

//返回一个遵守<UIViewControllerAnimatedTransitioning>的转场动画管理者，Dismiss时调用
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[ClassSchedulPresentingAnimater alloc] init];
}

//返回一个遵守<UIViewControllerInteractiveTransitioning>的过渡手势管理者，Dismiss时调用
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    if(self.PGRToInitTransition==nil)return nil;
    return [[ClassSchedulInterController alloc] initWithPanGesture:self.PGRToInitTransition];
}

//返回一个遵守<UIViewControllerInteractiveTransitioning>的过渡手势管理者，present时调用
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    if(self.PGRToInitTransition==nil)return nil;
    return [[ClassSchedulInterController alloc] initWithPanGesture:self.PGRToInitTransition];
}
@end
