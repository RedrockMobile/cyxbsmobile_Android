//
//  UIView+Rising.h
//  Rising
//
//  Created by SSR on 2022/9/17.
//

#import <UIKit/UIKit.h>

#if __has_include(<YYKit/UIView+YYAdd.h>)
#import <YYKit/UIView+YYAdd.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Rising)

/// Shortcut for frame.origin.x
@property (nonatomic) CGFloat x;

/// Shortcut for frame.origin.y
@property (nonatomic) CGFloat y;

// call when used as super view

/// 0
@property (nonatomic, readonly) CGFloat SuperLeft;

/// 0
@property (nonatomic, readonly) CGFloat SuperTop;

/// frame.origin.width
@property (nonatomic, readonly) CGFloat SuperRight;

/// frame.size.height
@property (nonatomic, readonly) CGFloat SuperBottom;

/// CGPointMake(0, 0)
@property (nonatomic, readonly) CGPoint SuperOrigin;

/// CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
@property (nonatomic, readonly) CGPoint SuperCenter;

/// CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
@property (nonatomic, readonly) CGRect SuperFrame;

@end

NS_ASSUME_NONNULL_END
