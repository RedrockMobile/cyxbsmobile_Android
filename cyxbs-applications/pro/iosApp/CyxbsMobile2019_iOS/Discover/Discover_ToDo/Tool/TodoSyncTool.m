//
//  TodoSyncTool.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/8/15.
//  Copyright © 2021 Redrock. All rights reserved.
//
//  好长的数据处理代码，S.H.I.T
//

#import "TodoSyncTool.h"
#import <AFNetworkReachabilityManager.h>
#import "TodoDateTool.h"
#import <sqlite3.h>

//同步完成后的方式的通知名，通知的object有下面3种，分别代表成功、失败、冲突
NSNotificationName const TodoSyncToolSyncNotification = @"TodoSyncToolSyncNotification";
//NSString* const TodoSyncToolSyncNotificationSuccess = @"TodoSyncToolSyncNotificationSuccess";
//NSString* const TodoSyncToolSyncNotificationFailure = @"TodoSyncToolSyncNotificationFailure";
//NSString* const TodoSyncToolSyncNotificationConflict = @"TodoSyncToolSyncNotificationConflict";

//用来从缓存获取上次同步的时间戳
NSString* const TodoSyncToolKeyLastSyncTimeStamp = @"TodoSyncToolKeyLastSyncTimeStamp";
//用来从缓存获取是否修改过
NSString* const TodoSyncToolKeyIsModified = @"TodoSyncToolKeyIsModified";
//用来从缓存获取上次更新数据库全部todo的时间戳
NSString* const TodoSyncToolKeyLastUpdateTodoTimeStamp = @"TodoSyncToolKeyLastUpdateTodoTimeStamp";

//数据库路径
#define TODO_DB_DIRECTORYPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/todoDatabaseDirectory"]
//将s转为C字符串
#define STRING(s) #s
//将s转为OC字符串
#define OSTRING(s) [NSString stringWithUTF8String:STRING(s)]


@interface TodoSyncTool()
/// 数据库对象
@property(nonatomic, strong)FMDatabase* db;

/// 是否需要同步(是否需要推送数据给服务器)
@property(nonatomic, assign, readonly)BOOL needSynchronize;

/// 是否修改过(任何的增删改操作都会使这个标记为变成YES)
@property(nonatomic, assign)BOOL isModified;

/// 上次和服务器同步的时间
@property(nonatomic, assign)long lastSyncTimeStamp;

@property(nonatomic, assign, readonly) AFNetworkReachabilityStatus netWorkStatus;

/// 今天23:59的时间戳，重写了getter方法，确保必定指向今天23:59
@property(nonatomic, assign)NSInteger todayEndTimeStamp;

/// 临时存储服务器的同步时间
@property(nonatomic, assign)NSInteger serverTimeStamp;

/// 在获取服务器的同步时间的接口那边确认本地的服务时间存在或不存在后，
/// 会对这个属性进行修改。在lastSyncTimeStamp的set方法里会把这个属性置位YES
@property(nonatomic, assign)BOOL isSyncTimeExist;
@end

//生产环境：https://be-prod.redrock.cqupt.edu.cn/magipoke-todo
//测试环境：https://be-dev.redrock.cqupt.edu.cn/magipoke-todo
@implementation TodoSyncTool
static TodoSyncTool* _instance;

//MARK: +++++++++++++++++++++数据同步的代码++++++++++++++++++++++++++++
/// 调用后触发同步
- (void)syncData {
//    if (self.netWorkStatus!=AFNetworkReachabilityStatusReachableViaWWAN
//        &&self.netWorkStatus!=AFNetworkReachabilityStatusReachableViaWiFi) {
//        TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
//            msg.syncState = TodoSyncStateFailure;
//            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
//        CCLog(@"netWorkError");
//        return;
//    }
    //获取上次同步时间
    
    [HttpTool.shareTool
     request:ToDo_GET_lastSyncTime_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:@{@"sync_time":@(self.lastSyncTimeStamp)}
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        CCLog(@"resp::%@",object);
        NSDictionary *dataDict = object[@"data"];
        if (![object[@"info"] isEqualToString:@"success"] || dataDict==nil || [dataDict isEqualToDictionary:@{}]) {
            TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateUnexpectedError;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
            return;
        }
        long syncTime = [dataDict[@"sync_time"] longValue];
#ifdef DEBUG
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [NewQAHud showHudAtWindowWithStr:[NSString stringWithFormat:@"%ld", syncTime] enableInteract:YES];
        });
#endif
        if ([dataDict[@"is_sync_time_exist"] intValue] == 0 && self.lastSyncTimeStamp != 0) {
            TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateConflict;
            msg.serverLastSyncTime = syncTime;
            msg.clientLastSyncTime = self.lastSyncTimeStamp;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
            self.isSyncTimeExist = NO;
            return;
        }
        self.isSyncTimeExist = YES;
        CCLog(@"%ld, %ld", syncTime, self.lastSyncTimeStamp);
        self.serverTimeStamp = syncTime;
        if (syncTime!=self.lastSyncTimeStamp) {
            //时间不相等，代表需要下载数据
            if (self.needSynchronize) {
                //冲突(即使本地只是新增，也应当视为冲突)，提示用户进行取舍
                TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
                msg.syncState = TodoSyncStateConflict;
                msg.serverLastSyncTime = syncTime;
                msg.clientLastSyncTime = self.lastSyncTimeStamp;
                [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
            }else {
                if (self.lastSyncTimeStamp==0) {
                    //第一次下载数据，然后合并数据（并且不记录修改）
                    [self firstDownload];
                }else{
                    //需要下载数据，然后合并数据（并且不记录修改）
                    [self downloadDataAndMerge];
                }
            }
        }else if (self.needSynchronize) {
            
            if (syncTime==0) {
                CCLog(@"firstPush");
                //服务器没有数据，进行首次推送
                [self firstPush];
                
            }else {
                CCLog(@"Push");
                //需要同步，把离线时的增删该数据推送上去
                [self pushModifiedDataForce:NO];
            }
        }else {
            TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateSuccess;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CCLog(@"error::%@",error);
        TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
        msg.syncState = TodoSyncStateFailure;
        [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
    }];
}

