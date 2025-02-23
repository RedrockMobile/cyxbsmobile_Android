//
//  FoodDetailsModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/25.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "FoodDetailsModel.h"

@implementation FoodDetailsModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.name = [dic valueForKey:@"FoodName"];
        self.pictureURL = [dic valueForKey:@"Picture"];
        self.introduce = [dic valueForKey:@"Introduce"];
        self.praise_num = [dic intValueForKey:@"PraiseNum" default:0];
        self.praise_is = [dic boolValueForKey:@"PraiseIs" default:NO];
    }
    return self;
}

@end
