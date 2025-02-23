//
//  ExpressDeclareModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/5.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpressDeclareModel : NSObject

- (void)requestDeclareDataWithId:(NSNumber *)theId
                         Success:(void(^)(bool declareSuccess))success
                         Failure:(void(^)(NSError * _Nonnull))failure;

@end

NS_ASSUME_NONNULL_END
