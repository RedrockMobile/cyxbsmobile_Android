//
//  DLWeekButton.h
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/10.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 选择备忘周时的周按钮
@interface DLWeekButton : UIButton

/// 重写了set方法，自动改背景颜色
@property (nonatomic, assign) BOOL isChangeColor;
@end

NS_ASSUME_NONNULL_END
