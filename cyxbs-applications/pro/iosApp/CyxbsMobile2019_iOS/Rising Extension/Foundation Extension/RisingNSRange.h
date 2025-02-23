//
//  RisingNSRange.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/21.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/NSRange.h>

#ifndef RisingNSRange_h
#define RisingNSRange_h

NS_INLINE bool NSRangeContainsRange(NSRange range1, NSRange range2) {
    return NSMaxRange(range1) > range2.location;
}

NS_INLINE bool NSRangeIntersectsRange(NSRange range1, NSRange range2) {
    return range2.location >= range1.location && NSMaxRange(range2) <= NSMaxRange(range1);
}

#endif /* RisingNSRange_h */
