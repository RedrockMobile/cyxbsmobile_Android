//
//  CQUPTMapSearchItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/13.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapSearchItem.h"

@implementation CQUPTMapSearchItem

- (instancetype)initWithID:(int)ID {
    if (self = [super init]) {
        self.placeID = ID;
    }
    return self;
}

@end
