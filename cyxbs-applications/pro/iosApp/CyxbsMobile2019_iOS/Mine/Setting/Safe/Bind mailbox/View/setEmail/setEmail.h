//
//  setEmail.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/29.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol setEmailDelegate <NSObject>

- (void)backButtonClicked;
- (void)ClickedNext;
- (void)ClickedContactUS;

@end

@interface setEmail : UIView
@property (nonatomic, strong) UILabel *placeholderLab;
@property (nonatomic, strong) UILabel *sendEmailLab;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, weak) id<setEmailDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
