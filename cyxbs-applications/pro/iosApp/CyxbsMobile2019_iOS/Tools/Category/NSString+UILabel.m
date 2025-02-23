//
//  NSString+UILabel.m
//  SSRSwipe
//
//  Created by SSR on 2022/4/21.
//

#import "NSString+UILabel.h"

@implementation NSString (UILabel)

- (CGFloat)heightForSize:(CGSize)size
                     font:(UIFont *)font {
    CGRect rect =
    [self
     boundingRectWithSize:size
     options:NSStringDrawingUsesFontLeading |
             NSStringDrawingUsesLineFragmentOrigin |
             NSStringDrawingTruncatesLastVisibleLine
     attributes:@{
        NSFontAttributeName : font
     }
     context:nil];
    
    return rect.size.height;
}

@end
