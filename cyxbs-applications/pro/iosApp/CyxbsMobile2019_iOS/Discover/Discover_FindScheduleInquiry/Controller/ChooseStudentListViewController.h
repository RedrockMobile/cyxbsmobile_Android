//
//  ChooseStudentListViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/29.
//  Copyright © 2020 Redrock. All rights reserved.
//点击键盘上的搜索按钮后跳转的那个选择人的界面就是这个类

#import <UIKit/UIKit.h>
#import "ClassmatesList.h"
//#import "SchedulForOneWeekController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChooseStudentListViewController : UIViewController

//传入ClassmatesList*型的数据对这个类进行初始化
- (instancetype)initWithClassmatesList:(ClassmatesList *)classmatesList;

//必须设置peopleType属性，以区别是查老师还是查学生
@property (nonatomic,assign)PeopleType peopleType;
@end

NS_ASSUME_NONNULL_END