/// 第一次从服务器下载数据
- (void)firstDownload {
    [HttpTool.shareTool
     request:ToDo_GET_firstDownload_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        CCLog(@"resp::%@",object);
        if (![object[@"info"] isEqualToString:@"success"]) {
            TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateFailure;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
            return;
        }
        
        NSDictionary* dataDitc = object[@"data"];
        //增加的序列
        NSArray* changeArr = dataDitc[@"changed_todo_array"];
        TodoDataModel* model = [[TodoDataModel alloc] init];
        for (NSDictionary* todoDict in changeArr) {
            [model setDataWithDict:todoDict];
            [self saveTodoWithModel:model needRecord:NO];
        }
        self.lastSyncTimeStamp = [dataDitc[@"sync_time"] longValue];
        TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
        msg.syncState = TodoSyncStateSuccess;
        [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateFailure;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
        
        
        CCLog(@"error::%@",error);
    }];
}

/// 下载数据，并合并，调用的前提是没有冲突
- (void)downloadDataAndMerge {
    
    [HttpTool.shareTool
     request:ToDo_GET_downloadData_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters: @{@"sync_time":@(self.lastSyncTimeStamp)}
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        CCLog(@"resp::%@", object);
        if (![object[@"info"] isEqualToString:@"success"]) {
            TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateFailure;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
            return;
        }
        NSDictionary* dataDitc = object[@"data"];
        //被删除的序列
        NSArray* deleteArr = dataDitc[@"del_todo_array"];
        //修改序列和增加的序列
        NSArray* changeArr = dataDitc[@"changed_todo_array"];
        for (NSString* todoIDStr in deleteArr) {
            [self deleteTodoWithTodoID:todoIDStr needRecord:NO];
        }
        TodoDataModel* model = [[TodoDataModel alloc] init];
        for (NSDictionary* todoDict in changeArr) {
            [model setDataWithDict:todoDict];
            if ([self isTodoID:model.todoIDStr existsInTable:@"todoTable"]) {
                [self alterTodoWithModel:model needRecord:NO];
            }else {
                [self saveTodoWithModel:model needRecord:NO];
            }
        }
        self.lastSyncTimeStamp = [dataDitc[@"sync_time"] longValue];
        TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
        msg.syncState = TodoSyncStateSuccess;
        [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateFailure;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
        CCLog(@"error::%@",error);
    }];
}

