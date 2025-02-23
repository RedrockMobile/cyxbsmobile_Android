//
//  SQLCodeCreater.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/11/3.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString* const SQLPropertyType;
////NULL INTEGER REAL TEXT BLOB

//代表 字符串 的键
extern SQLPropertyType SQLPropertyTypeString;
//代表 整型 的键
extern SQLPropertyType SQLPropertyTypeInt;
//代表 浮点数 的键
extern SQLPropertyType SQLPropertyTypeDouble;
//代表 二进制数据 的键
extern SQLPropertyType SQLPropertyTypeBlob;

@interface SQLCodeCreater : NSObject

/// 获取建表的代码：
/// @param tableName 表名
/// @param propertyDict 表的属性字典，其中键为必须为上面定义好的 SQLPropertyType 常量
/// @param rstrnStrArr 约束数组
+ (NSString*)createTable:(NSString*)tableName withPropertyDict:(nullable NSDictionary<SQLPropertyType, NSArray<NSString*>*>*) propertyDict restrainStrArr:(nullable NSArray<NSString*>*)rstrnStrArr;

+ (NSString*)insertTable:(NSString*)tableName withPropertyNameArr:(NSArray <NSString*>*)prptyArr;
@end

NS_ASSUME_NONNULL_END


