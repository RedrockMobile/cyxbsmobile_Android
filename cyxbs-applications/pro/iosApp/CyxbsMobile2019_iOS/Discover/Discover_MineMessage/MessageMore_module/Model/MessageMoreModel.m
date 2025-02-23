//
//  MessageMoreModel.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/19.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "MessageMoreModel.h"

@implementation MessageMoreModel

- (instancetype)initWithMsgImg:(UIImage *)img title:(NSString *)title {
    self = [super init];
    if (self) {
        self.msgImg = img;
        self.msgStr = title;
    }
    return self;
}

+ (NSArray <MessageMoreModel *> *)systemModels {
    return @[
        [[MessageMoreModel alloc]
        initWithMsgImg:[UIImage imageNamed:@"hadread_d"]
        title:@"一键已读"],
    
        [[MessageMoreModel alloc]
        initWithMsgImg:[UIImage imageNamed:@"delete_read"]
        title:@"删除已读"],
    
        [[MessageMoreModel alloc]
        initWithMsgImg:[UIImage imageNamed:@"setting"]
        title:@"设置"],
    ];
}

+ (NSArray <MessageMoreModel *> *)activeModels {
    return @[
        [[MessageMoreModel alloc]
        initWithMsgImg:[UIImage imageNamed:@"hadread_d"]
        title:@"一键已读"],
    
        [[MessageMoreModel alloc]
        initWithMsgImg:[UIImage imageNamed:@"setting_d"]
        title:@"设置"],
    ];
}

@end
