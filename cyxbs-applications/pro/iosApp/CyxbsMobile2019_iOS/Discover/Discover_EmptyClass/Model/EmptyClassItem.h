//
//  EmptyClassItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/22.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 仅表示每一层楼的数据
@interface EmptyClassItem : NSObject

/// 房间号
@property (nonatomic, copy) NSArray<NSString *> *roomArray;

/// 楼层
@property (nonatomic, copy) NSString *floorNum;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
