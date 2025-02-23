//
//  ClassDetailModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/9/7.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassDetailModel : NSObject

+ (void)requestPlaceIDWithPlaceName:(NSString *)placeName
                            success:(void(^)(NSDictionary *responseObject))success;

@end

NS_ASSUME_NONNULL_END
