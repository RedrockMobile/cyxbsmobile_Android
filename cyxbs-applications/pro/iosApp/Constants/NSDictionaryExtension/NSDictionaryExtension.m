//
//  NSDictionaryExtension.m
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2024/3/11.
//  Copyright © 2024 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryExtension.h"

@implementation NSDictionary (CyxbsExtension)

- (NSInteger)cm_integerValueForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value integerValue];
    } else {
        return 0;
    }
}

- (int)cm_intValueForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    } else {
        return 0;
    }
}


- (long long)cm_longlongValueForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    } else {
        return 0;
    }
}

- (BOOL)cm_boolValueForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value boolValue];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString *string = [(NSString *)value lowercaseString];
        if ([string isEqualToString:@"true"] || [string isEqualToString:@"yes"] || [string isEqualToString:@"1"]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (float)cm_floatValueForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    } else {
        return 0;
    }
}

- (NSNumber *)cm_nsNumberValueForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)value;
    } else if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        NSNumber *number = [formatter numberFromString:(NSString *)value];
        if (number != nil) {
            return number;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (NSString *)cm_stringValueForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    } else {
        return @"";
    }
}

- (NSArray *)cm_arrayValueForKey:(id)key {
    id value = [self objectForKey:key];
    if(![value isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return value;
}

- (NSMutableArray*)cm_mutableArrayValueForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if(![value isKindOfClass:[NSMutableArray class]]) {
        return nil;
    }
    return value;
}

- (NSDictionary *)cm_dictionaryValueForKey:(id)key {
    id value = [self objectForKey:key];
    if(![value isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return value;
}

#pragma mark - 辅助方法

//判断是否null
- (BOOL)isNullValue:(id)value {
    return [value isEqual:[NSNull null]];
}
@end
