//
//  Credit.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "Credit.h"

@implementation Credit


- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.credit = dict[@"credit"];
    }
    return self;
}

@end
