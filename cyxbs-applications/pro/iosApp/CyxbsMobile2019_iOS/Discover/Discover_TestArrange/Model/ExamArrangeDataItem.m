//
//  ExamArrangeDataItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ExamArrangeDataItem.h"

@implementation ExamArrangeDataItem
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if(self = [super init]) {
        self.student = dic[@"student"];
        self.course = dic[@"course"];
        self.classroom = dic[@"classroom"];
        self.date = dic[@"date"];
        self.seat = dic[@"seat"];
        self.week = dic[@"week"];
        self.weekday = dic[@"weekday"];
        self.begin_time = dic[@"begin_time"];
        self.end_time = dic[@"end_time"];
        self.status = dic[@"status"];
        self.type = dic[@"type"];
    }
    return self;
}
@end
