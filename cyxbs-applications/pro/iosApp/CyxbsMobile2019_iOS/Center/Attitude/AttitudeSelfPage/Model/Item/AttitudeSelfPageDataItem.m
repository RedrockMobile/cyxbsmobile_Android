//
//  AttitudeSelfPageDataItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/19.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "AttitudeSelfPageDataItem.h"

@implementation AttitudeSelfPageDataItem
+ (instancetype)initWithDic:(NSDictionary *)dic {
    AttitudeSelfPageDataItem *model = [[AttitudeSelfPageDataItem alloc] init];
    model.theId = dic[@"Id"];
    model.title = dic[@"Title"];
    return model;
}
@end
