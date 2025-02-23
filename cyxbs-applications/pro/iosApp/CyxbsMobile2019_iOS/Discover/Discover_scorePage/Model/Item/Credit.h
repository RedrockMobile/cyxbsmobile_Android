//
//  Credit.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Credit : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *credit;

-(instancetype)initWithDictionary: (NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
