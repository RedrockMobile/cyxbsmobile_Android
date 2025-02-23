//
//  ExpressPickPutModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/5.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpressPickPutItem.h"

NS_ASSUME_NONNULL_BEGIN
// 表态投票
@interface ExpressPutModel : NSObject

- (void)requestPutDataWithId:(NSNumber *)theID Choice:(NSString *)choice Success:(void(^)(ExpressPickPutItem *model))success Failure:(void(^)(NSError * _Nonnull))failure;

@end

NS_ASSUME_NONNULL_END
