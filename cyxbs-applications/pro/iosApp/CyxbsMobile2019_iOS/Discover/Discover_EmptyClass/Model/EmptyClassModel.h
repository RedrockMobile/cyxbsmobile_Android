//
//  EmptyClassModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/22.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmptyClassModel : NSObject

+ (void)RequestEmptyClassDataWithParams:(NSDictionary *)params
                                success:(void (^)(NSDictionary *responseObject))success
                                failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
