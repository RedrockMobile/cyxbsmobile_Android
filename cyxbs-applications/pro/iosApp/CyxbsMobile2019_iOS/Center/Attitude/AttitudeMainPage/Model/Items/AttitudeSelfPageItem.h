//
//  AttitudeSelfPageItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/19.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 鉴权Item
@interface AttitudeSelfPageItem : NSObject
@property (nonatomic, copy) NSNumber *isPerm;

+ (instancetype)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
