//
//  ChoosePeopleListView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/7/30.
//  Copyright © 2020 Redrock. All rights reserved.
//这个类是点击键盘上的搜索按钮后的底部弹窗

#import <UIKit/UIKit.h>
#import "PeopleListTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChoosePeopleListView : UIView

//要求infoDictArray的结构为：
//@[
//  @{@"name:@"xxx",@"stuNum":@"201921134"},
//  @{@"name:@"x",@"stuNum":@"23900423134"}
//];
- (instancetype)initWithInfoDictArray:(NSArray*)infoDictArray;

//调用这个方法会让这个类弹出来
- (void)showPeopleListView;
@property (nonatomic, weak)id<PeopleListTableViewCellDelegateAdd>delegate;
@end

NS_ASSUME_NONNULL_END

//1.
//infoDictArray = @[
//  @{@"name:@"xxx",@"stuNum":@"201921134"},
//  @{@"name:@"x",@"stuNum":@"23900423134"}
//];

//2.
//ChoosePeopleListView *listView = [[ChoosePeopleListView alloc] initWithInfoDictArray:infoDictArray];

//3.
//listView.frame = [UIScreen mainScreen].bounds;

//4.
//[self.view addSubview:listView];

//5.
//listView.delegate = self;

//6.
//[listView showPeopleListView];
