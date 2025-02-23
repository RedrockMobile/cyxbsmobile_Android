//
//  TimeChooseScrollView.h
//  Demo
//
//  Created by 李展 on 2016/12/8.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TimeChooseScrollViewDelegate <NSObject>
- (void)eventWhenTapAtIndex:(NSInteger)index;
@end

@interface TimeChooseScrollView : UIScrollView
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, weak) id<TimeChooseScrollViewDelegate> chooseDelegate;
@property (nonatomic, readonly) NSString *currenSelectedTitle;
//@property (nonatomic, assign) BOOL showWeekScrollView;
- (void)tapAtIndex:(NSInteger)index;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles;
@end
