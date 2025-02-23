//
//  ExamArrangeDataItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExamArrangeDataItem : NSObject
@property (nonatomic, copy)NSString *student;
@property (nonatomic, copy)NSString *course;
@property (nonatomic, copy)NSString *classroom;
@property (nonatomic, copy)NSString *seat;
@property (nonatomic, copy)NSString *week;
@property (nonatomic, copy)NSString *weekday;
@property (nonatomic, copy)NSString *begin_time;
@property (nonatomic, copy)NSString *end_time;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *date;
@property (nonatomic, copy)NSString *type;
- (instancetype)initWithDictionary: (NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
