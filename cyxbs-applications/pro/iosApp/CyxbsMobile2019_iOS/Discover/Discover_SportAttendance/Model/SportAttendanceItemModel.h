//
//  SportAttendanceItemModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/5.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SportAttendanceItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SportAttendanceItemModel : NSObject

/// item
@property (nonatomic, strong, nonnull) NSArray <SportAttendanceItem *> *itemAry;

/// 根据数组<里面全是字典>
/// @param ary 数组
- (instancetype)initWithArray:(NSArray <NSDictionary *> *)ary;


@end

NS_ASSUME_NONNULL_END