/// 从本地记录修改的逻辑来说，第一次推送修改时，推送的数据必定只有新增事项，所以，不必再调用删除事项的接口
- (void)firstPush {
    NSDictionary* paramDict = @{
        @"data":[self getAllTodoToPush],
        @"sync_time":@(0),
        @"first_push":@(1),
        @"force":@(1)
    };
    
    [HttpTool.shareTool
     request:ToDo_POST_firstPush_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerJSON
     bodyParameters:paramDict
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        CCLog(@"%@", object);
        
        NSString* state = object[@"info"];
        if ([state isEqualToString:@"success"]) {
            self.lastSyncTimeStamp = [object[@"data"][@"sync_time"] longValue];
            [self cleanRecordForTable:@"addTodoIDTable"];
            [self cleanRecordForTable:@"alterTodoIDTable"];
            [self cleanRecordForTable:@"deleteTodoIDTable"];
            self.isModified = NO;
            TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
        msg.syncState = TodoSyncStateSuccess;
        [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
        }else if ([state hasPrefix:@"data"]){
            //"data conflict, and does not indicate to override"
            TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
        msg.syncState = TodoSyncStateFailure;
//            msg.serverLastSyncTime =
        [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateFailure;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
        
        CCLog(@"error::%@",error);
    }];
}

- (void)logMsgWithError:(NSError*)error {
    NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
    CCLog(@"%@, %@", serializedData, error);
}

/// 推送新增和修改的数据
- (void)pushModifiedDataForce:(BOOL)is {
    //在子线程作网络请求，因为有阻塞线程的操作。为什么要使用有阻塞线程的操作？因为看起来优雅一些。
    //为什么不同时进行这两个网络请求？因为会由于时序问题导致self.lastSyncTimeStamp和服务器不一样，而被服务器视为冲突。
    dispatch_queue_t que = dispatch_queue_create("TodoPushModifiedDataQue", DISPATCH_QUEUE_CONCURRENT);
    //使用信号量来化异步为同步
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    //记录网络请求状态的标记
    __block int mark = 0;
    CCLog(@"%d", [FMDatabase isSQLiteThreadSafe]);
    dispatch_async(que, ^{
        NSString *token = [UserItem defaultItem].token;
        NSDictionary* paramDict;
        NSArray *todoDataArr = [self getAddAndAlterDataToPush];
        if (todoDataArr.count!=0) {
            CCLog(@"1start");
            paramDict = @{
                @"data":todoDataArr,
                @"sync_time":@(self.lastSyncTimeStamp),
                @"force":@((int) is)
            };

            [HttpTool.shareTool
             request:ToDo_POST_firstPush_API
             type:HttpToolRequestTypePost
             serializer:HttpToolRequestSerializerJSON
             bodyParameters:paramDict
             progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
                NSString* state = object[@"info"];
                if ([state isEqualToString:@"success"]) {
                    self.lastSyncTimeStamp = [object[@"data"][@"sync_time"] longValue];
                    [self cleanRecordForTable:@"addTodoIDTable"];
                    [self cleanRecordForTable:@"alterTodoIDTable"];
                    mark |= 0b1;
                }else if ([state hasPrefix:@"data"]){
                    mark |= 0b100;
                    //"data conflict, and does not indicate to override"
                }else if ([state hasPrefix:@"the"]){
                    //"the sync_time does not exist"
                    mark |= 0b1000;
                }else if([state hasPrefix:@"unknown"]) {
                    //"unknown error"
                    mark |= 0b10000;
                }
                dispatch_semaphore_signal(sema);
            }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                dispatch_semaphore_signal(sema);
                CCLog(@"error::%@",error);
            }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }else {
            mark |= 0b1;
        }
        
        NSArray * todoDeleteIDArr = [self getDeleteDataToPush];
        if (todoDeleteIDArr.count!=0) {
            CCLog(@"2start");
            paramDict = @{
                @"del_todo_array": todoDeleteIDArr,
                @"sync_time": @(self.lastSyncTimeStamp),
                @"force": @((int) is)
            };
            CCLog(@"%@", paramDict);
            
            
            [HttpTool.shareTool
             request:ToDo_GET_downloadData_API
             type:HttpToolRequestTypeDelete
             serializer:HttpToolRequestSerializerJSON
             bodyParameters:paramDict
             progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
                CCLog(@"resp::%@",object);
                NSString* state = object[@"info"];
                if ([state isEqualToString:@"success"]) {
                    self.lastSyncTimeStamp = [object[@"data"][@"sync_time"] longValue];
                    [self cleanRecordForTable:@"deleteTodoIDTable"];
                    mark |= 0b10;
                }else if ([state hasPrefix:@"data"]){
                    //"data conflict, and does not indicate to override"
                    mark |= 0b100;
                }else if ([state hasPrefix:@"the"]){
                    //"the sync_time does not exist"
                    mark |= 0b1000;
                }else if ([state hasPrefix:@"unknown"]) {
                    //"unknown error"
                    mark |= 0b10000;
                }
                dispatch_semaphore_signal(sema);
            }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                dispatch_semaphore_signal(sema);
                CCLog(@"error::%@",error);
            }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }else {
            mark |= 0b10;
        }
    });
    
    dispatch_barrier_async(que, ^{
        dispatch_async_on_main_queue(^{
            if (mark==0b11) {
                //成功
                self.isModified = NO;
                TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
        msg.syncState = TodoSyncStateSuccess;
        [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
            }else if (mark==(mark|0b100)) {
                //冲突
                TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
                msg.syncState = TodoSyncStateConflict;
                msg.serverLastSyncTime = self.serverTimeStamp;
                msg.clientLastSyncTime = self.lastSyncTimeStamp;
                [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
            }else if (mark==(mark|0b1000)){
                //服务器没有数据
                CCLog(@"服务器还没有同步时间，请使用firstPush方法");
                TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateFailure;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
            }else {
                TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateFailure;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
            }
        });
    });
}

/// 推送数据到服务器成功后调用，用来清除记录
- (void)cleanRecordForTable:(NSString*)tableName {
    NSString* code = OSTRING(
                             DELETE FROM tableName
                             );
    code = [code stringByReplacingOccurrencesOfString:@"tableName" withString:tableName];
    [self.db executeUpdate:code];
}

/// 收到网络状态改变的通知时调用，发送通知的代码在AppDelegate
- (void)netWorkStateChanges:(NSNotification*)noti {
    AFNetworkReachabilityStatus status = [noti.object longValue];
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusReachableViaWiFi:
            [self syncData];
            break;
        default:
            break;
    }
}

/// 强制拉取服务器的数据
- (void)forceLoadServerData {
    //抹除本地修改，再进行同步，性能会更好，但是这样会使结构变得更复杂，所以这里选择重置数据库
    [HttpTool.shareTool
     request:ToDo_GET_firstDownload_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        CCLog(@"resp::%@",object);
        if (![object[@"info"] isEqualToString:@"success"]) {
            TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateFailure;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
            return;
        }
        
        //等网络请求成功后，再抹除本地修改
        [self resetDB];
        self.isModified = NO;
        
        NSDictionary* dataDitc = object[@"data"];
        //增加的序列
        NSArray* changeArr = dataDitc[@"changed_todo_array"];
        TodoDataModel* model = [[TodoDataModel alloc] init];
        for (NSDictionary* todoDict in changeArr) {
            [model setDataWithDict:todoDict];
            [self saveTodoWithModel:model needRecord:NO];
        }
        self.lastSyncTimeStamp = [dataDitc[@"sync_time"] longValue];
        TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
        msg.syncState = TodoSyncStateSuccess;
        [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TodoSyncMsg *msg = [[TodoSyncMsg alloc] init];
            msg.syncState = TodoSyncStateFailure;
            [[NSNotificationCenter defaultCenter] postNotificationName:TodoSyncToolSyncNotification object:msg];
        CCLog(@"error::%@",error);
    }];
}

/// 强制把本地的数据推到服务器
- (void)forcePushLocalData {
    if (self.isSyncTimeExist==YES) {
        [self pushModifiedDataForce:YES];
    }else {
        [self firstPush];
        
        
    }
    
}
//MARK: +++++++++++++++重写的 geter/setter 方法++++++++++++++++++++++
/// 是否需要推送数据给服务器
- (BOOL)needSynchronize {
    //修改过，不代表需要同步，因为用户可能在离线时增加一个事项，再删除同一个事项，此时是不需要同步的。
    //isModified==YES是同步的必要条件，三个记录ID的表是否存在元组是同步的充分必要条件。
    if (self.isModified==NO) {
        return NO;
    }else {
        NSArray* tableNameArr = @[@"addTodoIDTable", @"alterTodoIDTable", @"deleteTodoIDTable"];
        for (NSString* tableName in tableNameArr) {
            if ([self getTupleCntOfTable:tableName]!=0) {
                return YES;
            }
        }
    }
    return NO;
}

/// 网络状态
- (AFNetworkReachabilityStatus)netWorkStatus {
    return [NSUserDefaults.standardUserDefaults integerForKey:@"AFNetworkReachabilityStatus"];
}

- (void)setLastSyncTimeStamp:(long)lastSyncTimeStamp {
    _lastSyncTimeStamp = lastSyncTimeStamp;
    self.isSyncTimeExist = YES;
    [NSUserDefaults.standardUserDefaults setInteger:lastSyncTimeStamp forKey:TodoSyncToolKeyLastSyncTimeStamp];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)setIsModified:(BOOL)isModified {
    _isModified = isModified;
    [NSUserDefaults.standardUserDefaults setBool:isModified forKey:TodoSyncToolKeyIsModified];
    [NSUserDefaults.standardUserDefaults synchronize];
}

//MARK: +++++++++++++++++++++增删改查++++++++++++++++++++++++++++
/// 获取全部事项的结果集
- (FMResultSet*)getAllTodoResultSet {
    NSString* code = OSTRING(
                             SELECT *
                                FROM todoTable
                                ORDER BY last_modify_time DESC
                             );
    FMResultSet* resultSet = [self.db executeQuery:code];
    return resultSet;
}

/// 将结果集转化为模型
- (TodoDataModel*)resultSetToDataModel:(FMResultSet*)resultSet {
    TodoDataModel* model = [[TodoDataModel alloc] init];
    NSString* code;
    model.isPinned = [resultSet boolForColumn:@"is_pinned"];
    model.type = [resultSet stringForColumn:@"type"];
    model.isOvered = [resultSet boolForColumn:@"is_overed"];
    model.endTime = [resultSet stringForColumn:@"end_time"];
    model.todoIDStr = [resultSet stringForColumn:@"todo_id"];
    model.titleStr = [resultSet stringForColumn:@"title"];
    model.detailStr = [resultSet stringForColumn:@"detail"];
    [model setIsDoneForInnerActivity:[resultSet boolForColumn:@"is_done"]];
    model.overdueTime = [resultSet longForColumn:@"overdueTime"];
    model.lastOverdueTime = [resultSet longForColumn:@"lastOverdueTime"];
    model.lastModifyTime = [resultSet longForColumn:@"last_modify_time"];
    
    code = OSTRING(
                   SELECT *
                       FROM remindModeTable
                       WHERE todo_id = ?
                   );
    FMResultSet* subSet = [self.db executeQuery:code withArgumentsInArray:@[model.todoIDStr]];
    if ([subSet next]) {
        model.repeatMode = [subSet longForColumn:@"repeat_mode"];
        model.timeStr = [subSet stringForColumn:@"notify_datetime"];
        switch (model.repeatMode) {
            case TodoDataModelRepeatModeWeek:
                model.weekArr = [self weekStrToWeekArr:[subSet stringForColumn:@"week"]];
                break;
            case TodoDataModelRepeatModeMonth:
                model.dayArr = [self dayStrToDayArr:[subSet stringForColumn:@"day"]];
                break;
            case TodoDataModelRepeatModeYear:
                model.dateArr = [self dateStrToDateArr:[subSet stringForColumn:@"date"]];
                break;
            default:
                break;
        }
    }
    /*
     todo_id TEXT,
     title TEXT,
     detail TEXT,
     is_done INTEGER,
     
     
     id text
     repeat_mode INTEGER,
     week TEXT,
     day TEXT,
     date TEXT,
     
     */
    return model;
}

/// 保存事项数据，由于用户的操作而调用时is填YES，内部合并数据时is填NO
- (void)saveTodoWithModel:(TodoDataModel*)model needRecord:(BOOL)is {
    [model resetOverdueTime:(long)[NSDate date].timeIntervalSince1970];;
    
    //如果提醒时间是今天，那么把todo的状态重置为待完成
    if (self.todayEndTimeStamp-86400 < model.overdueTime&&model.overdueTime <= self.todayEndTimeStamp) {
        [model setIsDoneForInnerActivity:NO];
    }
    
    NSString* code;
    code = OSTRING(
                   INSERT INTO todoTable (todo_id, title, detail, type, is_pinned, is_overed, end_time, is_done, overdueTime, lastOverdueTime, last_modify_time)
                       VALUES
                        (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                   );
    [self.db executeUpdate:code withArgumentsInArray:@[model.todoIDStr, model.titleStr, model.detailStr, model.type, @(model.isPinned), @(model.isOvered), model.endTime, @(model.isDone), @(model.overdueTime), @(model.lastOverdueTime), @(model.lastModifyTime)]];
    
    code = OSTRING(
                   INSERT INTO remindModeTable(todo_id, repeat_mode, week, day, date, notify_datetime)
                       VALUES
                        (?, ?, ?, ?, ?, ?)
                   );
    [self.db executeUpdate:code withArgumentsInArray:@[model.todoIDStr, @(model.repeatMode), [self weekArrToWeekStr:model.weekArr], [self dayArrToDayStr:model.dayArr], [self dateArrToDateStr:model.dateArr], model.timeStr]];
    [TodoDateTool addNotiWithModel:model];
    //记录修改
    if (is) {
        [self recordAddWithTodoID:model.todoIDStr];
        
        self.isModified = YES;
        [self syncData];
    }
}

/// 更新(修改已有的)事项数据，由于用户的操作而调用时is填YES，内部合并数据时is填NO
- (void)alterTodoWithModel:(TodoDataModel*)model needRecord:(BOOL)is {
    NSString* code;
    [model debugLog];
    
    code = OSTRING(
                   SELECT * FROM TodoTable
                       WHERE todo_id = ?
                   );
    FMResultSet* set = [self.db executeQuery:code withArgumentsInArray:@[model.todoIDStr]];
    while ([set next]) {
        [TodoDateTool removeAllNotiInModel:[self resultSetToDataModel:set]];
    }
    
    code = OSTRING(
                      UPDATE remindModeTable
                          SET repeat_mode = ? <
                              date = ? <
                              week = ? <
                              day = ? <
                              notify_datetime = ?
                          WHERE todo_id = ?
                   );
    code = [code stringByReplacingOccurrencesOfString:@"<" withString:@","];
    [self.db executeUpdate:code withArgumentsInArray:@[@(model.repeatMode), [self dateArrToDateStr:model.dateArr], [self weekArrToWeekStr:model.weekArr], [self dayArrToDayStr:model.dayArr], model.timeStr, model.todoIDStr]];
    
    code = OSTRING(
                   UPDATE todoTable
                       SET title = ? <
                           detail = ? <
                           type = ? <
                           is_pinned = ? <
                           is_overed = ? <
                           end_time = ? <
                           is_done = ? <
                       overdueTime = ? <
                       lastOverdueTime = ? <
                       last_modify_time = ?
                   
                       WHERE todo_id = ?
                   );
    code = [code stringByReplacingOccurrencesOfString:@"<" withString:@","];
    [self.db executeUpdate:code withArgumentsInArray:@[model.titleStr, model.detailStr, model.type, @(model.isPinned), @(model.isOvered), model.endTime, @(model.isDone), @(model.overdueTime), @(model.lastOverdueTime), @(model.lastModifyTime), model.todoIDStr]];
    
    //重新添加通知
    [TodoDateTool addNotiWithModel:model];
    
    //记录修改
    if (is) {
        [self recordAlterWithTodoID:model.todoIDStr];
        
        self.isModified = YES;
        [self syncData];
    }
}

/// 删除事项，由于用户的操作而调用时is填YES，内部合并数据时is填NO
- (void)deleteTodoWithTodoID:(NSString*)todoIDStr needRecord:(BOOL)is {
    NSString* code;
    //移除model的全部通知
    code = OSTRING(
                   SELECT * FROM TodoTable
                       WHERE todo_id = ?
                   );
    FMResultSet* set = [self.db executeQuery:code withArgumentsInArray:@[todoIDStr]];
    while ([set next]) {
        [TodoDateTool removeAllNotiInModel:[self resultSetToDataModel:set]];
    }
    
    //在remindModeTable中删除数据
    code = OSTRING(
                    DELETE FROM remindModeTable
                        WHERE todo_id = ?
                    );
    [self.db executeUpdate:code withArgumentsInArray:@[todoIDStr]];
    
    //在todoTable中删除数据
    code = OSTRING(
                   DELETE FROM todoTable
                       WHERE todo_id = ?
                   );
    [self.db executeUpdate:code withArgumentsInArray:@[todoIDStr]];
    
    //记录修改
    if (is) {
        [self recordDeleteWithTodoID:todoIDStr];
        
        self.isModified = YES;
        [self syncData];
    }
}

/// 获取最近创建的3个todo，用来在发现页显示
- (NSArray<TodoDataModel*>*)getTodoForDiscoverMainPage {
    NSMutableArray* resultArr = [NSMutableArray array];
    NSString* code = OSTRING(
                             SELECT *
                                FROM todoTable
                                WHERE is_done = 0
                                ORDER BY last_modify_time DESC
                             );
    FMResultSet* resultSet = [self.db executeQuery:code];
    int cnt = 0;
    while ([resultSet next]) {
        TodoDataModel* model = [self resultSetToDataModel:resultSet];
        if (model.todoState==TodoDataModelStateNeedDone) {
            [resultArr addObject:model];
            cnt++;
        }
        if (cnt==3) {
            break;
        }
    }
    return resultArr;
}

///获取所有的todo模型
- (NSArray<TodoDataModel *> *)getTodoForMainPage{
    NSMutableArray* resultArr = [NSMutableArray array];
    NSString* code = OSTRING(
                             SELECT *
                                FROM todoTable
                                ORDER BY last_modify_time DESC
                             );
    FMResultSet* resultSet = [self.db executeQuery:code];
    while ([resultSet next]) {
        TodoDataModel* model = [self resultSetToDataModel:resultSet];
        [resultArr addObject:model];
    }
    return resultArr;
}

//MARK: +++++++++++++++++++++登录相关的逻辑代码++++++++++++++++++++++++++++
/// 需要在登录成功后调用，
- (void)logInSuccess {
    [self initDataBase];
    [self syncData];
    FMResultSet* resultSet = [self getAllTodoResultSet];
    if (![resultSet hasAnotherRow]) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstVisitToDo"] == nil || [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstVisitToDo"] == YES) {
            [self uploadTips];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirstVisitToDo"];
        }
    }
    dispatch_queue_t que = dispatch_queue_create("登录成功后添加todo通知使用", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(que, ^{
        while ([resultSet next]) {
            TodoDataModel* model = [self resultSetToDataModel:resultSet];
            [TodoDateTool addNotiWithModel:model];
        }
    });
}

