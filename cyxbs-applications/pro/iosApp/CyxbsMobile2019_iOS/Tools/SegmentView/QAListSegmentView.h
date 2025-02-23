//
//  QASegmentView.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2019/3/10.
//  Copyright © 2019年 Shi Yucheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QASegmentViewDelegate

@required
/**
 点击SegmentView触发的方法
 
 @param index 标示点击的第几个SegmentView
 */
- (void)scrollEventWithIndex:(NSInteger) index;

@end


@interface QAListSegmentView : UIView <QASegmentViewDelegate>

@property (nonatomic, weak) id<QASegmentViewDelegate> eventDelegate;

/**
 
 @param frame SegmentView的Frame大小
 @param controllers SegmentView容纳的视图控制器，以数组形式提供
 
 @return 初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray<UIViewController *> *)controllers;

@end




