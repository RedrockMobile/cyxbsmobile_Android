//
//  CyxbsMobileEnum.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/3/20.
//  Copyright © 2021 Redrock. All rights reserved.
//这里面放一些枚举和协议

#ifndef CyxbsMobileEnum_h
#define CyxbsMobileEnum_h

typedef NS_ENUM(NSInteger, PeopleType) {
    /**代表传入的是学生相关*/
    PeopleTypeStudent,
    /**代表传入的是老师相关*/
    PeopleTypeTeacher
};

////data[i][j]代表（星期i+1）的（第j+1节课）是否有课，有课则为1，无课则为0
//typedef struct weekData{
//    int data[7][12];
//} weekData;

typedef NS_ENUM(NSInteger, ScheduleType) {
    //用户自己的课表
    ScheduleTypePersonal,
    //同学课表
    ScheduleTypeClassmate,
    //老师课表
    ScheduleTypeTeacher,
    //没课约的课表
    ScheduleTypeWeDate,
};


//更新显示下节课内容的tabBar要用的协议
@protocol updateSchedulTabBarViewProtocol <NSObject>
//paramDict的3个key：
//classroomLabel：教室地点
//classTimeLabel：上课时间
//classLabel：课程名称
- (void)updateSchedulTabBarViewWithDic:(NSDictionary*)paramDict;
@end


#endif /* CyxbsMobileEnum_h */
