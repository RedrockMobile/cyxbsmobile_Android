//
//  XBSBugly.h
//  XBSBugly
//
//  Created by SSR on 2024/9/11.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const XBSBuglyAppID;

FOUNDATION_EXPORT NSString * const XBSBuglyAppKey;

@interface XBSBugly : NSObject

+ (void)buglyInit;

@end

