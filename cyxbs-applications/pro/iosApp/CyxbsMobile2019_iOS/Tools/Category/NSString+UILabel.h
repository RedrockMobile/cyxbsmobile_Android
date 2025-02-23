//
//  NSString+UILabel.h
//  SSRSwipe
//
//  Created by SSR on 2022/4/21.
//

#import <UIKit/NSStringDrawing.h>

NS_ASSUME_NONNULL_BEGIN

@class UILabel;

@interface NSString (UILabel)

- (CGFloat)heightForSize:(CGSize)size
                    font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
