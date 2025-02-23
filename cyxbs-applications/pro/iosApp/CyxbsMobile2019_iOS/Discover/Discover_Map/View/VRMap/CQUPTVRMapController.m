//
//  CQUPTVRMapController.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/28.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTVRMapController.h"
#import <WebKit/WebKit.h>

@interface CQUPTVRMapController () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation CQUPTVRMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    WKWebView *mapView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:webConfiguration];
    NSString *urlStr = @"http://720yun.com/t/0e929mp6utn?pano_id=473004";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [mapView loadRequest:request];
    
    [self.view addSubview:mapView];
    
    [self setBackButton];
    
}

- (void)setBackButton {
    // 返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setImage:[UIImage imageNamed:@"我的返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(STATUSBARHEIGHT + 15);
        make.leading.equalTo(self.view).offset(15);
        make.height.equalTo(@19);
        make.width.equalTo(@9);
    }];
}

/// 点击 返回按钮 后调用的方法
- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
