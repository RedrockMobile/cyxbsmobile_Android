//
//  ExamArrangeData.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExamArrangeDataItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExamArrangeData : NSObject
@property (nonatomic, copy)NSString *nowWeek;
@property (nonatomic, copy)NSString *version;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, strong) NSArray<ExamArrangeDataItem*> *data;
- (instancetype)initWithDic: (NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
