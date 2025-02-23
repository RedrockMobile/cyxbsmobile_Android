//
//  ClassSchedulInterController.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/24.
//  Copyright © 2020 Redrock. All rights reserved.
//过渡手势管理者，作用：更新转场动画进度、在恰当的时机取消转场或者完成转场

#import "ClassSchedulInterController.h"
#import "WYCClassBookViewController.h"
@interface ClassSchedulInterController()

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, assign) float lastTranslationY;

@end

@implementation ClassSchedulInterController

- (instancetype)initWithPanGesture:(UIPanGestureRecognizer *)panGesture {
    if (self = [super init]) {
        self.panGesture = panGesture;
        [self.panGesture addTarget:self action:@selector(updateAnimation:)];
    }
    return self;
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}

- (void)updateAnimation:(UIPanGestureRecognizer *)sender {
    CGFloat percent = [self gesturePercent:sender];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            break;
            
        case UIGestureRecognizerStateChanged:
            //更新转场动画进度
            [self updateInteractiveTransition:percent / 4];
            break;
            
        case UIGestureRecognizerStateEnded:
            if (percent > 0.1) {
                //完成转场动画
                [self finishInteractiveTransition];
                
            } else {
                //取消转场
                [self cancelInteractiveTransition];
            }
            break;
        
        default:
            //取消转场
            [self cancelInteractiveTransition];
            break;
    }
}

- (CGFloat)gesturePercent:(UIPanGestureRecognizer *)sender {
    //获取手势再横坐标上、纵坐标上拖动的像素
    CGPoint translation = [sender translationInView:self.transitionContext.containerView];
    
    // 如果是下拉
    if ([[self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] isMemberOfClass:[UINavigationController class]]) {
        CGFloat percent = translation.y / 667;
        if (percent > 0) {
            return percent;
        } else {
            return 0;
        }
    } else {
        return fabs(translation.y / 667);
    }
    
}

@end
