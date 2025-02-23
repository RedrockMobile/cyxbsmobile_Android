//
//  AttitudeSelfPageDataItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/19.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 获取个人中心数据Item
@interface AttitudeSelfPageDataItem : NSObject
// id
@property (nonatomic, copy) NSNumber *theId;
// title
@property (nonatomic, copy) NSString *title;

+ (instancetype)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
