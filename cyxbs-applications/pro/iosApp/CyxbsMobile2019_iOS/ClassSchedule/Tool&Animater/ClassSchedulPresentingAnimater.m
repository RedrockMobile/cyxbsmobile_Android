//
//  ClassSchedulPresentingAnimater.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/23.
//  Copyright © 2020 Redrock. All rights reserved.
//转场动画管理者，实现具体的转场动画代码

#import "ClassSchedulPresentingAnimater.h"
#import "ClassTabBarController.h"
#import "WYCClassBookViewController.h"



@implementation ClassSchedulPresentingAnimater

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    if([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isMemberOfClass:[WYCClassBookViewController class]]){
        [self transitionToWYCClassBookViewController:transitionContext];
    }else{
        [self transitionToClassTabBarController:transitionContext];
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}


//弹出课表
- (void)transitionToWYCClassBookViewController:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    WYCClassBookViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
//    ClassTabBarController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    to.topBarView.alpha = 0;
    to.fakeBar.alpha = 1;

//    UIEdgeInsets insets = [[[UIApplication sharedApplication] windows] firstObject].safeAreaInsets;
    
    double tabbarHeight = ((UITabBarController*)to.presentingViewController).tabBar.bounds.size.height;
    
    double h = 58 + tabbarHeight;
    
    [to.view setFrame:CGRectMake(0, MAIN_SCREEN_H - h, MAIN_SCREEN_W, 58)];
    
    to.view.clipsToBounds = YES;
    [transitionContext.containerView addSubview:to.view];
            
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
        to.topBarView.alpha = 1;
        to.fakeBar.alpha = 0;
        [to.view setFrame:CGRectMake(0, STATUSBARHEIGHT >30 ? STATUSBARHEIGHT : 30, MAIN_SCREEN_W, MAIN_SCREEN_H - (STATUSBARHEIGHT >30 ? STATUSBARHEIGHT : 30))];
    }completion:^(BOOL finished) {
        BOOL wasCancel = [transitionContext transitionWasCancelled];
        if(wasCancel){
            [to.view removeFromSuperview];
        }
        [transitionContext completeTransition:!wasCancel];
    }];
}

//收回课表
- (void)transitionToClassTabBarController:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
//    ClassTabBarController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    WYCClassBookViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    from.topBarView.alpha = 1;
    from.fakeBar.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
        from.topBarView.alpha = 0;
        from.fakeBar.alpha = 1;
        
        double tabbarHeight = ((UITabBarController*)from.presentingViewController).tabBar.bounds.size.height;
        
        double h = 58 + tabbarHeight;
        
        [from.view setFrame:CGRectMake(0, MAIN_SCREEN_H - h, MAIN_SCREEN_W, 58)];
        
    }completion:^(BOOL finished) {
        BOOL wasCancel = [transitionContext transitionWasCancelled];
        if(!wasCancel){
            [from.view removeFromSuperview];
        }
        [transitionContext completeTransition:!wasCancel];
    }];
    
}
@end
