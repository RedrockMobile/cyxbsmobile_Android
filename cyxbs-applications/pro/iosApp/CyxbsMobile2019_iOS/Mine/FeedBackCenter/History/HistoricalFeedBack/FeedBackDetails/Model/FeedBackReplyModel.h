//
//  FeedBackReplyModel.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 反馈回复
 */
@interface FeedBackReplyModel : NSObject

@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSArray * urls;
@property (nonatomic, copy) NSString * CreatedAt;
@property (nonatomic, assign) long ID;

@end

NS_ASSUME_NONNULL_END
