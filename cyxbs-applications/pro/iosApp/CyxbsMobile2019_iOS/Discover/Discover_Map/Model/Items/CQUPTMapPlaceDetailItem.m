//
//  CQUPTMapPlaceDetail.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/15.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapPlaceDetailItem.h"

@implementation CQUPTMapPlaceDetailItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) { 
        self.placeName = dict[@"place_name"];
        self.placeAttributesArray = dict[@"place_attribute"];
        self.tagsArray = dict[@"tags"];
        self.imagesArray = dict[@"images"];
    }
    return self;
}

@end
