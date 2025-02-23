//
//  EmptyClassContentView.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/19.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EmptyContentViewDelegate <NSObject>

- (void)backButtonClicked;
- (void)weekButtonChoosed:(UIButton *)sender;
- (void)weekdayButtonChoosed:(UIButton *)sender;
- (void)classButtonChoosed:(UIButton *)sender;
- (void)buildingButtonChoosed:(UIButton *)sender;

@end


@interface EmptyClassContentView : UIView

/// 选择周数的滚动条
@property (nonatomic, weak) UIScrollView *weekScrollView;

/// 选择周数的按钮数组
@property (nonatomic, copy) NSArray<UIButton *> *weekButtonArray;

/// 选择星期的按钮数组
@property (nonatomic, copy) NSArray<UIButton *> *weekDayButtonArray;

/// 选择时段的按钮数组
@property (nonatomic, copy) NSArray<UIButton *> *classButtonArray;

/// 选择教学楼的按钮数组
@property (nonatomic, copy) NSArray<UIButton *> *buildingButtonArray;

/// 查询结果的tableView
@property (nonatomic, weak) UITableView *resultTable;


@property (nonatomic, weak) id<EmptyContentViewDelegate, UITableViewDataSource> delegate;

@end

NS_ASSUME_NONNULL_END
