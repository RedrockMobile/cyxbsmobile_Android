//
//  GPAItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TermGrades.h"
#import "Credits.h"
NS_ASSUME_NONNULL_BEGIN

@interface GPAItem : NSObject<NSCoding>
@property (nonatomic, copy)NSString *status;
@property (nonatomic)TermGrades * termGrades;
@property (nonatomic)Credits *credits;
- (instancetype)initWithDictionary: (NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
