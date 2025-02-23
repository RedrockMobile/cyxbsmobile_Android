//
//  PublishPageModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/21.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishPageModel : NSObject

- (void)postTagWithTitle:(NSString *)title
              andChoices:(NSArray<NSString *> *)array
             withSuccess:(void(^)(void))success
                 Failure:(void(^)(void))failure;
@end

NS_ASSUME_NONNULL_END
