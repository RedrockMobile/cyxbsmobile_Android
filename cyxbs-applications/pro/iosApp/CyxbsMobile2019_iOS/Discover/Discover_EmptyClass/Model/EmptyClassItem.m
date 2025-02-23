//
//  EmptyClassItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/22.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "EmptyClassItem.h"

@implementation EmptyClassItem

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.floorNum = dict[@"floorNum"];
        self.roomArray = dict[@"roomArray"];
    }
    return self;
}

@end
