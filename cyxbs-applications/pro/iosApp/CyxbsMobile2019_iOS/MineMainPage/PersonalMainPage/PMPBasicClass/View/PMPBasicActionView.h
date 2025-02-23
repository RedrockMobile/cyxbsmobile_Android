//
//  PMPBasicActionView.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/9/15.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+JHFrameExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMPBasicActionView : UIView

- (void)addTarget:(nullable id)target
           action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
