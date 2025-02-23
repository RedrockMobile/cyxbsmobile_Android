//
//  MineAboutController.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/2/4.
//  Copyright © 2020 Redrock. All rights reserved.
//关于我们页面 - 主控制器

#import "MineAboutController.h"
#import "MineAboutContentView.h"
#import "IntroductionController.h"
#import <AFNetworking.h>

@interface MineAboutController () <MineAboutContentViewDelegate>

@end

@implementation MineAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    if (@available(iOS 13.0, *)) {
//        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        // Fallback on earlier versions
    }
    
    MineAboutContentView *contentView = [[MineAboutContentView alloc] init];
    contentView.delegate = self;
    [self.view addSubview:contentView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - contentView代理
- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectedIntroduction {
    IntroductionController *introductionVC = [[IntroductionController alloc] init];
    [self presentViewController:introductionVC animated:YES completion:nil];
}

- (void)selectedProductWebsite {
    URLController * controller = [[URLController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.toUrl = @"https://app.redrock.team/#/";
    [self.navigationController pushViewController:controller animated:YES];
}



- (void)selectedUpdateCheck {
    [self p_versionUpdateButtonAction];

}

- (NSComparisonResult)compareSystemVersion:(NSString *)currentVersion toVersion:(NSString *)targetVersion {
    NSArray *currentVersionArr = [currentVersion componentsSeparatedByString:@"."];
    NSArray *targetVersionArr = [targetVersion componentsSeparatedByString:@"."];
    
    NSInteger pos = 0;
    
    while ([currentVersionArr count] > pos || [targetVersionArr count] > pos) {
        NSInteger v1 = [currentVersionArr count] > pos ? [[currentVersionArr objectAtIndex:pos] integerValue] : 0;
        NSInteger v2 = [targetVersionArr count] > pos ? [[targetVersionArr objectAtIndex:pos] integerValue] : 0;
        if (v1 < v2) {
            return NSOrderedAscending;
        }
        else if (v1 > v2) {
            return NSOrderedDescending;
        }
        pos++;
    }
    
    return NSOrderedSame;
}


- (void)p_versionUpdateButtonAction  {
    //获取本地的App版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    [self getAppStoreVersionInfoWithResponseBlock:^(NSDictionary * _Nonnull response, NSError * _Nonnull error) {
        NSString *appStoreVersion = response[@"version"];
        NSComparisonResult comparisonResult = [self compareSystemVersion:currentVersion toVersion:appStoreVersion];
            if (comparisonResult == NSOrderedAscending) {
                //更新弹窗
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"请去应用商店更新版本哦～";
                [hud hide:YES afterDelay:0.7];
            } else {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"已经是最新版本";
                [hud hide:YES afterDelay:0.7];
            }
    }];
    
}


- (void)getAppStoreVersionInfoWithResponseBlock:(void (^)(NSDictionary *, NSError *))responseBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
    
    [manager GET:@"https://itunes.apple.com/cn/lookup?id=974026615" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray *dataArray = responseObject[@"results"];
        if (dataArray.count != 0) {// 先判断返回的数据是否为空
            NSDictionary *dict = dataArray.firstObject;
            responseBlock(dict, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseBlock(nil, error);
    }];
}


@end
