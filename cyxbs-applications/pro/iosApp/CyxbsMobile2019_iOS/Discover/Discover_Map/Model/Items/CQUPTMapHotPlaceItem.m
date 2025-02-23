//
//  CQUPTMapHotPlaceItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapHotPlaceItem.h"

@implementation CQUPTMapHotPlaceItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.title = dict[@"title"];
        NSMutableArray *tmpArray = [@[] mutableCopy];
        for (NSString *placeID in dict[@"place_id"]) {
            [tmpArray addObject:[NSString stringWithFormat:@"%@", placeID]];
        }
        self.placeIDArray = tmpArray;
        self.isHot = [dict[@"is_hot"] boolValue];
    }
    return self;
}

@end
