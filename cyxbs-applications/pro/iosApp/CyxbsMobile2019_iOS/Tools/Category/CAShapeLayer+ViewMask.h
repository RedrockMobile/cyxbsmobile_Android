//
//  CAShapeLayer+ViewMask.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/28.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (ViewMask)
+ (instancetype)createMaskLayerWithView : (UIView *)view;
@end
