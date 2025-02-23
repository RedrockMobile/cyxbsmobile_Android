//
//  CQUPTMapViewProtocol.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CQUPTMapDataItem, CQUPTMapHotPlaceItem, CQUPTMapStarPlaceItem, CQUPTMapSearchItem, CQUPTMapPlaceDetailItem;
@protocol CQUPTMapViewProtocol <NSObject>

- (void)mapDataRequestSuccessWithMapData:(CQUPTMapDataItem *)mapData hotPlace:(NSArray<CQUPTMapHotPlaceItem *> *)hotPlaceArray;

- (void)starPlaceRequestSuccessWithStarPlace:(CQUPTMapStarPlaceItem *)starPlace;

- (void)searchPlaceSuccess:(NSArray<CQUPTMapSearchItem *> *)placeIDArray;

- (void)placeDetailDataRequestSuccess:(CQUPTMapPlaceDetailItem *)placeDetailItem;

@end

NS_ASSUME_NONNULL_END
