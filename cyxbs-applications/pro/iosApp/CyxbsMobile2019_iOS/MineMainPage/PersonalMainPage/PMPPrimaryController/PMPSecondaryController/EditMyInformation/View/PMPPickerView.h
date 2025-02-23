//
//  PMPPickerView.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/10/12.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PMPPickerViewDelegate <NSObject>

- (void)sureButtonClicked:(id)sender;

@end

/// 沾满屏幕的一个选择器
@interface PMPPickerView : UIView

@property (nonatomic, strong) UIPickerView * pickerView;

///确定按钮
@property (nonatomic, strong) UIButton * sureButton;

@property (nonatomic, weak) id <PMPPickerViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
