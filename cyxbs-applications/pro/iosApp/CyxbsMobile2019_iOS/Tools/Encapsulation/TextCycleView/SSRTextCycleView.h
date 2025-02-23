//
//  SSRTextCycleView.h
//  SSRSwipe
//
//  Created by SSR on 2022/4/11.
//

/// 用  initWithFrame:

#import <UIKit/UIKit.h>

#import "SSRTextCycleCell.h"

NS_ASSUME_NONNULL_BEGIN

@class SSRTextCycleView;

#pragma mark - TextCycleViewDelegate

@protocol TextCycleViewDelegate <NSObject>

@required

/// 选中了哪一个（textAry包装在至少有1个的情况才会掉用）
/// @param view 文字轮播器
/// @param index 单击了第index的title
- (void)textCycleView:(SSRTextCycleView *)view didSelectedAtIndex:(NSInteger)index;

@optional

/// 自定义Cell样式，最好为分类（而不是继承）
/// @param view 文字轮播器
/// @param index 第index个cell
- (SSRTextCycleCell *)textCycleView:(SSRTextCycleView *)view cellForIndex:(NSInteger)index;

@end

#pragma mark - TextCycleView

/// 文字轮播器（竖）
@interface SSRTextCycleView : UITableView <
    UITableViewDelegate,
    UITableViewDataSource
>

/// 如果为 nil 或 count == 0 则空，如果count == 1则不循环，其他情况会循环
@property (nonatomic, copy) NSArray <NSString *> *textAry;

/// 循环时间，有默认值2秒
@property (nonatomic) NSTimeInterval autoTimeInterval;

/// 如果有需求，请在网络请求后设置代理，这样会更好（当然也可以固定的文字）
@property (nonatomic, weak) id <TextCycleViewDelegate> textCycleView_delegate;

// MARK: Method

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style NS_UNAVAILABLE;

/// 手动开启循环，一般不需要做
- (void)startTimer;

/// 手动结束循环，性能优化时可考虑做
- (void)endTimer;

@end

NS_ASSUME_NONNULL_END
