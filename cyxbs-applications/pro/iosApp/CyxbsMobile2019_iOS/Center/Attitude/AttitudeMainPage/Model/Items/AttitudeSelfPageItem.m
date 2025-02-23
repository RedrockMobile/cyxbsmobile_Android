//
//  AttitudeSelfPageItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/19.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "AttitudeSelfPageItem.h"

@implementation AttitudeSelfPageItem

+ (instancetype)initWithDic:(NSDictionary *)dic {
    AttitudeSelfPageItem *item = [[AttitudeSelfPageItem alloc] init];
    item.isPerm = dic[@"isPerm"];
    return item;
}
@end
