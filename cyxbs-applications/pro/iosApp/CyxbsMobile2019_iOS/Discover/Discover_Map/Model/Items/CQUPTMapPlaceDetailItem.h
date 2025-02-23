//
//  CQUPTMapPlaceDetail.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/15.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQUPTMapPlaceDetailItem : NSObject

@property (nonatomic, weak) NSString *placeID;
@property (nonatomic, weak) NSString *placeName;
@property (nonatomic, copy) NSArray *placeAttributesArray;
@property (nonatomic, copy) NSArray *tagsArray;
@property (nonatomic, copy) NSArray *imagesArray;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
