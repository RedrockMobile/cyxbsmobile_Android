//
//  Credits.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Credit.h"
NS_ASSUME_NONNULL_BEGIN

@interface Credits : NSObject


@property (nonatomic) NSArray<Credit*> *creditsArr;


-(instancetype) initWithDictionary: (NSDictionary *)dict;



@end

NS_ASSUME_NONNULL_END
