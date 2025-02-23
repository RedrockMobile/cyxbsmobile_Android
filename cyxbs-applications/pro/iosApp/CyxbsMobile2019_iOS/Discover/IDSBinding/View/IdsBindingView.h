//
//  IdsBindingView.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/8/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol IdsBindingViewDelegate <NSObject>

- (void)touchBindingButton;

@end

@interface IdsBindingView : UIView
@property (nonatomic, weak) UITextField *accountfield;
@property (nonatomic, weak) UITextField *passTextfield;
@property (nonatomic, weak) UIButton *bindingButton;

@property (nonatomic, weak) id <IdsBindingViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
