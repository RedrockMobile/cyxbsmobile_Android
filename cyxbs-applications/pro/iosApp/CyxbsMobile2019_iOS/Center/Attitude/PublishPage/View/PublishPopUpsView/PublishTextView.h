//
//  PublishTextView.h
//  CyxbsMobile2019_iOS
//
//  Created by 宋开开 on 2023/3/17.
//  Copyright © 2023 Redrock. All rights reserved.
//

// 此类为发布界面点击发布标题和发布选项弹出的文本输入框父类
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishTextView : UIView

/// 文本框本框
@property (nonatomic, strong) UITextView *publishTextView;

/// 字数
@property (nonatomic, strong) UILabel *stringsLab;

/// “取消”按钮
@property (nonatomic, strong) UIButton *cancelBtn;

/// “确认”按钮
@property (nonatomic, strong) UIButton *sureBtn;

@end

NS_ASSUME_NONNULL_END
