//
//  popUpInformationVC.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "popUpInformationVC.h"

@interface popUpInformationVC ()

///信息说明的contentView，他是一个button，用来保证点击空白处可以取消
@property (nonatomic, weak) UIButton *informationContentView;

@end

@implementation popUpInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0];
    [self popInformation];
}

#pragma mark -弹出信息
- (void)popInformation {
    //添加灰色背景板
    UIButton *contentView = [[UIButton alloc]initWithFrame:self.view.frame];

    self.informationContentView = contentView;
    [self.view addSubview:contentView];
    contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    contentView.alpha = 0;

    [UIView animateWithDuration:0.3
                     animations:^{
        contentView.alpha = 1;
        self.tabBarController.tabBar.userInteractionEnabled = NO;
    }];
    [contentView addTarget:self action:@selector(cancelLearnAbout) forControlEvents:UIControlEventTouchUpInside];

    //内容
    UILabel *contentLab = [[UILabel alloc] init];
    contentLab.text = self.contentText;
    contentLab.font = [UIFont fontWithName:PingFangSCMedium size:14];
    contentLab.numberOfLines = 0;
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.6];
    contentLab.frame = CGRectMake(0, 0, 219, 0);
    [contentLab sizeToFit];    //计算高度

    UIView *learnView = [[UIView alloc]init];
    //设置圆角
    learnView.layer.cornerRadius = 16;
    learnView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:1];

    //标题
    UILabel *titLab = [[UILabel alloc] init];
    titLab.text = @"温馨提示";
    titLab.font = [UIFont fontWithName:PingFangSCSemibold size:18];
    titLab.textColor = [UIColor colorWithHexString:@"#15315B" alpha:1];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 130, 37)];
    //背景渐变色
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = button.bounds;
    //起点和终点表示的坐标系位置，（0，0)表示左上角，（1，1）表示右下角
    gl.startPoint = CGPointMake(0, 1);
    gl.endPoint = CGPointMake(1, 0);
    gl.colors = @[
        (__bridge id)[UIColor colorWithHexString:@"#4841E2"].CGColor,
        (__bridge id)[UIColor colorWithHexString:@"#5D5DF7"].CGColor
    ];
    gl.locations = @[@(0), @(1.0f)];
    [button.layer addSublayer:gl];

    [button setTitle:@"知道了" forState:normal];
    button.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    button.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:16];
    button.layer.cornerRadius = 16;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(cancelLearnAbout) forControlEvents:UIControlEventTouchUpInside];

    UIView *line = [[UIView alloc]init];

    if (@available(iOS 11.0, *)) {
        line.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:0.1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:0.5]];
    } else {
        line.backgroundColor = [UIColor colorWithRed:232 / 255.0 green:223 / 255.0 blue:241 / 255.0 alpha:1];
    }

    [self.view addSubview:learnView];
    [learnView addSubview:titLab];
    [learnView addSubview:contentLab];
    [learnView addSubview:button];
    [learnView addSubview:line];

    [learnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(60);
        make.right.equalTo(self.view).offset(-60);
        make.height.equalTo(@(132 + contentLab.size.height));
    }];

    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(learnView);
        make.top.equalTo(learnView).offset(20);
    }];

    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(learnView).offset(18);
        make.top.equalTo(titLab.mas_bottom).offset(10);
        make.right.equalTo(learnView).offset(-18);
    }];

    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(learnView);
        make.height.equalTo(@1);
        make.top.equalTo(contentLab.mas_bottom).offset(10);
    }];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(learnView);
        make.top.equalTo(contentLab.mas_bottom).offset(26);
        make.width.equalTo(@130);
        make.height.equalTo(@37);
    }];
}

- (void)cancelLearnAbout {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
}

- (void)setContentText:(NSString *)contentText {
    _contentText = contentText;
}

@end
