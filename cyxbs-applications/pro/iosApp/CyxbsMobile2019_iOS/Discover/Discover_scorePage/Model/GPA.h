//
//  GPA.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/10.
//  Copyright © 2020 Redrock. All rights reserved.
//
#import "GPAItem.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface GPA : NSObject
@property (nonatomic, strong)GPAItem *gpaItem;
-(void) fetchData;

@end

NS_ASSUME_NONNULL_END
