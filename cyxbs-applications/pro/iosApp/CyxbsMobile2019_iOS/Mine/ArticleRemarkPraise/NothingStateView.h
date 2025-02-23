//
//  NothingStateView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/3/3.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 当没有内容时，用于作背景图片的类
@interface NothingStateView : UIView

/// 唯一的创建方法
/// @param str 显示的文字，如@"暂时还没有动态～"
- (instancetype)initWithTitleStr:(NSString*)str;

@end

NS_ASSUME_NONNULL_END


//用法：
/*
 //1.创建（唯一的创建方法）：
 NothingStateView *view = [[NothingStateView alloc] initWithTitleStr:@"暂时还没有屏蔽的人噢～"];
 //2.addSubview
 [self.view addSubview:_nothingView];
 */
