//
//  ToDoHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 小艾同学 on 2022/7/28.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef ToDoHeader_h
#define ToDoHeader_h

#pragma mark - API

// 获取上次同步时间
//@"https://be-prod.redrock.cqupt.edu.cn/magipoke-todo/sync-time"
#define ToDo_GET_lastSyncTime_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-todo/sync-time"]

// 第一次从服务器下载数据
//@"https://be-prod.redrock.cqupt.edu.cn/magipoke-todo/list"
#define ToDo_GET_firstDownload_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-todo/list"]

// 下载数据
//@"https://be-prod.redrock.cqupt.edu.cn/magipoke-todo/todos"
#define ToDo_GET_downloadData_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-todo/todos"]

//
// @"https://be-prod.redrock.cqupt.edu.cn/magipoke-todo/batch-create"
#define ToDo_POST_firstPush_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-todo/batch-create"]

#endif /* ToDoHeader_h */
