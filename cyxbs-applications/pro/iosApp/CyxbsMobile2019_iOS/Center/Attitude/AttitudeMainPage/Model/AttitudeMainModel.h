//
//  AttitudeMainModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/7.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttitudeMainModel : NSObject
/// 有参
- (void)requestAttitudeDataWithOffset:(NSInteger)offset
                                Limit:(NSInteger)limit
                              Success:(void (^)(NSArray * array))success
                              Failure:(void (^)(NSError * _Nonnull))failure;

@end

NS_ASSUME_NONNULL_END
