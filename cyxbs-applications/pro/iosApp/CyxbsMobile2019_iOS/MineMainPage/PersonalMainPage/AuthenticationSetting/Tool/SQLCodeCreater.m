//
//  SQLCodeCreater.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/11/3.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "SQLCodeCreater.h"
//https://www.runoob.com/sqlite/sqlite-data-types.html
SQLPropertyType SQLPropertyTypeString = @"TEXT";
SQLPropertyType SQLPropertyTypeInt = @"INTEGER";
SQLPropertyType SQLPropertyTypeDouble = @"REAL";
SQLPropertyType SQLPropertyTypeBlob = @"BLOB";

////NULL INTEGER REAL TEXT BLOB
@implementation SQLCodeCreater

+ (NSString*)createTable:(NSString*)tableName withPropertyDict:(nullable NSDictionary<SQLPropertyType, NSArray<NSString*>*>*) propertyDict restrainStrArr:(nullable NSArray<NSString*>*)rstrnStrArr {
    NSMutableString *code = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (\n\t", tableName];
    NSString *separatorStr = @",\n\t";
    __block BOOL hasPrpty = NO;
    [propertyDict enumerateKeysAndObjectsUsingBlock:^(SQLPropertyType  _Nonnull prptyType, NSArray<NSString *> * _Nonnull prptyArr, BOOL * _Nonnull stop) {
        hasPrpty |= (prptyArr.count!=0);
        for (NSString *propertyName in prptyArr) {
            [code appendFormat:@"%@ %@%@", propertyName, prptyType, separatorStr];
        }
    }];
    
    if (rstrnStrArr) {
        [code appendString:@"\n\t"];
        for (NSString *rstrnStr in rstrnStrArr) {
            [code appendFormat:@"%@%@", rstrnStr, separatorStr];
        }
    }
    if (hasPrpty) {
        [code deleteCharactersInRange:NSMakeRange(code.length-separatorStr.length, separatorStr.length)];
    }
    [code appendString:@"\n)"];
    return code;
}

+ (NSString*)insertTable:(NSString*)tableName withPropertyNameArr:(NSArray <NSString*>*)prptyArr {
    NSMutableString *code = [NSMutableString stringWithFormat:@"INSERT INTO %@ (", tableName];
    NSMutableString *tail = [NSMutableString stringWithString:@") VALUES ("];
    NSString *separator = @", ";
    for (NSString *prptyName in prptyArr) {
        [code appendFormat:@"%@%@", prptyName, separator];
        [tail appendFormat:@"?%@", separator];
    }
    [code deleteCharactersInRange:NSMakeRange(code.length-separator.length, separator.length)];
    [tail deleteCharactersInRange:NSMakeRange(tail.length-separator.length, separator.length)];
    [tail appendString:@")"];
    [code appendString:tail];
    return code;
}
@end
