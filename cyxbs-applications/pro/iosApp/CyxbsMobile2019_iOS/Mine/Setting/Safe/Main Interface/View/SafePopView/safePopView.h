//
//  safePopView.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol safePopViewDelegate <NSObject>

- (void) dismissAlertView;
- (void) setQuestion;
- (void) setEmail;

@end

@interface safePopView : UIView

@property (nonatomic, strong) UIView *AlertView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, weak) id<safePopViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
