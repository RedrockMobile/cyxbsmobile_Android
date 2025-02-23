//
//  ClassmateItem.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/9/27.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ClassmateItem.h"

@implementation ClassmateItem

+ (ClassmateItem *)classmateWithDictionary:(NSDictionary *)dictionary {
    ClassmateItem *item = [[ClassmateItem alloc] init];
    
    item.name = dictionary[@"name"];
    item.major = dictionary[@"major"];
    item.stuNum = dictionary[@"stunum"];
    
    return item;
}
+ (ClassmateItem *)teaItemWithDictionary:(NSDictionary *)dictionary{
    ClassmateItem *item = [[ClassmateItem alloc] init];
    
    item.name = dictionary[@"name"];
    item.major = dictionary[@"teaMajor"];
    item.teaNum = dictionary[@"teaNum"];
    
    return item;
}
@end
