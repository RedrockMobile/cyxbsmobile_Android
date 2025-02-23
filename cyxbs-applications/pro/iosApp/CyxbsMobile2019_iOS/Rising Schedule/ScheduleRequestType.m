//
//  ScheduleRequestType.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/4.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleRequestType.h"

#pragma mark - ClassScheduleRequestType

ScheduleModelRequestType ScheduleModelRequestStudent = @"student";

ScheduleModelRequestType ScheduleModelRequestCustom = @"custom";

ScheduleModelRequestType ScheduleModelRequestTeacher = @"teacher";

NSString *API_forScheduleModelRequestType(ScheduleModelRequestType type) {
    NSCParameterAssert(type);
    
    static NSDictionary *APIDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        APIDictionary = @{
            ScheduleModelRequestStudent : RisingSchedule_POST_stuSchedule_API,
            ScheduleModelRequestTeacher : RisingSchedule_POST_teaSchedule_API,
            ScheduleModelRequestCustom : RisingSchedule_POST_perTransaction_API
        };
    });
    
    NSCParameterAssert(APIDictionary[type]);
    
    return APIDictionary[type];
}

NSString *KeyInParameterForScheduleModelRequestType(ScheduleModelRequestType type) {
    NSCParameterAssert(type);
    
    static NSDictionary *KeyDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KeyDictionary = @{
            ScheduleModelRequestStudent : @"stu_num",
            ScheduleModelRequestTeacher : @"tea",
            ScheduleModelRequestCustom : @"stu_num"
        };
    });
    
    NSCParameterAssert(KeyDictionary[type]);
    
    return KeyDictionary[type];
}
