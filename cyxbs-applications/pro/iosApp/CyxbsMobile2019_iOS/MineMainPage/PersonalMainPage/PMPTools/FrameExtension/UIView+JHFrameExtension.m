//
//  UIView+JHFrame.m
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/9/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "UIView+JHFrameExtension.h"

@implementation UIView (JHFrameExtension)

// jh_origin
- (void)setJh_origin:(CGPoint)jh_origin {
    CGRect frame = self.frame;
    frame.origin = jh_origin;
    self.frame = frame;
}
- (CGPoint)jh_origin {
    return self.frame.origin;
}
// jh_origin.x
- (void)setJh_x:(CGFloat)jh_x {
    CGRect frame = self.frame;
    frame.origin.x = jh_x;
    self.frame = frame;
}
- (CGFloat)jh_x {
    return self.frame.origin.x;
}
// jh_origin.y
- (void)setJh_y:(CGFloat)jh_y {
    CGRect frame = self.frame;
    frame.origin.y = jh_y;
    self.frame = frame;
}
- (CGFloat)jh_y {
    return self.frame.origin.y;
}

// jh_size
- (void)setJh_size:(CGSize)jh_size {
    CGRect frame = self.frame;
    frame.size = jh_size;
    self.frame = frame;
}
- (CGSize)jh_size {
    return self.frame.size;
}
// jh_size.width
- (void)setJh_width:(CGFloat)jh_width {
    CGRect frame = self.frame;
    frame.size.width = jh_width;
    self.frame = frame;
}
- (CGFloat)jh_width {
    return self.frame.size.width;
}
// jh_size.height
- (void)setJh_height:(CGFloat)jh_height {
    CGRect frame = self.frame;
    frame.size.height = jh_height;
    self.frame = frame;
}
- (CGFloat)jh_height {
    return self.frame.size.height;
}

- (CGFloat)jh_maxX {
    return self.jh_x + self.jh_width;
}
- (CGFloat)jh_maxY {
    return self.jh_y + self.jh_height;
}

@end
