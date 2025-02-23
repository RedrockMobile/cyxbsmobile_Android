//
//  LessonView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/17.
//  Copyright © 2020 Redrock. All rights reserved.
//某一节课的view

#import <UIKit/UIKit.h>
//一节小课的宽度
#define LESSON_W (MAIN_SCREEN_W*0.1253)
//一节小课的高度
#define LESSON_H (LESSON_W*1.1702)
//课与课间的水平距离
#define DISTANCE_W (MAIN_SCREEN_W*0.0053)
//课与课间的垂直距离
#define DISTANCE_H (DISTANCE_W*1.5)

#import "NoteDataModel.h"
NS_ASSUME_NONNULL_BEGIN

//显示课程信息、备忘信息的协议
@protocol LessonViewDelegate <NSObject>
- (void)showDetail;

/// 全部课的课程信息字典数组
@property (nonatomic,strong)NSArray <NSDictionary*>*courseDataDictArray;
/// 全部备忘的备忘信息模型数组
@property (nonatomic,strong)NSArray <NoteDataModel*>*noteDataModelArray;
@end

@protocol LessonViewAddNoteDelegate <NSObject>
/// 通过导入的空课信息添加备忘
/// @param emptyLessonData dict = @{
///    @"hash_day":0,
///    @"hash_lesson":2,
///    @"period":2,
///    @"week":第week周的空课，week代表整学期
/// };
- (void)addNoteWithEmptyLessonData:(NSDictionary*)emptyLessonData;
@end


/// 空课和有课处的view都是这个这个类
@interface LessonView : UIView

/** 显示在课表上的课的信息字典，也就是courseDataDictArray[0]，空课的结构：
 
 */
//@property(nonatomic,strong)NSDictionary *courseDataDict;

/// 全部课的信息
@property(nonatomic,strong)NSArray <NSDictionary*>*courseDataDictArray;

/// 全部的备忘信息
@property (nonatomic,strong)NSMutableArray <NoteDataModel*>*noteDataModelArray;

/// 是不是一节空课
@property(nonatomic,assign)BOOL isEmptyLesson;

/// 显示课程信息、备忘信息的代理
@property(nonatomic,weak)id<LessonViewDelegate>delegate;

/// 添加备忘的代理
@property(nonatomic,weak)id<LessonViewAddNoteDelegate>addNoteDelegate;


/**结构
 dict = @{
 @"hash_day":0,
 @"hash_lesson":2,
 @"period":2,
 @"week":第week周的空课，week==0代表整学期
};*/
/// 空课信息
@property(nonatomic,strong)NSDictionary *emptyClassDate;

/// 是否已经添加备忘
@property(nonatomic,readonly)BOOL isNoted;

///self初始化的那个地方会判断上一节课的period是不是大于2，如果是那么self.noteShowerDelegate就会被设置成上一节课
///然后在LessonViewForAWeek的addNoteLabelWithNoteDataModel里面有一个判断：如果noteShowerDelegate非空，
///则由noteShowerDelegate来显示备忘
@property(nonatomic,weak)LessonView *noteShowerDelegate;

/// 课程时长
@property(nonatomic,assign)int period;

/// 课表类型，共右三种：自己课表、没课约课表、查别人课表
@property(nonatomic,assign)ScheduleType schType;

/// 更新显示的课表数据，调用前需确保已经对self.courseDataDictArray进行更新、且已经调用了setUpUI
- (void)setUpData;

@end

NS_ASSUME_NONNULL_END
//这个类的用法：

//1.只能用init初始化，initWithFrame也不能用
//  LessonView *lessonView = [[LessonView alloc] init];

//2.是否是空课
//  lessonView.isEmptyLesson = NO;


//3.设置信息字典，如果是空课就是下面这样的字典
//NSArray *dictArray = @[@{
//        @"hash_day":[NSNumber numberWithInt:i],
//        @"hash_lesson":[NSNumber numberWithInt:j],
//        @"period":[NSNumber numberWithInt:2],
//        @"week":[NSString stringWithFormat:@"%d",self.week],
//    }];
//}

//4.设置显示详情的代理和加备忘的代理
//lessonView.delegate = self;
//lessonView.addNoteDelegate = self;

//5.设置courseDataDictArray
//lessonView.courseDataDictArray = lessonDateArray;

//6.更新内部数据
//[lessonView setUpData];

//7.加入父控件
//[self.view addSubview:lessonView];







