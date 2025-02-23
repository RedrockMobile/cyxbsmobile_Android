//
//  AttitudeMainPageItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/13.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttitudeMainPageItem : NSObject
// id
@property (nonatomic, copy) NSNumber *theId;
// title
@property (nonatomic, copy) NSString *title;

+ (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
