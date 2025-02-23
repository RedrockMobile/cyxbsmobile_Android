//
//  SingleGrade.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/10.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "SingleGrade.h"

@implementation SingleGrade
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init] ){
        self.class_num = dict[@"class_num"];
        self.class_name = dict[@"class_name"];
        self.class_type = dict[@"class_type"];
        self.credit = dict[@"credit"];
        self.exam_type = dict[@"exam_type"];
        self.grade = dict[@"grade"];
        self.gpa = dict[@"gpa"];
    }
    return self;
}
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.class_num forKey:@"class_num"];
    [coder encodeObject:self.class_name forKey:@"class_name"];
    [coder encodeObject:self.class_type forKey:@"class_typr"];
    [coder encodeObject:self.credit forKey:@"credit"];
    [coder encodeObject:self.exam_type forKey:@"exam_type"];
    [coder encodeObject:self.grade forKey:@"grade"];
    [coder encodeObject:self.gpa forKey:@"gpa"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if(self = [super init]) {
        self.class_num = [coder decodeObjectForKey:@"class_num"];
        self.class_name = [coder decodeObjectForKey:@"class_name"];
        self.class_type = [coder decodeObjectForKey:@"class_type"];
        self.credit = [coder decodeObjectForKey:@"credit"];
        self.exam_type = [coder decodeObjectForKey:@"exam_type"];
        self.grade = [coder decodeObjectForKey:@"grade"];
        self.gpa = [coder decodeObjectForKey:@"gpa"];
    }
    return self;
}

@end
