//
//  FeedBackDetailsModel.m
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "FeedBackDetailsModel.h"

@implementation FeedBackDetailsModel

- (NSArray *)pictures {
    if (_pictures == nil) {
        _pictures = [NSArray array];
    }
    return _pictures;
}

@end
