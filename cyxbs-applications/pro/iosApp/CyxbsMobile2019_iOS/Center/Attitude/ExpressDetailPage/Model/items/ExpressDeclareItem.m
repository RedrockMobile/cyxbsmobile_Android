//
//  ExpressDeclareItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "ExpressDeclareItem.h"

@implementation ExpressDeclareItem
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.declareId = dic[@"id"];
    }
    return self;
}
@end
