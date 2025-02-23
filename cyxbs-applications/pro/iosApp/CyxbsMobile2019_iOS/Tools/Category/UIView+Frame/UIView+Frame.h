//
//  UIView+Frame.h
//  Encapsulation
//
//  Created by SSR on 2022/1/24.
//

/**UIView (Frame)
 * "UIView+Frame.h"
 * frame简单设置和读取
 * strech拉伸的方法
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - UIView (Frame)

/**Frame扩展
 * 将采用Frame的数据
 * 可以直接赋值和取值
 */

@interface UIView (Frame)

// origin

/**frame.origin.x*/
@property (nonatomic, assign) CGFloat x;

/**frame.origin.y*/
@property (nonatomic) CGFloat y;

/**frame.origin*/
@property (nonatomic) CGPoint origin;

/**frame.origin += point*/
- (void)originAddPoint:(CGPoint)point;

/**frame.origin -= point*/
- (void)originMinusPoint:(CGPoint)point;

// size

/**frame.size.width*/
@property (nonatomic) CGFloat width;

/**frame.size.height*/
@property (nonatomic) CGFloat height;

/**frame.size*/
@property (nonatomic) CGSize size;

// center

/**center.x*/
@property (nonatomic) CGFloat centerX;

/**center.y*/
@property (nonatomic) CGFloat centerY;

/**center += point*/
- (void)centerAddPoint:(CGPoint)point;

/**center -= point*/
- (void)centerMinusPoint:(CGPoint)point;

// other

/**frame.origin.x*/
@property (nonatomic) CGFloat left;

/**frame.origin.y*/
@property (nonatomic) CGFloat top;

/**frame.origin.x + frame.size.width*/
@property (nonatomic) CGFloat right;

/**frame.origin.y + frame.size.height*/
@property (nonatomic) CGFloat bottom;

@end

#pragma mark - UIView (Stretch)

/**Stretch扩展
 * 拉伸这个UIView
 */

@interface UIView (Stretch)

// Super

/**父控件的顶部：0*/
@property (nonatomic, readonly) CGFloat SuperTop;

/**父控件的左边：0*/
@property (nonatomic, readonly) CGFloat SuperLeft;

/**父控件的右边：width*/
@property (nonatomic, readonly) CGFloat SuperRight;

/**父控件的底部：height*/
@property (nonatomic, readonly) CGFloat SuperBottom;

/**父控件的顶点：(0 , 0)*/
@property (nonatomic, readonly) CGPoint SuperOrigin;

/**父控件的中心：(width / 2, height / 2)*/
@property (nonatomic, readonly) CGPoint SuperCenter;

/**父控件的整体：(0, 0, width, height)*/
@property (nonatomic, readonly) CGRect SuperFrame;

// Layout

/**距离左边某点(x,0)多少距离*/
- (UIView *)stretchLeft_toPointX:(CGFloat)left offset:(CGFloat)leftSpace;

/**距离上面某点(0,y)多少距离*/
- (UIView *)stretchTop_toPointY:(CGFloat)top offset:(CGFloat)topSpace;

/**距离右边某点(x,0)多少距离*/
- (UIView *)stretchRight_toPointX:(CGFloat)right offset:(CGFloat)rightSpace;

/**距离底部某点(0,y)多少距离*/
- (UIView *)stretchBottom_toPointY:(CGFloat)bottom offset:(CGFloat)bottomSpace;

@end

NS_ASSUME_NONNULL_END
