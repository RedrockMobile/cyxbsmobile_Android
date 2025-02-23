//
//  CQUPTMapStarPlaceItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/12.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapStarPlaceItem.h"
#import "CQUPTMapPlaceItem.h"
#import "CQUPTMapDataItem.h"

@implementation CQUPTMapStarPlaceItem

MJExtensionCodingImplementation

+ (NSString *)archivePath {
    return [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), @"CQUPTMapStarPlaceItem.data"];
}

- (void)archiveItem {
    NSError *error = nil;
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:self requiringSecureCoding:YES error:&error];
    if (error) {
        // 处理错误情况
        NSLog(@"CQUPTMapStarPlaceItem Error: %@", error);
    } else {
        [archiveData writeToFile:[CQUPTMapStarPlaceItem archivePath] atomically:YES];
    }
}

- (instancetype)initWithDice:(NSDictionary *)dict {
    if (self = [super init]) {
        self.starPlaceArray = [@[] mutableCopy];
        
        for (int i = 0; i < ((NSArray *)(dict[@"data"][@"place_id"])).count; i++) {
            [self.starPlaceArray addObject:[dict[@"data"][@"place_id"][i] stringValue]];
        }
    }
    return self;
}

+ (NSArray<CQUPTMapPlaceItem *> *)starPlaceDetail {
    NSError *error = nil;
    CQUPTMapStarPlaceItem *starItem = [NSKeyedUnarchiver unarchivedObjectOfClass:[CQUPTMapStarPlaceItem class] fromData:[NSData dataWithContentsOfFile:[CQUPTMapStarPlaceItem archivePath]] error:&error];
    if (error) {
        // 处理错误情况
        NSLog(@"CQUPTMapStarPlaceItem Error: %@", error);
    }

    CQUPTMapDataItem *mapData = [NSKeyedUnarchiver unarchivedObjectOfClass:[CQUPTMapDataItem class] fromData:[NSData dataWithContentsOfFile:[CQUPTMapDataItem archivePath]] error:&error];
    if (error) {
        // 处理错误情况
        NSLog(@"CQUPTMapStarPlaceItem Error: %@", error);
    }
    
    NSMutableArray *tmpArray = [@[] mutableCopy];
    for (NSString *placeID in starItem.starPlaceArray) {
        for (CQUPTMapPlaceItem *place in mapData.placeList) {
            if ([placeID isEqualToString:place.placeId]) {
                [tmpArray addObject:place];
            }
        }
    }
    
    return [tmpArray copy];
}

@end
