//
//  PresentAnimationTest.h
//  translationTest
//
//  Created by 千千 on 2020/9/6.
//  Copyright © 2020 千千. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ScorePresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPresent;

@end

NS_ASSUME_NONNULL_END
