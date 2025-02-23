//
//  DLWeeklSelectView.h
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/10.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol WeekSelectDelegate <NSObject>
/// 某个周按钮被点后要调用的代理方法
/// @param stringArray 已经选择的周string
- (void)selectedTimeStringArray:(NSArray*)stringArray;
@end

/// 周选择view的背景，全屏尺寸的view
@interface DLWeeklSelectView : UIView


@property (nonatomic, strong) UIButton *confirmBtn;

/// 某个周按钮被点后调用代理方法，
@property (nonatomic, weak) id<WeekSelectDelegate> delegate;

- (void)setWeekBtnsSelectedWithIndexArray:(NSArray*)indexArray;
@end

NS_ASSUME_NONNULL_END
