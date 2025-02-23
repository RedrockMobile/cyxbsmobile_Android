//
//  QuestionSelectView.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/3/30.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**QuestionSelectView
 * 选择问题的整体View
 * 应选择继承这个类，
 * 并遵循两个代理，
 */

#import <UIKit/UIKit.h>

#import "QuestionButton.h"

NS_ASSUME_NONNULL_BEGIN

@class QuestionSelectView;

#pragma mark - QuestionSelectViewDelegate

@protocol QuestionSelectViewDelegate <NSObject>

@required

/// 单击了哪个button
/// @param view 所在QuestionSelectView
/// @param index button下标
- (void)questionSelectView:(QuestionSelectView *)view selectedButtonAtIndex:(NSUInteger)index;

@optional

/// button间间距
/// @param view button所在QuestionSelectView
- (CGFloat)gapBetweenButtonsAtQuestionSelectView:(QuestionSelectView *)view;

/// 设置btn没被选中的样式
/// @param view 所在QuestionSelectView
/// @param btn btn取消选中了
- (void)questionSelectView:(QuestionSelectView *)view buttonUnselected:(QuestionButton *)btn;


/// 设置btn被选中的样式
/// @param view 所在QuestionSelectView
/// @param btn btn被选中了
- (void)questionSelectView:(QuestionSelectView *)view buttonSelected:(QuestionButton *)btn;

@end

#pragma mark - QuestionSelectViewDataSourse

@protocol QuestionSelectViewDataSource <NSObject>

@required

/// button的个数
/// @param view 所在QuestionSelectView
- (NSUInteger)numberOfButtonsInQuestionSelectView:(QuestionSelectView *)view;

@optional

/// button的样式
/// @param view 所在QuestionSelectView
/// @param index btn所在下标
- (__kindof QuestionButton *)questionSelectView:(QuestionSelectView *)view buttonAtIndex:(NSUInteger)index;

@end

#pragma mark - QuestionSelectView

@interface QuestionSelectView : UIView

/// 代理，用于UI
@property (nonatomic, weak) id <QuestionSelectViewDelegate> delegate;

/// 代理，用于Data
@property (nonatomic, weak) id <QuestionSelectViewDataSource> dataSourse;

@end

NS_ASSUME_NONNULL_END