/// 需要在退出登录后后调用，
- (void)logOutSuccess {
    dispatch_queue_t que = dispatch_queue_create("退出登录后删除todo通知使用", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(que, ^{
        FMResultSet* resultSet = [self getAllTodoResultSet];
        while ([resultSet next]) {
            TodoDataModel* model = [self resultSetToDataModel:resultSet];
            [TodoDateTool removeAllNotiInModel:model];
        }
    });
}


//MARK: +++++++++++++++++++++一些基础的工具方法++++++++++++++++++++++++++++

- (void)updateTodoState {
//    [NSUserDefaults.standardUserDefaults setInteger:(long)0 forKey:TodoSyncToolKeyLastUpdateTodoTimeStamp];
    
    //状态更新，一天调用一次就好了
    NSInteger lastUpdateTime = [NSUserDefaults.standardUserDefaults integerForKey:TodoSyncToolKeyLastUpdateTodoTimeStamp];
    if (lastUpdateTime > (self.todayEndTimeStamp - 86400)) {
        return;
    }
    [NSUserDefaults.standardUserDefaults setInteger:(long)[NSDate date].timeIntervalSince1970 forKey:TodoSyncToolKeyLastUpdateTodoTimeStamp];
    NSString* code;
    /*
    FMResultSet* set;
    code = OSTRING(
                   SELECT todoTable
                       WHERE overdueTime!=-1 AND overdueTime < ?
                   );
    set = [self.db executeQuery:code withArgumentsInArray:@[@(((long)[NSDate date].timeIntervalSince1970))]];
    while ([set next]) {
        TodoDataModel* model = [self resultSetToDataModel:set];
        //刷新状态
        model.lastOverdueTime = model.overdueTime;
        model.overdueTime = [TodoDateTool getOverdueTimeStampFrom:model.overdueTime inModel:model];
        CCLog(@"%@", model);
    }
    
    
    code = OSTRING(
                   SELECT todo_id
                       FROM todoTable;
                       WHERE  ? <overdueTime AND overdueTime<= ? AND is_done = 1
                   );
    set = [self.db executeQuery:code withArgumentsInArray:@[@(self.todayEndTimeStamp-86400), @(self.todayEndTimeStamp)]];
    while ([set next]) {
        [self recordAlterWithTodoID:[set stringForColumn:@"todo_id"]];
    }
    */
    
    //如果提醒时间是今天，那么把todo的状态重置为待完成
    code = OSTRING(
                   UPDATE todoTable
                       SET is_done = 0
                       WHERE ? <overdueTime AND overdueTime<= ?
                   );
    [self.db executeUpdate:code withArgumentsInArray:@[@(self.todayEndTimeStamp-86400), @(self.todayEndTimeStamp)]];
    
    CCLog(@"\n\ntopush==%@", [self getAllTodoToPush]);
    CCLog(@"\n\nAll==%@", [self getAllTodoResultSet]);
}

/// 检测todoID为 todoIDStr 的元祖是否已经在 tableName 中存在
- (BOOL)isTodoID:(NSString*)todoIDStr existsInTable:(NSString*)tableName {
    NSString* code = OSTRING(
                             SELECT *
                               FROM tableName
                               WHERE todo_id = ?
                 );
    code = [code stringByReplacingOccurrencesOfString:@"tableName" withString:tableName];
    FMResultSet* set = [self.db executeQuery:code withArgumentsInArray:@[todoIDStr]];
    if ([set next]) {
        return YES;
    }else {
        return NO;
    }
}

///@"2.6, 3.5, 8.7" -> @[
///  @{@"TodoDataModelKeyMonth":@"2", TodoDataModelKeyDay:@"6"},
///  @{@"TodoDataModelKeyMonth":@"3", TodoDataModelKeyDay:@"5"},
///  @{@"TodoDataModelKeyMonth":@"8", TodoDataModelKeyDay:@"7"},
///]
- (NSArray<NSDictionary*>*)dateStrToDateArr:(NSString*)str {
    if (str==nil||[str isEqualToString:@""]) {
        return @[];
    }
    NSArray* arr = [str componentsSeparatedByString:@", "];
    NSMutableArray* dateArr = [NSMutableArray arrayWithCapacity:10];
    for (NSString* dateStr in arr) {
        NSArray* temp = [dateStr componentsSeparatedByString:@"."];
        [dateArr addObject:@{
            TodoDataModelKeyMonth:[temp firstObject],
            TodoDataModelKeyDay:[temp lastObject],
        }];
    }
    return dateArr;
}

///@"1, 2, 3, 7" -> @[
/// @"2", @"3", @"4", @"1"
///]
- (NSArray<NSString*>*)weekStrToWeekArr:(NSString*)str {
    if (str==nil||[str isEqualToString:@""]) {
        return @[];
    }
    NSArray* arr = [str componentsSeparatedByString:@", "];
    NSMutableArray* weekArr = [NSMutableArray arrayWithCapacity:3];
    for (NSString* weekStr in arr) {
        [weekArr addObject:[NSString stringWithFormat:@"%d",ChinaWeekToForeignWeek(weekStr.intValue)]];
    }
    return weekArr;
}

//@"1, 2, 3, 4" -> @[@"1", @"2", @"3", @"4"]
- (NSArray<NSString*>*)dayStrToDayArr:(NSString*)str {
    if (str==nil||[str isEqualToString:@""]) {
        return @[];
    }
    return [str componentsSeparatedByString:@", "];
}


///@[
///  @{@"TodoDataModelKeyMonth":@"2", TodoDataModelKeyDay:@"6"},
///  @{@"TodoDataModelKeyMonth":@"3", TodoDataModelKeyDay:@"5"},
///  @{@"TodoDataModelKeyMonth":@"8", TodoDataModelKeyDay:@"7"},
///] -> ///@"2.6, 3.5, 8.7"
- (NSString*)dateArrToDateStr:(NSArray<NSDictionary*>*)arr {
    NSMutableString* str = [[NSMutableString alloc] initWithString:@""];
    for (NSDictionary* dateDict in arr) {
        [str appendFormat:@", %@.%@", dateDict[TodoDataModelKeyMonth], dateDict[TodoDataModelKeyDay]];
    }
    if (str.length==0) {
        return @"";
    }else {
        return [str substringFromIndex:2];
    }
}

///@[
/// @"2", @"3", @"4", @"1"
///] -> @"1, 2, 3, 7"
- (NSString*)weekArrToWeekStr:(NSArray<NSString*>*)arr {
    NSMutableString* str = [[NSMutableString alloc] initWithString:@""];
    for (NSString* weekStr in arr) {
        [str appendFormat:@", %d", ForeignWeekToChinaWeek(weekStr.intValue)];
    }
    if (str.length==0) {
        return @"";
    }else {
        return [str substringFromIndex:2];
    }
}

//@[@"1", @"2", @"3", @"4"] -> @"1, 2, 3, 4"
- (NSString*)dayArrToDayStr:(NSArray<NSString*>*)arr {
    if (arr==nil||[arr isEqualToArray:@[]]) {
        return @"";
    }
    return [arr componentsJoinedByString:@", "];
}

//从[1, 2, ... 7]转化为[2, 3, ... 1]
static inline int ChinaWeekToForeignWeek(int week) {
    return week%7+1;
}
//从[2, 3, ... 1]转化为[1, 2, ... 7]
static inline int ForeignWeekToChinaWeek(int week) {
    return (week+5)%7+1;
}

- (long)getTupleCntOfTable:(NSString*)tableName {
    NSString* code = OSTRING(
                             SELECT COUNT(*)
                                 FROM tableName
                             );
    code = [code stringByReplacingOccurrencesOfString:@"tableName" withString:tableName];
    FMResultSet* set = [self.db executeQuery:code];
    long cnt = 0;
    if ([set next]) {
        cnt = [set longForColumn:@"COUNT(*)"];
    }
    return cnt;
}

/// 获取增加/修改的事项数据来上传
- (NSArray<NSDictionary*>*)getAddAndAlterDataToPush {
    NSString* code = OSTRING(
                             SELECT * FROM TodoTable
                                 WHERE todo_id IN (SELECT todo_id FROM addTodoIDTable UNION SELECT todo_id FROM alterTodoIDTable)
                             );
    FMResultSet* resultSet = [self.db executeQuery:code];
    NSMutableArray<NSDictionary*>* arr = [NSMutableArray arrayWithCapacity:5];
    while ([resultSet next]) {
        [arr addObject:[[self resultSetToDataModel:resultSet] getDataDictToPush]];
    }
    return arr;
}

- (NSArray<NSDictionary*>*)getAllTodoToPush {
    FMResultSet* resultSet = [self getAllTodoResultSet];
    NSMutableArray<NSDictionary*>* arr = [NSMutableArray arrayWithCapacity:5];
    while ([resultSet next]) {
        [arr addObject:[[self resultSetToDataModel:resultSet] getDataDictToPush]];
    }
    return arr;
}

/// 获取被删除的事项ID
- (NSArray<NSNumber*>*)getDeleteDataToPush {
    NSString* code = OSTRING(
                             SELECT * FROM deleteTodoIDTable
                             );
    FMResultSet* resultSet = [self.db executeQuery:code];
    NSMutableArray<NSNumber*>* arr = [NSMutableArray arrayWithCapacity:5];
    while ([resultSet next]) {
        id t = @([resultSet intForColumn:@"todo_id"]);
        CCLog(@"%@", [t class]);
        [arr addObject:t];
    }
    return arr;
}

/// 记录修改
- (void)recordAlterWithTodoID:(NSString*)todoIDStr {
    if (![self isTodoID:todoIDStr existsInTable:@"addTodoIDTable"]&&![self isTodoID:todoIDStr existsInTable:@"alterTodoIDTable"]) {
        NSString* code = OSTRING(
                                 INSERT INTO alterTodoIDTable
                                     VALUES(?)
                                 );
        [self.db executeUpdate:code withArgumentsInArray:@[todoIDStr]];
    }
}
/// 记录增加
- (void)recordAddWithTodoID:(NSString*)todoIDStr {
    NSString* code = OSTRING(
                   INSERT INTO addTodoIDTable
                       VALUES(?)
                   );
    [self.db executeUpdate:code withArgumentsInArray:@[todoIDStr]];
}
/// 记录删除
- (void)recordDeleteWithTodoID:(NSString*)todoIDStr {
    NSString* code;
    if ([self isTodoID:todoIDStr existsInTable:@"addTodoIDTable"]) {
        code = OSTRING(
                       DELETE FROM addTodoIDTable
                           WHERE todo_id = ?
                       );
        [self.db executeUpdate:code withArgumentsInArray:@[todoIDStr]];
    }else if([self isTodoID:todoIDStr existsInTable:@"alterTodoIDTable"]) {
        code = OSTRING(
                       DELETE FROM alterTodoIDTable
                           WHERE todo_id = ?
                       );
        [self.db executeUpdate:code withArgumentsInArray:@[todoIDStr]];
    }else {
        code = OSTRING(
                       INSERT INTO deleteTodoIDTable
                           VALUES(?)
                       );
        [self.db executeUpdate:code withArgumentsInArray:@[todoIDStr]];
    }
}

//MARK: +++++++++++++++++++++初始化相关++++++++++++++++++++++++++++
+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:nil] init];
        [_instance initDataBase];
        _instance->_lastSyncTimeStamp = [NSUserDefaults.standardUserDefaults integerForKey:TodoSyncToolKeyLastSyncTimeStamp];
        _instance.isModified = [NSUserDefaults.standardUserDefaults boolForKey:TodoSyncToolKeyIsModified];
        [[NSNotificationCenter defaultCenter] addObserver:_instance selector:@selector(netWorkStateChanges:) name:@"AFNetworkReachabilityStatusChanges" object:nil];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self share];
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

