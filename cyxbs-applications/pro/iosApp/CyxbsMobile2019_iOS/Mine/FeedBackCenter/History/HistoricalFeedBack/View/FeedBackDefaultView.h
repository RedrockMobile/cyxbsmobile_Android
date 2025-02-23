//
//  FeedBackDefaultView.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/9/2.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedBackDefaultView : UIView

@property (nonatomic, strong) UIImageView * tipImgView;
@property (nonatomic, strong) UILabel * tipLabel;

- (void)setText:(NSString *)text ImgWithName:(NSString *)imgName;

/// 用来重写改变控件位置
- (void)configureView;

@end

NS_ASSUME_NONNULL_END
