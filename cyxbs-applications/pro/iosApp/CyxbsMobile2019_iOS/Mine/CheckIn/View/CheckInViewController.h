//
//  CheckInViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/11/26.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckInContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckInViewController : UIViewController

@property (nonatomic, strong) UIPanGestureRecognizer *presentPanGesture;

@property (nonatomic, weak) CheckInContentView *contentView;

@end

NS_ASSUME_NONNULL_END
