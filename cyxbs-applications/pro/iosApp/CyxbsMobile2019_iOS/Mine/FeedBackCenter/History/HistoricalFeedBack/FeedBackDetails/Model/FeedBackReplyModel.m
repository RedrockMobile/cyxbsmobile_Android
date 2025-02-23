//
//  FeedBackReplyModel.m
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "FeedBackReplyModel.h"

@implementation FeedBackReplyModel

- (NSArray *)urls {
    if (_urls == nil) {
        _urls = [NSArray array];
    }
    return _urls;
}

@end
