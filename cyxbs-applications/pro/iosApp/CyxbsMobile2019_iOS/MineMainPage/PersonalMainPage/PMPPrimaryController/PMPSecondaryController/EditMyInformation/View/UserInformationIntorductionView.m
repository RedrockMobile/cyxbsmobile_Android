//
//  UserInformationIntorductionView.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/7/29.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "UserInformationIntorductionView.h"
#import <WebKit/WebKit.h>
#import <NudeIn.h>

@interface UserInformationIntorductionView ()

@property (nonatomic, weak) UIButton *backButton;

@end

@implementation UserInformationIntorductionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 16;

        
        CGFloat rowSpace;
        CGFloat titleRowSpace;
        CGFloat titleFontSize;
        CGFloat subTitleFontSize;
        CGFloat textFontSize;
        
        if (IS_IPHONEX) {                       // iPhone X, Xs, XR, 11, 11 Pro, 11 Pro Max等
            titleRowSpace = 22;
            rowSpace = 16;
            titleFontSize = 20;
            subTitleFontSize = 17;
            textFontSize = 16;
        } else if (IS_IPHONESE) {               // 4.0寸iPhone
            titleRowSpace = 10;
            rowSpace = 7;
            titleFontSize = 17;
            subTitleFontSize = 14;
            textFontSize = 13;
        } else if (SCREEN_WIDTH == 375.f) {     // 4.7寸iPhone
            titleRowSpace = 13;
            rowSpace = 8;
            titleFontSize = 18;
            subTitleFontSize = 15;
            textFontSize = 14;
        } else {                                // 5.5寸iPhone
            titleRowSpace = 20;
            rowSpace = 15;
            titleFontSize = 19;
            subTitleFontSize = 16;
            textFontSize = 15;
        }
        
        NudeIn *userProtocolTextlabel = [NudeIn make:^(NUDTextMaker *make) {
            make
            .text(@"数据互通\n")
            .fontName(@"PingFangSC-Semibold", titleFontSize)
            .aligment(NUDAliCenter)
            .paraSpacing(0, titleRowSpace)
            .attach();
            
            make
            .text(@"1.若您已经同意相关用户协议条款，那么关于您的头像，您须知以下情况：\n")
            .fontName(@"PingFangSC-Semibold", subTitleFontSize)
            .paraSpacing(0, rowSpace)
            .attach();
            
            make
            .text(@"      若您已经通过微信绑定了红岩网校工作站的微信公众号：重邮小帮手\n      那么您的头像信息也将会被我们所知,且您如果没有对掌。掌上重邮APP上的头像进行自主修改的话，那么您的默认头像将会是您的微信头像，您可以自主修改您的头像，您自主修改的头像我们将会优先设置为您在掌上重邮APP上的头像。\n      若您并没有通过微信绑定红岩网校工作站的微信公众号：重邮小帮手\n      如果您没有设置您的掌上重邮APP头像，那么我们将会使用默认头像作为您的账户头像，您可以自定义修改您的头像。\n")
            .fontName(@"PingFangSC-Regular", textFontSize)
            .paraSpacing(0, rowSpace)
            .attach();
            
            make
            .text(@"2.若您未同意相关用户协议条款， 那么关于您的头像，您须知以下情况：\n")
            .fontName(@"PingFangSC-Semibold", subTitleFontSize)
            .paraSpacing(0, rowSpace)
            .attach();
            
            make
            .text(@"      您将无法获得权限进入掌上重邮APP并使用相关功能。")
            .fontName(@"PingFangSC-Regular", textFontSize)
            .paraSpacing(0, 10)
            .attach();
        }];
        
        userProtocolTextlabel.layer.cornerRadius = 16;
        userProtocolTextlabel.clipsToBounds = YES;
        userProtocolTextlabel.frame = CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 70);
        
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2C2C2C" alpha:1]];
            userProtocolTextlabel.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2C2C2C" alpha:1]];
            userProtocolTextlabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFEF" alpha:1]];
        } else {
            self.backgroundColor = [UIColor whiteColor];
            userProtocolTextlabel.backgroundColor = [UIColor whiteColor];
            userProtocolTextlabel.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
        }
        [self addSubview:userProtocolTextlabel];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [backButton setTitle:@"知道了" forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:17];
        backButton.frame = CGRectMake(frame.size.width / 2.0 - 40, self.frame.size.height - 50-30, 80, 35);
        if (@available(iOS 11.0, *)) {
            [backButton setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFEF" alpha:1]] forState:UIControlStateNormal];
        } else {
            [backButton setTitleColor:[UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1] forState:UIControlStateNormal];
        }
        [backButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        self.backButton = backButton;
    }
    return self;
}

- (void)dismissView {
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