/// 初始化数据库，如果数据库已经存在，那么什么事都不会做
- (void)initDataBase {
    NSString* stuNum = [UserItem defaultItem].stuNum;
    if ([stuNum isEqualToString:@""]||stuNum==nil) {
        [NewQAHud showHudAtWindowWithStr:@"登录已过期，请重新登录" enableInteract:YES];
        return;
    }
    
    //创建目录
    if (![[NSFileManager defaultManager] fileExistsAtPath:TODO_DB_DIRECTORYPATH]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:TODO_DB_DIRECTORYPATH withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString* dbPath = [TODO_DB_DIRECTORYPATH stringByAppendingPathComponent:stuNum];
    CCLog(@"todo数据库路径为%@", dbPath);
    self.db = [[FMDatabase alloc] initWithPath:dbPath];
    if ([self.db open]) {
        [self creatTodoTable];
        [_instance updateTodoState];
        CCLog(@"todo数据库打开成功");
    }else {
        CCLog(@"todo数据库打开失败");
    }
    
}

/// 建表
- (void)creatTodoTable {
    
    NSString *checkColumnQuery = @"PRAGMA table_info(todoTable);";
    FMResultSet *resultSet = [self.db executeQuery:checkColumnQuery];
    BOOL typeExists = NO;
    BOOL isPinnedExists = NO;
    BOOL isOveredExists = NO;
    BOOL endTimeExists = NO;
    while ([resultSet next]) {
        NSString *columnName = [resultSet stringForColumn:@"name"];
        if ([columnName isEqualToString:@"type"]) {
            typeExists = YES;
        }
        if ([columnName isEqualToString:@"is_pinned"]) {
            isPinnedExists = YES;
        }
        if ([columnName isEqualToString:@"is_overed"]) {
            isOveredExists = YES;
        }
        if ([columnName isEqualToString:@"end_time"]) {
            endTimeExists = YES;
        }
        if (typeExists && isPinnedExists && isOveredExists && endTimeExists) {
            break;
        }
    }
    
    [resultSet close];

    if (!typeExists) {
        NSString *alterTypeColumnQuery = @"ALTER TABLE todoTable ADD COLUMN type TEXT;";
        [self.db executeUpdate:alterTypeColumnQuery];
    }
    if (!isPinnedExists) {
        NSString *alterIsPinColumnQuery = @"ALTER TABLE todoTable ADD COLUMN is_pinned INTEGER;";
        [self.db executeUpdate:alterIsPinColumnQuery];
    }
    if (!isOveredExists) {
        NSString *alterIsOverColumnQuery = @"ALTER TABLE todoTable ADD COLUMN is_overed INTEGER;";
        [self.db executeUpdate:alterIsOverColumnQuery];
    }
    if (!endTimeExists) {
        NSString *alterEndTimeColumnQuery = @"ALTER TABLE todoTable ADD COLUMN end_time TEXT;";
        [self.db executeUpdate:alterEndTimeColumnQuery];
    }
    
    NSString* code = OSTRING(
                             CREATE TABLE IF NOT EXISTS
                                todoTable (
                                               todo_id TEXT not null,
                                               title TEXT,
                                               detail TEXT,
                                               type TEXT,
                                               is_pinned INTEGER,
                                               is_overed INTEGER,
                                               end_time TEXT,
                                               is_done INTEGER,
                                               overdueTime INTEGER,
                                               lastOverdueTime INTEGER,
                                               last_modify_time INTEGER,
                                               
                                               PRIMARY KEY(todo_id)
                                           )
                             );
    [self.db executeUpdate:code];
    
    code = OSTRING(
                   CREATE TABLE IF NOT EXISTS
                    remindModeTable (
                                         todo_id text not null,
                                         repeat_mode INTEGER,
                                         date TEXT,
                                         week TEXT,
                                         day TEXT,
                                         notify_datetime TEXT,
                                         
                                         FOREIGN KEY(todo_id) REFERENCES todoTable(todo_id)
                                     )
                   );
    [self.db executeUpdate:code];
    
    
    code = OSTRING(
                   CREATE UNIQUE INDEX IF NOT EXISTS todoTable_todo_id ON todoTable(todo_id)
                   );
    [self.db executeUpdate:code];
    
    code = OSTRING(
                   CREATE TABLE IF NOT EXISTS
                       addTodoIDTable(
                                      todo_id text not null,
                                      FOREIGN KEY(todo_id) REFERENCES todoTable(todo_id)
                                      )
                   );
    [self.db executeUpdate:code];
    
    code = OSTRING(
                   CREATE TABLE IF NOT EXISTS
                       deleteTodoIDTable(
                                      todo_id text not null,
                                      FOREIGN KEY(todo_id) REFERENCES todoTable(todo_id)
                                      )
                   );
    [self.db executeUpdate:code];
    
    code = OSTRING(
                   CREATE TABLE IF NOT EXISTS
                       alterTodoIDTable(
                                      todo_id text not null,
                                      FOREIGN KEY(todo_id) REFERENCES todoTable(todo_id)
                                      )
                   );
    [self.db executeUpdate:code];
}

/// 今天23:59的时间戳
- (NSInteger)todayEndTimeStamp {
    if (_todayEndTimeStamp < [NSDate date].timeIntervalSince1970) {
        NSDate* nowDate = [NSDate date];
        NSDateComponents* components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:nowDate];
        _instance.todayEndTimeStamp = nowDate.timeIntervalSince1970 - (((components.hour*60)+components.minute)*60+components.second) + 86399;
    }
    return _todayEndTimeStamp;
}

