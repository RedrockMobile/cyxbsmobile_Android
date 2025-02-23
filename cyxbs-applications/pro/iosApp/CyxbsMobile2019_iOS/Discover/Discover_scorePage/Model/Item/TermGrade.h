//
//  TermGrade.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleGrade.h"

NS_ASSUME_NONNULL_BEGIN

@interface TermGrade : NSObject<NSCoding>

@property (nonatomic, copy)NSString *term;
@property (nonatomic)NSNumber *gpa;
@property (nonatomic)NSNumber *grade;
@property (nonatomic)NSNumber *rank;
@property (nonatomic) NSArray<SingleGrade*> *singegradesArr;
- (instancetype)initWithDictionary: (NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
