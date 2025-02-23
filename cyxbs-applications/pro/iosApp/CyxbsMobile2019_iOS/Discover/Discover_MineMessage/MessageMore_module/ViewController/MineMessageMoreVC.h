//
//  MineMessageMoreVC.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/19.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MineMessageMoreVC;

#pragma mark - MineMessageMoreVCDelegate

@protocol MineMessageMoreVCDelegate <NSObject>

@required

/// 选中的了什么标题的东西
/// @param vc 控制器
/// @param title 标题
- (void)mineMessageMoreVC:(MineMessageMoreVC *)vc selectedTitle:(NSString *)title;

@end

#pragma mark - MineMessageMoreVC

/// 这个控制器是小控制器哟
@interface MineMessageMoreVC : UIViewController

///// 要绑定这个，才能正常显示哦，就是箭头的sourse
//@property (nonatomic, weak) UIView *sourseView;
//
/// 代理
@property (nonatomic, weak) id <MineMessageMoreVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
