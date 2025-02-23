//
//  TodoSyncTool.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/8/15.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TodoDataModel.h"
#import <FMDB/FMDB.h>
#import "TodoSyncMsg.h"

NS_ASSUME_NONNULL_BEGIN

//同步完成后的发送的通知的名字
FOUNDATION_EXPORT NSNotificationName const TodoSyncToolSyncNotification;

//通知的object有下面3种，分别代表成功、失败、冲突
//FOUNDATION_EXPORT NSString* const TodoSyncToolSyncNotificationSuccess;
//FOUNDATION_EXPORT NSString* const TodoSyncToolSyncNotificationFailure;
//FOUNDATION_EXPORT NSString* const TodoSyncToolSyncNotificationConflictl;


/// todo那边数据存取、同步的工具类
@interface TodoSyncTool : NSObject

/// 单例的同步工具的创建方
+ (instancetype)share;

/// 调用后触发同步
- (void)syncData;
//MARK: - todo的增删改方法：
///对下面三个变化的方法说明：如果需要将此的变化和服务器同步，那么is填YES。
///如：由于用户的操作而调用时is填YES，内部合并数据时is填NO。
/// 保存事项数据，
- (void)saveTodoWithModel:(TodoDataModel*)model needRecord:(BOOL)is;
/// 更新(修改已有的)事项数据，
- (void)alterTodoWithModel:(TodoDataModel*)model needRecord:(BOOL)is;
/// 删除事项
- (void)deleteTodoWithTodoID:(NSString*)todoIDStr needRecord:(BOOL)is;

/// 获取最近创建的4个未完成的todo，用来在发现页显示
- (NSArray<TodoDataModel*>*)getTodoForDiscoverMainPage;

///获取所有的todo，用来展示在展览页面 （注意，这里一次性获取全部的结果集对性能有一些影响，不够优雅，
///后面的学弟学妹如果优化代码可以考虑一下MJRefresging的刷新机制）
- (NSArray<TodoDataModel*>*)getTodoForMainPage;


/// 获取全部事项的结果集
//- (FMResultSet*)getAllTodoResultSet;

/// 将todoTable查询的结果集转化为模型
- (TodoDataModel*)resultSetToDataModel:(FMResultSet*)resultSet;

//几个测试用的API
/// 打印TodoTable
- (void)logTodoTable;

/// 打印RemindModeTable
- (void)logRemindModeTable;

/// 打印todo的所有数据
- (void)logTodoData;

/// 打印三个记录表时使用
- (void)logRecordDataWithTableName:(NSString*)tableName;
/// 内部是先删除todo相关的表，再重建表，可以把数据库重置
- (void)resetDB;

/// 需要在登录成功后调用，
- (void)logInSuccess;

/// 需要在退出登录后后调用，
- (void)logOutSuccess;

/// 强制拉取服务器的数据
- (void)forceLoadServerData;

/// 强制把本地的数据推到服务器
- (void)forcePushLocalData;
@end

NS_ASSUME_NONNULL_END

/*
 同步数据的时机：
 ①增删改数据后自动触发一次同步。
 ②进入App后自动触发一次，如果同步成功，结束同步。如果不成功后续每隔一段时间自动同步一次。
 
 同步回调：
 不打算采用代理，代理只能设置一个，感觉会有多个对象需要接受回调，代理数组感觉很奇怪，采用通知中心。
 
 */

/*
 
 需要移到pch的：
 TodoDataModelRepeatMode
 各种常量key
 url
 */
