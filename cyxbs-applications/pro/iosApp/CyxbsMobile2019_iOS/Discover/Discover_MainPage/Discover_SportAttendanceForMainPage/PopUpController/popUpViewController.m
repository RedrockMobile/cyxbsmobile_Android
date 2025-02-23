//
//  popUpViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/9.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "popUpViewController.h"

@interface popUpViewController ()

///信息说明的contentView，他是一个button，用来保证点击空白处可以取消
@property (nonatomic, weak) UIButton * learnAboutContentView;

@end

@implementation popUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0];
    [self learnAbout];
}

#pragma mark -点击了解更多
- (void)learnAbout {
    //添加灰色背景板
    UIButton * contentView = [[UIButton alloc]initWithFrame:self.view.frame];
    self.learnAboutContentView = contentView;
    [self.view addSubview:contentView];
    contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    contentView.alpha = 0;

    [UIView animateWithDuration:0.3 animations:^{
        contentView.alpha = 1;
//        hideTabbarView.alpha = 1;
//        self.tabBarController.tabBar.hidden=YES;
        self.tabBarController.tabBar.userInteractionEnabled = NO;
    }];
    [contentView addTarget:self action:@selector(cancelLearnAbout) forControlEvents:UIControlEventTouchUpInside];
//
    UIView *learnView = [[UIView alloc]init];
    //设置圆角
    learnView.layer.cornerRadius = 16;
    learnView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    [contentView addSubview:learnView];
    [learnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@487);
    }];
    
    UILabel *titLab = [[UILabel alloc] init];
    [learnView addSubview:titLab];
    titLab.text = @"体育打卡信息说明";
    titLab.font = [UIFont fontWithName:PingFangSCSemibold size:19];
    titLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(learnView);
        make.top.equalTo(learnView).offset(26);
    }];
    
    UILabel *firstLab = [[UILabel alloc] init];
    [learnView addSubview:firstLab];
    firstLab.text = @"1.关于信息来源：";
    firstLab.font = [UIFont fontWithName:PingFangSCSemibold size: 16.5];
    firstLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    [firstLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(learnView).offset(26);
        make.top.equalTo(titLab.mas_bottom).offset(20);
    }];
    
    UILabel *secondLab = [[UILabel alloc] init];
    [learnView addSubview:secondLab];
    secondLab.text = @"所有信息来源于教务在线，实际请以教务在线为准。";
    secondLab.textAlignment = NSTextAlignmentJustified;
    secondLab.numberOfLines = 0;
    secondLab.font = [UIFont fontWithName:PingFangSC size: 14.5];
    secondLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    [secondLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(learnView);
        make.left.equalTo(firstLab);
        make.top.equalTo(firstLab.mas_bottom).offset(8);
    }];
    
    UILabel *thirdLab = [[UILabel alloc] init];
    [learnView addSubview:thirdLab];
    thirdLab.text = @"2.关于剩余次数：";
    thirdLab.font = [UIFont fontWithName:PingFangSCSemibold size: 16.5];
    thirdLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    [thirdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLab);
        make.top.equalTo(secondLab.mas_bottom).offset(16);
    }];
    
    UILabel *fourthLab = [[UILabel alloc] init];
    [learnView addSubview:fourthLab];
    fourthLab.text = @"根据重庆邮电大学体育打卡规定，跑步锻炼可以替代其他锻炼次数。所以关于主页面显示的其他剩余次数减少原因可能时由于其他锻炼造成，也有可能是由跑步锻炼造成。但是其他锻炼不可以代替跑步。";
    fourthLab.textAlignment = NSTextAlignmentJustified;
    fourthLab.numberOfLines = 0;
    fourthLab.font = [UIFont fontWithName:PingFangSC size: 14.5];
    fourthLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    [fourthLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(learnView);
        make.left.equalTo(firstLab);
        make.top.equalTo(thirdLab.mas_bottom).offset(8);
    }];

    UIButton *button = [[UIButton alloc] init];
    [learnView addSubview:button];
    button.backgroundColor = [UIColor colorWithHexString:@"#4A44E4" alpha:1];
    [button setTitle:@"确认" forState:normal];
    button.titleLabel.font = [UIFont fontWithName:PingFangSC size: 14];
    button.layer.cornerRadius = 16;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(learnView);
        make.bottom.equalTo(learnView).offset(-26);
        make.width.equalTo(@129);
        make.height.equalTo(@34);
    }];
    [button addTarget:self action:@selector(cancelLearnAbout) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancelLearnAbout {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