//MARK: +++++++++++++++++++++测试时会用到的方法++++++++++++++++++++++++++++
- (void)logTodoTable {
    NSString* code;
    code = OSTRING(
                   SELECT *
                       FROM todoTable
                   );
    FMResultSet* set = [self.db executeQuery:code];
    while ([set next]) {
        NSString* todo_id = [set stringForColumn:@"todo_id"];
        NSString* title = [set stringForColumn:@"title"];
        NSString* detail = [set stringForColumn:@"detail"];
        NSString* type = [set stringForColumn:@"type"];
        NSInteger is_pinned = [set longForColumn:@"is_pinned"];
        NSInteger is_overed = [set longForColumn:@"is_overed"];
        NSString* end_time = [set stringForColumn:@"end_time"];
        NSInteger is_done = [set longForColumn:@"is_done"];
        NSInteger overdueTime = [set longForColumn:@"overdueTime"];
        NSInteger lastOverdueTime = [set longForColumn:@"lastOverdueTime"];
        NSInteger last_modify_time = [set longForColumn:@"last_modify_time"];
        CCLog(@"%@, %@, %@, %@, %ld, %ld, %@, %ld, %ld, %ld, %ld", todo_id, title, detail, type, is_pinned, is_overed, end_time,is_done, overdueTime, lastOverdueTime, last_modify_time);
    }
    /*
     todo_id TEXT,
     title TEXT,
     detail TEXT,
     is_done INTEGER,
     */
}

