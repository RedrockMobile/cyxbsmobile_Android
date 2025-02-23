//
//  UIScrollView+Empty.h
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/26.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYEmptyView;

@interface UIScrollView (Empty)

/**
   空页面占位图控件
 */
@property (nonatomic, strong) LYEmptyView *ly_emptyView;

///////////////////////
///////////////////////
//使用下面的四个方法请将EmptyView的autoShowEmptyView值置为NO，关闭自动显隐，以保证不受自动显隐的影响
///////////////////////
///////////////////////

/**
   一般用于开始请求网络时调用，ly_startLoading调用时会暂时隐藏emptyView
   当调用ly_endLoading方法时，ly_endLoading方法内部会根据当前的tableView/collectionView的
   DataSource来自动判断是否显示emptyView
 */
- (void)ly_startLoading;

/**
   在想要刷新emptyView状态时调用
   注意:ly_endLoading 的调用时机，有刷新UI的地方一定要等到刷新UI的方法之后调用，
   因为只有刷新了UI，view的DataSource才会更新，故调用此方法才能正确判断是否有内容。
 */
- (void)ly_endLoading;


//调用下面两个手动显隐的方法，不受DataSource的影响，单独设置显示与隐藏（前提是关闭autoShowEmptyView）

/**
 手动调用显示emptyView
 */
- (void)ly_showEmptyView;

/**
 手动调用隐藏emptyView
 */
- (void)ly_hideEmptyView;

/**
 展示固定无数据页面
 */
- (void)showNoDataStatusWithOffset:(CGFloat)offset;
/**
 展示固定无数据页面,带不同回复的
 */
- (void)showNoDataStatusWithString:(NSString *)str  withOfffset:(CGFloat)offset;
/**
 展示固定无数据页面,带不同回复的
 */
- (void)showNoDataStatusWithString:(NSString *)str imageName:(NSString *)imageName  withOfffset:(CGFloat)offset;

- (void)showNoDataStatusWithDetailString:(NSString *)str detail:(NSString*)detailStr imageName:(NSString *)imageName  withOfffset:(CGFloat)offset;
/**
 隐藏固定无数据页面
 */
- (void)hideNoDataStatus;

/**
 展示有按钮状态页面
 */
- (void)showEmptyStatusWithImageStr:(NSString *)imageStr title:(NSString *)title btnTitle:(NSString *)btnTitle Action:(void((^)(void)))action;

@end
