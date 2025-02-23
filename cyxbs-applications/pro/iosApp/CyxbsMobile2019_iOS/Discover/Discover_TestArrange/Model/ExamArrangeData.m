//
//  ExamArrangeData.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ExamArrangeData.h"

@implementation ExamArrangeData
- (instancetype)initWithDic:(NSDictionary *)dic {
    if(self = [super init]) {
        self.nowWeek = dic[@"noewWeek"];
        self.version = dic[@"version"];
        self.status = dic[@"status"];
        NSMutableArray<ExamArrangeDataItem*> *data = [NSMutableArray array];
        for (NSDictionary *dictionary in dic[@"data"]) {
            ExamArrangeDataItem *item = [[ExamArrangeDataItem alloc]initWithDictionary:dictionary];
            [data addObject:item];
        }
        self.data = data;
    }
    return self;
}
@end
