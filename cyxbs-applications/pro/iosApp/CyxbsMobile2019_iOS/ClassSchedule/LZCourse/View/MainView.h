//
//  MainView.h
//  Demo
//
//  Created by 李展 on 2016/10/26.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LessonButton;
@class LessonNumLabel;
@interface MainView : UIView
@property (nonatomic, strong) NSMutableArray<LessonButton *> *lessonBtns;
@property (nonatomic, strong) UIScrollView *scrollView;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)loadDayLbTimeWithWeek:(NSInteger)week nowWeek:(NSInteger)nowWeek;
@end
