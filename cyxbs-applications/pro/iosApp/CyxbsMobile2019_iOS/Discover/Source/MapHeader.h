//
//  MapHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 小艾同学 on 2022/7/28.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef MapHeader_h
#define MapHeader_h

#pragma mark - UserDefault

/// 重邮地图历史记录偏好设置Key
#define Discover_cquptMapHistoryKey_String @"MapSearchHistory"

#pragma mark - API

/// 重邮地图主页
#define Discover_GET_cquptMapBasicData_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-stumap/basic"]
/// 重邮地图热搜
#define Discover_GET_cquptMapHotPlace_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-stumap/button"]
/// 重邮地图：我的收藏
#define Discover_GET_cquptMapMyStar_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-stumap/rockmap/collect"]
/// 重邮地图：搜索地点
#define Discover_POST_cquptMapSearch_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-stumap/placesearch"]
/// 重邮地图：地点详情
#define Discover_POST_cquptMapPlaceDetail_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-stumap/detailsite"]
/// 重邮地图：上传图片
#define Discover_POST_cquptMapUploadMage_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-stumap/rockmap/upload"]
/// 重邮地图：添加收藏
#define Discover_PATCH_cquptMapAddCollect_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-stumap/rockmap/addkeep"]
/// 重邮地图：删除收藏
#define Discover_POST_cquptMapDeleteCollect_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-stumap/rockmap/delete"]

#endif /* MapHeader_h */
