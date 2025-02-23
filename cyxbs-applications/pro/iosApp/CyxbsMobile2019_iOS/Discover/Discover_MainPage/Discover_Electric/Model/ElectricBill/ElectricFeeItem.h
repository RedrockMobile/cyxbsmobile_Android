//
//  ElectricFeeItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2019/11/10.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ElectricFeeItem : NSObject

@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *consume;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *buildAndRoom;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
