//
//  Credits.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "Credits.h"

@implementation Credits

-(instancetype) initWithDictionary: (NSDictionary *)dict {
    if(self = [super init]) {
        NSMutableArray<Credit*>*arr = [NSMutableArray array];
        for (NSDictionary *d in dict) {
            Credit * cre = [[Credit alloc]initWithDictionary:d];
            [arr addObject:cre];
        }
        self.creditsArr = arr;
    }
    return self;
}
@end
