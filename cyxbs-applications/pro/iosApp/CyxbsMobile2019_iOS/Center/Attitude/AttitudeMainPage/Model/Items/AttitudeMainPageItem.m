//
//  AttitudeMainPageItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/13.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "AttitudeMainPageItem.h"

@implementation AttitudeMainPageItem

+ (instancetype)initWithDic:(NSDictionary *)dic {
    AttitudeMainPageItem *model = [[AttitudeMainPageItem alloc] init];
    model.theId = dic[@"Id"];
    model.title = dic[@"Title"];
    return model;
}

@end
