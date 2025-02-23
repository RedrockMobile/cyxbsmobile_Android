//
//  CQUPTMapHotPlaceItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQUPTMapHotPlaceItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<NSString *> *placeIDArray;
@property (nonatomic, assign) BOOL isHot;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
