//
//  MainPageModel.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/3/3.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "MainPageModel.h"


@implementation MainPageModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = 1;
        self.dataArr = [[NSMutableArray alloc] init];
    }
    return self;
}

/// 加载更多数据
- (void)loadMoreData {
    //抛出异常，非DEBUG状态也会崩溃
    @throw [[NSException alloc] initWithName:NSInvalidArgumentException reason:@"需要子类自己实现loadMoreData方法" userInfo:nil];
}
@end
