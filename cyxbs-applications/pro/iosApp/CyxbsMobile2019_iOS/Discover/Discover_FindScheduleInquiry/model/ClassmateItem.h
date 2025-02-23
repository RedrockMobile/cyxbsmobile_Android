//
//  ClassmateItem.h
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/9/27.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassmateItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *major;
@property (nonatomic, copy) NSString *stuNum;
@property (nonatomic, copy) NSString *teaNum;
+ (ClassmateItem *)classmateWithDictionary:(NSDictionary *)dictionary;
+ (ClassmateItem *)teaItemWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
