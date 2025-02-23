//
//  NSDictionaryExtension.h
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2024/3/11.
//  Copyright © 2024 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CyxbsExtension)

/**
 从字典里取NSInteger(空则返回0)

 @param key 字典Key值
 @return NSInteger(若出现key对应键值非NSNumber类或非纯数字NSString，则返回0)
 */
- (NSInteger)cm_integerValueForKey:(id)key;

/**
 从字典里取int(空则返回0)
 
 @param key 字典Key值
 @return int
 */
- (int)cm_intValueForKey:(id)key;

/**
 从字典里取long long(空则返回0)
 
 @param key 字典Key值
 @return long long
 */
- (long long)cm_longlongValueForKey:(id)key;

/**
 从字典里取BOOL(空则返回NO)
 
 @param key 字典Key值
 @return BOOL
 */
- (BOOL)cm_boolValueForKey:(id)key;

/**
 从字典里取float(空则返回0)
 
 @param key 字典Key值
 @return float
 */
- (float)cm_floatValueForKey:(id)key;

/**
 从字典里取NSNumber(空则返回0)
 
 @param key 字典Key值
 @return NSNumber
 */

- (NSNumber *)cm_nsNumberValueForKey:(id)key;

/**
 从字典里取字符串(空则返回@"")
 
 @param key 字典Key值
 @return NSString
 */
- (NSString *)cm_stringValueForKey:(id)key;

/**
 从字典里取数组(空则返回nil)
 
 @param key 字典Key值
 @return NSArray
 */
- (NSArray *)cm_arrayValueForKey:(id)key;

/**
 从字典里取可变数组(空则返回nil)
 
 @param key 字典Key值
 @return NSMutableArray
 */
- (NSMutableArray *)cm_mutableArrayValueForKey:(NSString *)key;

/**
 从字典里取字典(空则返回nil)
 
 @param key 字典Key值
 @return NSDictionary
 */
- (NSDictionary *)cm_dictionaryValueForKey:(id)key;

@end
