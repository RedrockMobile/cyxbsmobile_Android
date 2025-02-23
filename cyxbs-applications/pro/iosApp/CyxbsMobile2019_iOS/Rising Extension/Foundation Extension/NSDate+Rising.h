//
//  NSDate+Rising.h
//  ByteDanceCampus_Weather
//
//  Created by SSR on 2022/7/28.
//

#import <Foundation/Foundation.h>

#if __has_include(<YYKit/NSDate+YYAdd.h>)
#import <YYKit/NSDate+YYAdd.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSTimeZone (Rising)

/// Asia/Chongqing
@property(nonatomic, readonly, class) NSTimeZone *CQ;

@end

@interface NSLocale (Rising)

/// CN
@property(nonatomic, readonly, class) NSLocale *CN;

@end


NS_ASSUME_NONNULL_END
