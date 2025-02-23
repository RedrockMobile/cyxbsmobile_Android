//
//  MGDGroup.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2021/9/9.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "MGDGroup.h"

@interface MGDGroup ()

@property (nonatomic, readwrite) dispatch_group_t dispatchGroup;

@end

@implementation MGDGroup

- (instancetype)init {
    if (self = [super init]) {
        self.dispatchGroup = dispatch_group_create();
    }
    return self;
}

- (void)enter {
    dispatch_group_enter(self.dispatchGroup);
}

- (void)leave {
    dispatch_group_leave(self.dispatchGroup);
}

- (void)wait {
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta {
    return dispatch_group_wait(self.dispatchGroup, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}

- (void)dealloc{
    self.dispatchGroup = nil;
}

@end