- (void)logRemindModeTable {
    NSString* code;
    code = OSTRING(
                   SELECT *
                       FROM remindModeTable
                   );
    FMResultSet* set = [self.db executeQuery:code];
    while ([set next]) {
        NSString* ID = [set stringForColumn:@"ID"];
        NSInteger repeat_mode = [set longForColumn:@"repeat_mode"];
        NSString* week = [set stringForColumn:@"week"];
        NSString* day = [set stringForColumn:@"day"];
        NSString* date = [set stringForColumn:@"date"];
        NSString* time = [set stringForColumn:@"notify_datetime"];
        CCLog(@"%@, %ld, %@, %@, %@, %@", ID, repeat_mode, week, day, date, time);
    }
    /*
     todo_id text,
     repeat_mode INTEGER,
     week TEXT,
     day TEXT,
     date TEXT,
     */
}

- (void)logTodoData {
    NSString* code = OSTRING(
                             SELECT *
                                FROM todoTable
                             );
    FMResultSet* resultSet = [self.db executeQuery:code];
    while ([resultSet next]) {
        TodoDataModel* model = [self resultSetToDataModel:resultSet];
        CCLog(@"%@", model);
    }
    
    /*
     todo_id TEXT,
     title TEXT,
     detail TEXT,
     is_done INTEGER,
     
     
     id text
     repeat_mode INTEGER,
     week TEXT,
     day TEXT,
     date TEXT,
     
     */
}

