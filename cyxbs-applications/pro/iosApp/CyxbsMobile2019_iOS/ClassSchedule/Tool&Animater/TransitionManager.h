//
//  TransitionManager.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/24.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransitionManager : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic,strong,nullable)UIPanGestureRecognizer *PGRToInitTransition;
@end

NS_ASSUME_NONNULL_END
