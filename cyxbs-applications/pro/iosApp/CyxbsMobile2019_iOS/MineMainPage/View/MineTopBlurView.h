//
//  TopBlurView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/9/22.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageNumBtn.h"

NS_ASSUME_NONNULL_BEGIN

/// 顶部一块带有模糊背景的View
@interface MineTopBlurView : UIView

/// 头像按钮
@property (nonatomic, strong)UIButton *headImgBtn;

/// 真实姓名label
@property (nonatomic, strong)UILabel *realNameLabel;

/// 个性签名label
@property (nonatomic, strong)UILabel *introductionLabel;

/// 点击后进入个人主页的小箭头按钮
@property (nonatomic, strong)UIButton *homePageBtn;

/// 半透明的背景图片
@property (nonatomic, strong)UIImageView *blurImgView;

//用 init 方法初始化，别用 initWithFrame
- (instancetype)initWithFrame:(CGRect)frame API_UNAVAILABLE(ios);

//- (instancetype)init NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
