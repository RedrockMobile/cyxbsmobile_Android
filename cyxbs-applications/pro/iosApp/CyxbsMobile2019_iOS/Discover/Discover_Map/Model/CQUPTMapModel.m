//
//  CQUPTMapModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapModel.h"
#import "CQUPTMapStarPlaceItem.h"

@implementation CQUPTMapModel

+ (void)requestMapDataSuccess:(void (^)(CQUPTMapDataItem * _Nonnull, NSArray<CQUPTMapHotPlaceItem *> * _Nonnull))success
                       failed:(void (^)(NSError * _Nonnull))failed {
    
    [HttpTool.shareTool
     request:Discover_GET_cquptMapBasicData_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        if ([object[@"status"] intValue] == 200) {
            
            // 继续请求热词
            [self requestHotPlaceSuccess:^(NSArray<CQUPTMapHotPlaceItem *> * _Nonnull hotPlaceItemArray) {
                CQUPTMapDataItem *mapDataItem = [[CQUPTMapDataItem alloc] initWithDict:object];
                success(mapDataItem, hotPlaceItemArray);
            }];
            
        } else {
            failed([[NSError alloc] init]);
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

+ (void)requestHotPlaceSuccess:(void (^)(NSArray<CQUPTMapHotPlaceItem *> * _Nonnull))success {
    
    [HttpTool.shareTool
     request:Discover_GET_cquptMapHotPlace_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        if ([object[@"status"] intValue] == 200) {
            NSMutableArray *tmpArray = [NSMutableArray array];
            for (NSDictionary *dict in object[@"data"][@"button_info"]) {
                CQUPTMapHotPlaceItem *hotPlaceItem = [[CQUPTMapHotPlaceItem alloc] initWithDict:dict];
                [tmpArray addObject:hotPlaceItem];
            }
            if (success) {
                success(tmpArray);
            }
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

+ (void)requestStarListSuccess:(void (^)(CQUPTMapStarPlaceItem * _Nonnull))success
                        failed:(void (^)(NSError * _Nonnull))failed {
    
    [HttpTool.shareTool
     request:Discover_GET_cquptMapMyStar_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        if ([object[@"status"] intValue] == 200) {
            
            CQUPTMapStarPlaceItem *item = [[CQUPTMapStarPlaceItem alloc] initWithDice:object];
            
            success(item);
        } else if ([object[@"data"] isEqualToString:@""]) {
            // 这里后端的逻辑很奇怪，没有收藏的时候data本来应该是@{}，但是却返回了一个@""，并且status是500。
            // 所以这里只有单独写一个判断了。
            CQUPTMapStarPlaceItem *item = [[CQUPTMapStarPlaceItem alloc] init];
            if (success) {
                success(item);
            }
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)requestPlaceDataWithPlaceID:(NSString *)placeID success:(nonnull void (^)(CQUPTMapPlaceDetailItem * _Nonnull))success failed:(nonnull void (^)(NSError * _Nonnull))failed {
    NSDictionary *params = @{
        @"place_id": placeID
    };
    
    [HttpTool.shareTool
     request:Discover_POST_cquptMapPlaceDetail_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:params
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        if ([object[@"status"] intValue] == 200) {
            CQUPTMapPlaceDetailItem *item = [[CQUPTMapPlaceDetailItem alloc] initWithDict:object[@"data"]];
            item.placeID = placeID;
            if (success) {
                success(item);
            }
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)starPlaceWithPlaceID:(NSString *)placeID {
    NSDictionary *params = @{
        @"place_id": placeID
    };
    
    [HttpTool.shareTool
     request:Discover_PATCH_cquptMapAddCollect_API
     type:HttpToolRequestTypePatch
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:params
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSError *error = nil;
        NSData *archiveData = [NSData dataWithContentsOfFile:[CQUPTMapStarPlaceItem archivePath]];
        CQUPTMapStarPlaceItem *item = [NSKeyedUnarchiver unarchivedObjectOfClass:[CQUPTMapStarPlaceItem class] fromData:archiveData error:&error];
        if (error) {
            // 处理错误情况
            NSLog(@"Unarchive Error: %@", error);
        }
        [item.starPlaceArray addObject:placeID];
        [item archiveItem];
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)deleteStarPlaceWithPlaceID:(NSString *)placeID {
    NSDictionary *params = @{
        @"place_id": placeID
    };
    
    [HttpTool.shareTool
     request:Discover_POST_cquptMapDeleteCollect_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:params
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSError *error = nil;
        NSData *archiveData = [NSData dataWithContentsOfFile:[CQUPTMapStarPlaceItem archivePath]];
        CQUPTMapStarPlaceItem *item = [NSKeyedUnarchiver unarchivedObjectOfClass:[CQUPTMapStarPlaceItem class] fromData:archiveData error:&error];
        if (error) {
            // 处理错误情况
            NSLog(@"Unarchive Error: %@", error);
        }
        [item.starPlaceArray removeObject:placeID];
        [item archiveItem];
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
