//
//  TermGrade.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "TermGrade.h"
@implementation TermGrade
- (instancetype)initWithDictionary: (NSDictionary *)dict {
    if (self = [super init]) {
        self.term = dict[@"term"];
        self.gpa = dict[@"gpa"];
        self.grade = dict[@"grade"];
        self.rank = dict[@"rank"];
        NSMutableArray<SingleGrade*> *arr = [NSMutableArray array];
        for (NSDictionary *g in dict[@"singe_grades"]) {
            SingleGrade *single = [[SingleGrade alloc]initWithDictionary:g];
            [arr addObject:single];
        }
        self.singegradesArr = arr;
    }
    return self;
}
- (void)encodeWithCoder:(nonnull NSCoder *)coder { 
    [coder encodeObject:self.term forKey:@"term"];
    [coder encodeObject:self.gpa forKey:@"gpa"];
    [coder encodeObject:self.grade forKey:@"grade"];
    [coder encodeObject:self.rank forKey:@"rank"];
    [coder encodeObject:self.singegradesArr forKey:@"single_grades"];
}
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {

    if(self = [super init]) {
        self.term = [coder decodeObjectForKey:@"term"];
        self.gpa = [coder decodeObjectForKey:@"gpa"];
        self.grade = [coder decodeObjectForKey:@"grade"];
        self.rank = [coder decodeObjectForKey:@"rank"];
        self.singegradesArr = [coder decodeObjectForKey:@"single_grades"];
    }
    return self;
}

@end
