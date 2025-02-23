//
//  NewQAHud.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/12/24.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewQAHud : NSObject

+ (void)showHudWith:(NSString *)title AddView:(UIView *)view;

/// 需要手动调用使hud消失的文字hud（登录界面的“登录中...”）
+ (MBProgressHUD *)showNotHideHudWith:(NSString *)title AddView:(UIView *)view;

+ (void)showHudWith:(NSString *)title AddView:(UIView *)view AndToDo:(void(^)(void))block;

+ (void)showHudAtWindowWithStr:(NSString *)title enableInteract:(BOOL)is;

+ (void)showHudAt:(nullable UIView *)view withStr:(NSString *)title enableInteract:(BOOL)is completion:(void(^)(void))block;

/// 弹出自定义View的弹窗，(可返回该弹窗，可在自定义View中设置按钮使该弹窗消失）
/// @param customView 自定义View
/// @param superView 弹窗应该加到的View
+ (MBProgressHUD *)showhudWithCustomView:(UIView *)customView AddView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
