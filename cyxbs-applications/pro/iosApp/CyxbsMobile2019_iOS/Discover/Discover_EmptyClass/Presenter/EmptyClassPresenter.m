//
//  EmptyClassPresenter.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/19.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "EmptyClassPresenter.h"
#import "EmptyClassModel.h"
#import "EmptyClassItem.h"

@implementation EmptyClassPresenter

- (void)requestEmptyClassRoomDataWithParams:(NSDictionary *)params {
    [EmptyClassModel RequestEmptyClassDataWithParams:params success:^(NSDictionary * _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        NSMutableDictionary<NSString *, id> *itemData = [@{
            @"floorNum": @"",
            @"roomArray": [@[] mutableCopy]
        } mutableCopy];
        
        NSMutableArray *tmpDataArray = [NSMutableArray array];

        // 遍历返回的数据，将所有数据按楼层分类，每层楼一个item
        for (NSString *room in responseObject[@"data"]) {
            NSString *floor = [room substringWithRange:NSMakeRange(1, 1)];
            if ([NSString stringWithFormat:@"%@", itemData[@"floorNum"]].length == 0 || [[NSString stringWithFormat:@"%@", itemData[@"floorNum"]] isEqualToString:floor]) {
                itemData[@"floorNum"] = floor;
                [(NSMutableArray *)itemData[@"roomArray"] addObject:room];
            } else {
                EmptyClassItem *item = [[EmptyClassItem alloc] initWithDictionary:itemData];
                [tmpDataArray addObject:item];
                
                itemData[@"floorNum"] = floor;
                [(NSMutableArray *)itemData[@"roomArray"] removeAllObjects];
                [(NSMutableArray *)itemData[@"roomArray"] addObject:room];
            }
        }
        // 添加最后一层楼的数据
        EmptyClassItem *item = [[EmptyClassItem alloc] initWithDictionary:itemData];
        [tmpDataArray addObject:item];
        
        [self.attatchedView emptyClassRoomDataRequestsSuccess:tmpDataArray];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)attatchView:(UIViewController<EmptyClassProtocol> *)attatchedView {
    _attatchedView = attatchedView;
}

- (void)dettatchView {
    _attatchedView = nil;
}

@end
