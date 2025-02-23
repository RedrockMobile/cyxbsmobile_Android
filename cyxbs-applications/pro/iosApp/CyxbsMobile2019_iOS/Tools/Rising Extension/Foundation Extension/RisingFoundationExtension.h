//
//  RisingFoundationExtension.h
//  Rising
//
//  Created by SSR on 2022/7/1.
//

#import <Foundation/Foundation.h>

#import "NSDate+Rising.h"

#ifndef RisingFoundationExtension_h
#define RisingFoundationExtension_h

#pragma mark - RisingLog

FOUNDATION_EXPORT void RisingDetailLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2) NS_NO_TAIL_CALL;

#define RisingLog(Emoji, format, ...) RisingDetailLog(@"%@ %s %@", ((__bridge NSString *)CFSTR(#Emoji)), __func__, [NSString stringWithFormat:format, ##__VA_ARGS__]);

#endif /* RisingFoundationExtention_h */
