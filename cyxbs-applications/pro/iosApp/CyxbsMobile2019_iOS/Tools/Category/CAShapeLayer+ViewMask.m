//
//  CAShapeLayer+ViewMask.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/28.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "CAShapeLayer+ViewMask.h"

@implementation CAShapeLayer (ViewMask)

+ (instancetype)createMaskLayerWithView : (UIView *)view{
    
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    
    CGFloat topSpace = 5.;
    
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth, 0);
    CGPoint point3 = CGPointMake(viewWidth, viewHeight-topSpace);
    CGPoint point4 = CGPointMake(viewWidth/2+5, viewHeight-topSpace);
    CGPoint point5 = CGPointMake(viewWidth/2-5, viewHeight);
    CGPoint point6 = CGPointMake(viewWidth/2-5, viewHeight-topSpace);
    CGPoint point7 = CGPointMake(0, viewHeight-topSpace);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    return layer;
}

@end
