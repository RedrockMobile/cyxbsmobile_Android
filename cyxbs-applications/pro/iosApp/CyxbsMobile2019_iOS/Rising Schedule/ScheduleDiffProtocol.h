//
//  ScheduleDiffProtocol.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/11.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ScheduleModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ScheduleDiffProtocol <NSObject>

- (BOOL)isDiffModel;

- (NSComparisonResult)compareCourse:(ScheduleCourse *)aCourse withCourse:(ScheduleCourse *)bCourse;

@end

NS_ASSUME_NONNULL_END
