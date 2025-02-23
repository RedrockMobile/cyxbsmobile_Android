//
//  CQUPTMapPlaceItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapPlaceItem.h"
#import "CQUPTMapStarPlaceItem.h"

@implementation CQUPTMapPlaceItem

MJExtensionCodingImplementation

- (instancetype)initWithDict:(NSDictionary *)dict mapWidth:(CGFloat)width mapHeight:(CGFloat)height {
    if (self = [super init]) {
        self.placeName = dict[@"place_name"];
        self.placeId = [dict[@"place_id"] stringValue];
        self.centerX = [dict[@"place_center_x"] floatValue] / width;
        self.centerY = [dict[@"place_center_y"] floatValue] / height;
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSDictionary *rectDict in dict[@"building_list"]) {
            CQUPTMapPlaceRect *rect = [[CQUPTMapPlaceRect alloc] init];
            rect.totalWidth = width;
            rect.totalHeight = height;
            rect.percentageLeft = [rectDict[@"building_left"] floatValue] / width;
            rect.percentageRight = [rectDict[@"building_right"] floatValue] / width;
            rect.percentageTop = [rectDict[@"building_top"] floatValue] / height;
            rect.percentageBottom = [rectDict[@"building_bottom"] floatValue] / height;
            [tmpArray addObject:rect];
        }
        self.buildingList = tmpArray;
        
        CQUPTMapPlaceRect *rect = [[CQUPTMapPlaceRect alloc] init];
        rect.totalWidth = width;
        rect.totalHeight = height;
        rect.percentageLeft = [dict[@"tag_left"] floatValue] / width;
        rect.percentageRight = [dict[@"tag_right"] floatValue] / width;
        rect.percentageTop = [dict[@"tag_top"] floatValue] / height;
        rect.percentageBottom = [dict[@"tag_bottom"] floatValue] / height;
        self.tagRect = rect;
    }
    return self;
}

- (BOOL)isCollected {
    NSArray *starArray = [CQUPTMapStarPlaceItem starPlaceDetail];
    for (CQUPTMapPlaceItem *place in starArray) {
        if ([place.placeId isEqualToString:self.placeId]) {
            return YES;
        }
    }
    return NO;
}

@end
