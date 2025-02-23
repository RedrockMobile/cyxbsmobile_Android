//
//  StampCenterHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 小艾同学 on 2022/7/27.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef StampCenterHeader_h
#define StampCenterHeader_h

// 邮票中心
#pragma mark - API

// 积分兑换记录, 对应 =兑换记录= 界面
#define Mine_GET_stampStoreDetailsExchange_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-intergral/User/exchange"]

// 积分获得信息, 对应 =获取记录= 界面
#define Mine_GET_stampStoreDetailsGetRecord_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-intergral/User/getRecord"]

//主页信息
#define Mine_GET_stampStoreMainPage_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-intergral/User/info"]

//任务
#define Mine_POST_task_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-intergral/Integral/progress"]

// 商品
#define Mine_GET_stampStoreGoods_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-intergral/Integral/getItemInfo"]

// 兑换
#define Mine_POST_stampStoreExchange_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-intergral/Integral/purchase"]


#endif /* StampCenterHeader_h */
