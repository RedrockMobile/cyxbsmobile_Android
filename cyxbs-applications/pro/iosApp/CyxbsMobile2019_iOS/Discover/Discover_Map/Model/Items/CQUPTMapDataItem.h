//
//  CQUPTMapDataItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class CQUPTMapPlaceItem;
@interface CQUPTMapDataItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *hotWord;
@property (nonatomic, copy) NSArray<CQUPTMapPlaceItem *> *placeList;
@property (nonatomic, copy) NSString *mapURL;
@property (nonatomic, copy) NSString *mapColor;
@property (nonatomic, assign) CGFloat mapWidth;
@property (nonatomic, assign) CGFloat mapHeight;
@property (nonatomic, copy) NSString *mapVersion;   // 时间戳

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (NSString *)archivePath;

- (void)archiveItem;

@end

NS_ASSUME_NONNULL_END
