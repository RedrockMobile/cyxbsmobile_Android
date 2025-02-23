//
//  EmptyClassProtocol.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/19.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class EmptyClassItem;
@protocol EmptyClassProtocol <NSObject>

- (void)emptyClassRoomDataRequestsSuccess:(NSArray<EmptyClassItem *> *)itemsArray;
- (void)emptyClassRoomDataRequestsfailure:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
