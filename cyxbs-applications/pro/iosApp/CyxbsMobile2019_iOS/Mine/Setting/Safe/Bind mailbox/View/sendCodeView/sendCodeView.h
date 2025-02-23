//
//  sendCodeView.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/11/3.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol sendCodeDelegate <NSObject>

- (void)backButtonClicked;
- (void)ClickedSure;
- (void)ClickedContactUS;
- (void)ClickedResend;

@end

@interface sendCodeView : UIView

@property (nonatomic, strong) UILabel *placeholderLab;
@property (nonatomic, strong) UILabel *sendCodeLab;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UILabel *resend;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, weak) id<sendCodeDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
