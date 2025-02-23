//
//  IntroductionController.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/27.
//  Copyright © 2020 Redrock. All rights reserved.
//关于我们页面 - 功能介绍

#import "IntroductionController.h"
#import <NudeIn.h>

@interface IntroductionController ()

@end

@implementation IntroductionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
    } else {
        self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:252/255.0 alpha:1];
    }
    
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
    
    NudeIn *introductionTextView = [NudeIn make:^(NUDTextMaker *make) {
        make.text(@"功能介绍\n")
        .fontName(PingFangSCSemibold, titleFontSize)
        .aligment(NUDAliCenter)
        .paraSpacing(0, titleRowSpace)
        .attach();
        
        make.text(@"版本号：V6.0.0\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t掌邮已经陪伴各位邮子走过了五年多的历程，在此期间，我们一直努力的将更多实用、好用的功能提供给大家使用，在6.0版本的更新中，掌上重邮以全新的面貌，我们从更侧重用户体验的角度出发，重新设计产品视觉，开发以及改进了多个功能，希望广大邮子喜欢。下面带来部分新特性的介绍\n\n")
        .fontName(PingFangSCRegular, textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"1.课表\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t从掌上重邮课表开始，规划你的大学校园行程，现在课表可以在最近课表视图与周课表视图轻松切换，只需轻松一滑，即可从及时的下节课信息内容切换到到整屏全面的周课表信息，在此基础上你可以轻松快速的添加你的个人行程，为重要行程设置推送提醒。\n\n")
        .fontName(PingFangSCRegular, textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"2.发现\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t发现页面提供了多种多样的校园便利工具，在新版本中，各个功能都有了更细致的设计更新，力争为您带来更好用更全面的功能体验。与此同时，考试与成绩现在可以查询更全面的信息了，过往成绩统计，学分信息统计，以及可视化的曲线图，让您直观了解您的成绩变化曲线。超多新体验新细节待你体验。\n\n")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"3.深色模式\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t全局的深色模式也将随着6.0版本的推出同步上线，开启手机系统的暗黑模式按钮（部分系统不支持），即可发现另一个掌邮，希望它可以陪着你，从早到晚。\n\n")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"4.更多\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t积分系统积极迎来优化，现在立刻参与邮问活动、每日打卡赚取积分，在积分商城兑换新奇好玩的奖励（积分商城兑换系统开启时间另行通知）。期待掌上重邮能够陪着你的校园生活，使你的校园生活更加便捷、轻松。\n\n")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t掌上重邮一直乐于听取用户的意见，我们认真的对用户意见进行了收集与分析，对产品做了改进，一切只为邮子用的更好，欢迎热心的你加入掌上重邮反馈群：570919844，提出你宝贵的意见和建议。")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\n\n更多功能介绍详见掌上重邮官方网站")
        .aligment(NUDAliCenter)
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
    }];
    introductionTextView.frame = CGRectMake(20, 40, MAIN_SCREEN_W - 40, self.view.frame.size.height - 100);
    if (@available(iOS 11.0, *)) {
        introductionTextView.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFEF" alpha:1]];
        introductionTextView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
    } else {
        introductionTextView.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
        introductionTextView.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:252/255.0 alpha:1];
    }
    introductionTextView.scrollEnabled = YES;
    [self.view addSubview:introductionTextView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
