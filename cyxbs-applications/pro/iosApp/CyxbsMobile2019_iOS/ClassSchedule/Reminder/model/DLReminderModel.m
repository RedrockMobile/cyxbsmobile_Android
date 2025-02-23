//
//  DLReminderModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/9.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DLReminderModel.h"

@implementation DLReminderModel
- (instancetype)initWithRemindDict:(NSDictionary *)remind{
    self = [self init];
    if (self) {
        self.idNum = [remind objectForKey:@"idNum"];
        self.content = [remind objectForKey:@"content"];
        self.title = [remind objectForKey:@"title"];
    }
    return self;
}

+ (instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithRemindDict: dict];
}
@end
