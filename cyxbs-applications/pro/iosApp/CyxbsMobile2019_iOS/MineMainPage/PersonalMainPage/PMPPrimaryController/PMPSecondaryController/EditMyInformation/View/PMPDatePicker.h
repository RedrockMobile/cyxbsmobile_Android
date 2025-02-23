//
//  PMPDatePicker.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/10/12.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PMPDatePickerDelegate <NSObject>

- (void)datePickerSureButtonClicked:(id)sender;

@end

@interface PMPDatePicker : UIView

@property (nonatomic, strong) UIDatePicker * datePicker;

/// 确定按钮
@property (nonatomic, strong) UIButton * sureButton;

@property (nonatomic, weak) id <PMPDatePickerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
