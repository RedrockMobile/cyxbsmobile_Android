//
//  CQUPTMapPlaceItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CQUPTMapStarPlaceItem;
@interface CQUPTMapPlaceItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *placeName;
@property (nonatomic, copy) NSString *placeId;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, copy) NSArray<CQUPTMapPlaceRect *> *buildingList;
@property (nonatomic, strong) CQUPTMapPlaceRect *tagRect;

- (instancetype)initWithDict:(NSDictionary *)dict mapWidth:(CGFloat)width mapHeight:(CGFloat)height;

- (BOOL)isCollected;

@end

NS_ASSUME_NONNULL_END
