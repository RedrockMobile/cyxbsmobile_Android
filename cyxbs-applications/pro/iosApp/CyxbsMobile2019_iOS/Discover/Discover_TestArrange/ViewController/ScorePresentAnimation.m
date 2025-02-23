//
//  ScorePresentAnimation.m
//  translationTest
//
//  Created by 千千 on 2020/9/6.
//  Copyright © 2020 千千. All rights reserved.
//

#import "ScorePresentAnimation.h"

@implementation ScorePresentAnimation

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = nil;
    UIView *fromView = nil;
    UIView *transView = nil;
    
    if([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else {
        fromView = fromViewController.view;//当获取不到时使用默认的View
        toView = toViewController.view;
    }
    //动画执行的时候transView = toView;
    if(_isPresent) {
        transView = toView;
        [transitionContext.containerView addSubview:toView];
    }else {
        transView = fromView;
        [transitionContext.containerView insertSubview:toView belowSubview:fromView];
    }
    //获取当前屏幕宽高
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    //将transView的frame设置为与屏幕一样的宽高，x的位置取决于当前屏幕的宽度
    transView.frame = CGRectMake(/*_isPresent ?width :*/0,_isPresent ? height: 130, width, height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        transView.frame = CGRectMake(/*self->_isPresent ? 0 : */0,self->_isPresent ? 130: height, width, height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end