- (void)dropTable:(NSString*)tableName {
    NSString* code = OSTRING(
                             DROP TABLE IF EXISTS tableName
                             );
    code = [code stringByReplacingOccurrencesOfString:@"tableName" withString:tableName];
    [self.db executeUpdate:code];
}

- (void)resetDB {
    //得先删除其他的，再删除todoTable，不然可能有约束报错
    NSArray* tableNameArr = @[@"remindModeTable", @"addTodoIDTable", @"alterTodoIDTable", @"deleteTodoIDTable", @"todoTable"];
    for (NSString* tableName in tableNameArr) {
        [self dropTable:tableName];
    }
    [self initDataBase];
}

- (void)logRecordDataWithTableName:(NSString*)tableName {
    NSString* code;
    FMResultSet* set;
    code = OSTRING(
                   SELECT *
                       FROM tableName
                   );
    code = [code stringByReplacingOccurrencesOfString:@"tableName" withString:tableName];
    set = [self.db executeQuery:code];
    CCLog(@"%@",tableName);
    while ([set next]) {
        NSString* todoID = [set stringForColumn:@"todo_id"];
        CCLog(@"%@",todoID);
    }
}

// 添加两条提示
- (void)uploadTips {
    // 创建第一个 TodoDataModel 实例
    TodoDataModel *modelSecond = [[TodoDataModel alloc] init];
    modelSecond.todoIDStr = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970] + 1)];
    modelSecond.titleStr = @"左滑可置顶或删除";
    [modelSecond resetOverdueTime:[NSDate nowTimestamp]];
    modelSecond.lastModifyTime = (NSInteger)[[NSDate date] timeIntervalSince1970] + 1;
    [self saveTodoWithModel:modelSecond needRecord:YES];
    
    // 创建第二个 TodoDataModel 实例
    TodoDataModel *modelThird = [[TodoDataModel alloc] init];
    modelThird.todoIDStr = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970] + 2)];
    modelThird.titleStr = @"点击查看待办详情";
    [modelThird resetOverdueTime:[NSDate nowTimestamp]];
    modelThird.lastModifyTime = (NSInteger)[[NSDate date] timeIntervalSince1970] + 2;
    [self saveTodoWithModel:modelThird needRecord:YES];
}

@end

/*
 一点点使用数据库的心得：
    1. 感觉在表名、列名前面或者后面加个前缀会比较好，方便全局替换、搜索。没加标识容易定位到其他东西的名字
 
 */
