
//  CQUPTMapModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQUPTMapDataItem.h"
#import "CQUPTMapHotPlaceItem.h"
#import "CQUPTMapStarPlaceItem.h"
#import "CQUPTMapSearchItem.h"
#import "CQUPTMapPlaceDetailItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQUPTMapModel : NSObject

+ (void)requestMapDataSuccess:(void (^)(CQUPTMapDataItem *mapDataItem, NSArray<CQUPTMapHotPlaceItem *> *hotPlaceItemArray))success
                       failed:(void (^)(NSError *error))failed;

+ (void)requestHotPlaceSuccess:(void (^)(NSArray<CQUPTMapHotPlaceItem *> *hotPlaceItemArray))success;

+ (void)requestStarListSuccess:(void (^)(CQUPTMapStarPlaceItem *starPlace))success
                        failed:(void (^)(NSError *error))failed;

+ (void)requestPlaceDataWithPlaceID:(NSString *)placeID
                            success:(void (^)(CQUPTMapPlaceDetailItem *placeDetailItem))success
                             failed:(void (^)(NSError *error))failed;

+ (void)starPlaceWithPlaceID:(NSString *)placeID;

+ (void)deleteStarPlaceWithPlaceID:(NSString *)placeID;

@end

NS_ASSUME_NONNULL_END
