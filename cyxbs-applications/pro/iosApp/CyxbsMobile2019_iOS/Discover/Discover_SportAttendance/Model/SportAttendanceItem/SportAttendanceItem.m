//
//  SportAttendanceItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/5.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SportAttendanceItem.h"

@implementation SportAttendanceItem

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.date = [dic valueForKey:@"date"];
        self.time = [dic valueForKey:@"time"];
        self.spot = [dic valueForKey:@"spot"];
        self.type = [dic valueForKey:@"type"];
        self.is_award = [dic[@"is_award"] boolValue];
        self.valid = [dic[@"valid"] boolValue];
    }
    return self;
}

@end
