//
//  TermGrades.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TermGrade.h"
NS_ASSUME_NONNULL_BEGIN

@interface TermGrades : NSObject<NSCoding>
@property (nonatomic)NSArray<TermGrade *> *termGrades;
@property(nonatomic)NSNumber *a_credit;
@property(nonatomic)NSNumber *b_credit;

- (instancetype)initWithDictionary: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
