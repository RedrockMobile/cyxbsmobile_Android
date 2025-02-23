//
//  RisingUIKitExtension.h
//  Rising
//
//  Created by SSR on 2022/7/11.
//

#if __has_include(<UIKit/UIKit.h>)
#import <UIKit/UIKit.h>

#ifndef RisingUIKitExtension_h
#define RisingUIKitExtension_h

#import "UIView+Rising.h"

#import "UIColor+Rising.h"

#import <YYKit/UIImage+YYAdd.h>

// UICollectionElementKind

FOUNDATION_EXPORT NSString *const UICollectionElementKindSectionLeading API_AVAILABLE(ios(6.0));

FOUNDATION_EXPORT NSString *const UICollectionElementKindSectionTrailing API_AVAILABLE(ios(6.0));

FOUNDATION_EXPORT NSString *const UICollectionElementKindSectionPlaceholder API_AVAILABLE(ios(6.0));

FOUNDATION_EXPORT CGFloat StatusBarHeight(void);

#endif /* RisingUIKitExtention_h */

#endif
