//
//  TermGrades.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "TermGrades.h"

@implementation TermGrades
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.a_credit = dict[@"a_credit"];
        self.b_credit = dict[@"b_credit"];
        NSMutableArray<TermGrade*> *arr = [NSMutableArray array];
        for (NSDictionary * d in dict[@"term_grades"]) {
            TermGrade * g = [[TermGrade alloc]initWithDictionary:d];
            [arr addObject:g];
        }
        self.termGrades = arr;
    }
    return self;
}
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.a_credit forKey:@"a_credit"];
    [coder encodeObject:self.b_credit forKey:@"b_credit"];
    [coder encodeObject:self.termGrades forKey:@"termGrades"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if(self = [super init]) {
        self.a_credit = [coder decodeObjectForKey:@"a_credit"];
        self.b_credit = [coder decodeObjectForKey:@"b_credit"];
        self.termGrades = [coder decodeObjectForKey:@"termGrades"];
    }
    return self;
}

@end
