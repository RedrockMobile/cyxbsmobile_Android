//
//  ResetPwdView.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/27.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ResetpwdViewDelegate <NSObject>

- (void)backButtonClicked;
- (void)ClickedNext;

@end


@interface ResetPwdView : UIView

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UITextField *passwordField1;
@property (nonatomic, strong) UITextField *passwordField2;
@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, strong) UILabel *placeholder1Error;
@property (nonatomic, strong) UILabel *placeholder1Empty;
@property (nonatomic, strong) UILabel *placeholder2Error;
@property (nonatomic, strong) UILabel *placeholder2Empty;

@property (nonatomic, weak) id<ResetpwdViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
