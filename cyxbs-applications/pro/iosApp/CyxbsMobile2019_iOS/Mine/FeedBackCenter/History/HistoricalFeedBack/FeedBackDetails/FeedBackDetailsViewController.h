//
//  FeedBackDetailsViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "TopBarBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN
/**
 点击了一条历史反馈之后的跳转
 */
@interface FeedBackDetailsViewController : TopBarBasicViewController

- (instancetype)initWithFeedBackID:(long)feedback_id
                 whenPopCompletion:(void (^)(void))popCompletion;

@end

NS_ASSUME_NONNULL_END
