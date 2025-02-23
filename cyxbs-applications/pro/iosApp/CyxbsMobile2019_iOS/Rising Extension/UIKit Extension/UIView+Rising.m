//
//  UIView+Rising.m
//  Rising
//
//  Created by SSR on 2022/9/17.
//

#import "UIView+Rising.h"

@implementation UIView (Rising)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)SuperLeft {
    return 0;
}

- (CGFloat)SuperTop {
    return 0;
}

- (CGFloat)SuperRight {
    return self.frame.size.width;
}

- (CGFloat)SuperBottom {
    return self.frame.size.height;
}

- (CGPoint)SuperOrigin {
    return CGPointMake(0, 0);
}

- (CGPoint)SuperCenter {
    return CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

- (CGRect)SuperFrame {
    return CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
