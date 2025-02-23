//
//  RedTipBall.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/2/22.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 显示消息数的点，外界可以设置这个类的backgroundColor，默认粉红色。
@interface MineMsgCntView : UIView
@property(nonatomic, copy)NSString *msgCount;
//- (instancetype)initWithOriginCenter:(CGPoint) originCenter;
@end

NS_ASSUME_NONNULL_END
