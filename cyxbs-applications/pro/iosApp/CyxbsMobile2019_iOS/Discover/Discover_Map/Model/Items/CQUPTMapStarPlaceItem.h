//
//  CQUPTMapStarPlaceItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/12.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CQUPTMapPlaceItem;
@interface CQUPTMapStarPlaceItem : NSObject <NSCoding>

+ (NSString *)archivePath;

- (void)archiveItem;

@property (nonatomic, strong) NSMutableArray<NSString *> *starPlaceArray;

- (instancetype)initWithDice:(NSDictionary *)dict;

+ (NSArray<CQUPTMapPlaceItem *> *)starPlaceDetail;

@end

NS_ASSUME_NONNULL_END
