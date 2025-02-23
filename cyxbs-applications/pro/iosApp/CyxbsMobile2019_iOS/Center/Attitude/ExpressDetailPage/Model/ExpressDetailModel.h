//
//  ExpressPickGetModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/5.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpressPickGetItem.h"

NS_ASSUME_NONNULL_BEGIN
// 获取表态页详细信息
@interface ExpressDetailModel : NSObject

- (void)requestDetailDataWithId:(NSNumber *)theId
                           Success:(void(^)(ExpressPickGetItem *model))success
                           Failure:(void(^)(NSError * _Nonnull))failure;
@end

NS_ASSUME_NONNULL_END
