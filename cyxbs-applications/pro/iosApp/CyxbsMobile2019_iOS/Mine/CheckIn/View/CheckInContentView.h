//
//  CheckInContentVIew.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/11/26.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckInBar.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CheckInContentViewDelegate <NSObject>

- (void)backButtonClicked;
- (void)CheckInButtonClicked;

@end

@interface CheckInContentView : UIView

/// 代理是CheckInViewController
@property (nonatomic, weak) id<CheckInContentViewDelegate> delegate;

// views
@property (nonatomic, weak) UILabel *weekLabel;

@property (nonatomic, weak) CheckInBar *bar;
@property (nonatomic, weak) UIView *checkInView;
@property (nonatomic, weak) UIView *storeView;



- (void)CheckInSucceded;

@end

NS_ASSUME_NONNULL_END
