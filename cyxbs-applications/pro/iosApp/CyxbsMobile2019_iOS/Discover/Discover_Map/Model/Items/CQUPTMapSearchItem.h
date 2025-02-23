//
//  CQUPTMapSearchItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/13.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQUPTMapSearchItem : NSObject

@property (nonatomic, assign) int placeID;

- (instancetype)initWithID:(int)ID;

@end

NS_ASSUME_NONNULL_END
