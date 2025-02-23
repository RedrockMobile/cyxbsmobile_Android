//
//  GPAUnavailableViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/11/11.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "GPAUnavailableViewController.h"

@interface GPAUnavailableViewController ()

@end

@implementation GPAUnavailableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBar];
    
}

- (void)setupBar{
    self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    self.VCTitleStr = @"学分成绩";
    self.topBarView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    self.splitLineColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E4E4E9" alpha:1] darkColor:[UIColor colorWithHexString:@"#2C2B2E" alpha:1]];
    self.titlePosition = TopBarViewTitlePositionLeft;
    self.titleFont = [UIFont fontWithName:PingFangSCSemibold size:21];
}


@end
