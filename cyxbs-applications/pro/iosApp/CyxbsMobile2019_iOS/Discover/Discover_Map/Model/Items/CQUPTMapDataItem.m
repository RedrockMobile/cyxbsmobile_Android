//
//  CQUPTMapDataItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapDataItem.h"
#import "CQUPTMapPlaceItem.h"

@implementation CQUPTMapDataItem

MJExtensionCodingImplementation

+ (NSString *)archivePath {
    return [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), @"CQUPTMapDataItem.data"];
}

- (void)archiveItem {
    NSError *error = nil;
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:self requiringSecureCoding:YES error:&error];
    if (error) {
        // 处理错误情况
        NSLog(@"Archive Error: %@", error);
    } else {
        [archiveData writeToFile:[CQUPTMapDataItem archivePath] atomically:YES];
    }
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.hotWord = dict[@"data"][@"hot_word"];
        
        CGFloat mapWidth = [dict[@"data"][@"map_width"] floatValue];
        CGFloat mapHeight = [dict[@"data"][@"map_height"] floatValue];
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSDictionary *placeDict in dict[@"data"][@"place_list"]) {
            CQUPTMapPlaceItem *placeItem = [[CQUPTMapPlaceItem alloc] initWithDict:placeDict mapWidth:mapWidth mapHeight:mapHeight];
            [tmpArray addObject:placeItem];
        }
        self.placeList = tmpArray;
        
        self.mapURL = dict[@"data"][@"map_url"];
        self.mapColor = dict[@"data"][@"map_background_color"];
        self.mapWidth = [dict[@"data"][@"map_width"] floatValue];
        self.mapHeight = [dict[@"data"][@"map_height"] floatValue];
        self.mapVersion = [dict[@"data"][@"picture_version"] stringValue];
    }
    return self;
}

@end
