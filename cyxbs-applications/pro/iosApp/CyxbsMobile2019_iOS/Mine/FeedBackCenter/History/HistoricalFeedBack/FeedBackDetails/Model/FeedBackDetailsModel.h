//
//  FeedBackDetailsModel.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 反馈详情
 */
@interface FeedBackDetailsModel : NSObject

@property (nonatomic, copy) NSString * CreatedAt;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSArray * pictures; // urls

@end

NS_ASSUME_NONNULL_END
