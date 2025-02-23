//
//  LessonViewForAWeek.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/18.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LessonViewForAWeek : UIView
- (instancetype)initWithDataArray:(NSArray*)dataArray;
@property(nonatomic,strong)NSArray *weekDataArray;

/// 存放所有课控件的数组，lessonViewsArray[i][j]代表(星期i+1)的(第j+1节大课)
@property(nonatomic,strong)NSMutableArray *lessonViewsArray;

@property(nonatomic,assign)ScheduleType schType;
/// 代表是第week周的课，0就是整学期
@property(nonatomic,assign)int week;

/// 带有备忘的课的数组
@property(nonatomic,strong)NSMutableArray *notedLessonViewArray;

- (void)deleteNoteWithNoteDataModel:(NoteDataModel*)model;

- (void)addNoteLabelWithNoteDataModel:(NoteDataModel*)model;

- (void)eidtNoteLabelWithNoteDataModelDict:(NSDictionary*)modelDict;
//调用前确保self.week、self.schType已赋值
- (void)setUpUI;
@end

NS_ASSUME_NONNULL_END

//    LessonViewForAWeek *lessonViewForAWeek = [[LessonViewForAWeek alloc] init];
//
//    lessonViewForAWeek.weekDataArray = self.model.orderlySchedulArray[dateNum];
//
//    lessonViewForAWeek.week = dateNum;
//
//    lessonViewForAWeek.schType = self.schedulType;
//    
//    [lessonViewForAWeek setUpUI];
//
//    lessonViewForAWeek.frame = CGRectMake(MONTH_ITEM_W+DAYBARVIEW_DISTANCE,0, lessonViewForAWeek.frame.size.width, lessonViewForAWeek.frame.size.height);
