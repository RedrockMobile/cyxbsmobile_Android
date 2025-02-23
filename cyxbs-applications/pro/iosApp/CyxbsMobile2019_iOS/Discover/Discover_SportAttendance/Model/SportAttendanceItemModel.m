//
//  SportAttendanceItemModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/5.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SportAttendanceItemModel.h"

@implementation SportAttendanceItemModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemAry = NSMutableArray.array;
    }
    return self;
}

- (instancetype)initWithArray:(NSArray <NSDictionary *> *)ary {
    self = [super init];
    if (self) {
        NSMutableArray <SportAttendanceItem *> *ma = NSMutableArray.array;
        for (NSDictionary *dic in ary) {
            SportAttendanceItem *saModel = [[SportAttendanceItem alloc] initWithDictionary:dic];
            [ma addObject:saModel];
        }
        self.itemAry = ma.copy;
    }
    return self;
}

@end
