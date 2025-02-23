//
//  ElectricFeeItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2019/11/10.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import "ElectricFeeItem.h"

@implementation ElectricFeeItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        if (dict[@"elec_inf"][@"elec_cost"][0] == [NSNull null] || dict[@"elec_inf"][@"elec_cost"][1] == [NSNull null]) {
            self.money = @"0";
        } else {
            self.money = [NSString stringWithFormat:@"%@.%@", dict[@"elec_inf"][@"elec_cost"][0], dict[@"elec_inf"][@"elec_cost"][1]];
        }
        
        id room = dict[@"elec_inf"][@"room"];
        if ([room isKindOfClass:NSString.class]) {
            self.buildAndRoom = (NSString *)room;
        } else {
            self.buildAndRoom = [NSString stringWithFormat:@"%@", [dict[@"elec_inf"][@"room"] stringValue]];
        }
        self.consume = [NSString stringWithFormat:@"%@", [dict[@"elec_inf"][@"elec_spend"] stringValue]];
        
        NSString *returnTime = [NSString stringWithFormat:@"%@", dict[@"elec_inf"][@"record_time"]];
        
        if (![returnTime isKindOfClass:[NSString class]] || returnTime.length < 5) {
            self.time = @"";
        } else {
            int month = [[returnTime substringToIndex:2] intValue];
            int day = [[returnTime substringWithRange:NSMakeRange(3, 2)] intValue];
            self.time = [NSString stringWithFormat:@"%d.%d", month, day];
        }
    }
    return self;
}

@end
