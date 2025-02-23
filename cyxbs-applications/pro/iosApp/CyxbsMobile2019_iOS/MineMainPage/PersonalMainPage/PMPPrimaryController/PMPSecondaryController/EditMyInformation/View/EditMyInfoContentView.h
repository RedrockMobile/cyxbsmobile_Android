//
//  EditMyInfoContentView.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/11/14.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineInformationLabel.h"
#import "PMPPickerView.h"
#import "PMPDatePicker.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EditMyInfoContentViewDelegate <NSObject>

- (void)headerImageTapped:(UIImageView *)sender;
- (void)showUserInformationIntroduction:(UIButton *)sender;

@end

@interface EditMyInfoContentView : UIView

@property (nonatomic, weak) id<EditMyInfoContentViewDelegate> delegate;


@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, weak) UIImageView *headerImageView;

/// 显示真实姓名的Label
@property (nonatomic, weak) MineInformationLabel *realNameDetailLabel;

/// 显示学号的Label
@property (nonatomic, weak) MineInformationLabel *stuNumDetailLabel;

/// 显示性别的Label
@property (nonatomic, weak) MineInformationLabel *genderDetailLabel;

/// 显示学院的Label
@property (nonatomic, weak) MineInformationLabel *collegeDetailLabel;

@end

NS_ASSUME_NONNULL_END
