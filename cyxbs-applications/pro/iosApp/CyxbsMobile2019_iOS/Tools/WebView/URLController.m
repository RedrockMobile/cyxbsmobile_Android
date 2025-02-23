//
//  URLController.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/17.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "URLController.h"
#import <WebKit/WebKit.h>

@interface URLController ()<WKNavigationDelegate>

@property (nonatomic, weak) UIButton *backButton;//返回按钮
@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) UILabel *titleLabel;

@end


@implementation URLController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    
    //获取导航栏高度
    double navHeight = self.navigationController.navigationBar.frame.size.height;
    //获取状态栏高度
    double statusHeight = 0;
    UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
    statusHeight = statusBarManager.statusBarFrame.size.height;
    WKWebView * webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, statusHeight + navHeight, self.view.width, self.view.height - statusHeight - navHeight - 44)];
    self.webView = webView;
    self.webView.navigationDelegate = self;
    NSURL * url = [NSURL URLWithString:_toUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
//    NSLog(@"_toUrl = %@",_toUrl);
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:webView];
    [webView loadRequest:request];
    
    [self addBackButton];
    [self addWebToolBar];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"网页加载失败");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (!self.titleLabel) {
        [self addTitle];
    }
}

- (void)addBackButton {
    UIButton *button = [[UIButton alloc]init];
    [self.view addSubview:button];
    self.backButton = button;
    [button setImage:[UIImage imageNamed:@"LQQBackButton"] forState:normal];
    [button setImage: [UIImage imageNamed:@"EmptyClassBackButton"] forState:UIControlStateHighlighted];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.bottom.equalTo(self.webView.mas_top).offset(-10);
        make.left.equalTo(self.view).offset(8.6);
    }];
    [button setImageEdgeInsets:UIEdgeInsetsMake(6, 10, 6, 10)];//增大点击范围
    [button addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addTitle {
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];
    label.text = self.webView.title;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backButton.mas_right).offset(15);
        make.centerY.equalTo(self.backButton);
    }];
    label.font = [UIFont fontWithName:PingFangSCMedium size: 22];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    self.titleLabel = label;
}

- (void)addWebToolBar {
    UIView *webToolBar = [[UIView alloc] init];
    webToolBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webToolBar];
    
    UIButton *pageBack = [UIButton buttonWithType:UIButtonTypeSystem];
    [pageBack setBackgroundImage:[UIImage imageNamed:@"WebPageBack"] forState:UIControlStateNormal];
    [pageBack addTarget:self action:@selector(webPageBack) forControlEvents:UIControlEventTouchUpInside];
    [webToolBar addSubview:pageBack];
    
    UIButton *pageForward = [UIButton buttonWithType:UIButtonTypeSystem];
    [pageForward setBackgroundImage:[UIImage imageNamed:@"WebPageForward"] forState:UIControlStateNormal];
    [pageForward addTarget:self action:@selector(webPageForward) forControlEvents:UIControlEventTouchUpInside];
    [webToolBar addSubview:pageForward];
    
    UIButton *pageRefresh = [UIButton buttonWithType:UIButtonTypeSystem];
    [pageRefresh setBackgroundImage:[UIImage imageNamed:@"WebPageRefresh"] forState:UIControlStateNormal];
    [pageRefresh addTarget:self action:@selector(webPageRefresh) forControlEvents:UIControlEventTouchUpInside];
    [webToolBar addSubview:pageRefresh];
    
    
    [webToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
    [pageBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(webToolBar).offset(50);
        make.centerY.equalTo(webToolBar);
        make.height.width.equalTo(@25);
    }];
    
    [pageForward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(webToolBar);
        make.height.width.equalTo(pageBack);
    }];
    
    [pageRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(webToolBar);
        make.trailing.equalTo(webToolBar).offset(-50);
        make.height.width.equalTo(pageBack);
    }];
    
}

- (void)popController {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)webPageBack {
    [self.webView goBack];
}

- (void)webPageForward {
    [self.webView goForward];
}

- (void)webPageRefresh {
    [self.webView reload];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]) {
        self.titleLabel.text = change[@"new"];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;

     NSLog(@"url = %@",navigationAction.request.URL);
     NSLog(@"host = %@",[navigationAction.request.URL host]);
     NSLog(@"scheme = %@",[navigationAction.request.URL scheme]);

     /*
         如果是域名，判断itunes的host链接 ；
         如果是scheme跳转，就判断是否是 App Store 的 scheme
     */

     if([[navigationAction.request.URL host] isEqualToString:@"itunes.apple.com"] || [[navigationAction.request.URL scheme] isEqualToString:@"itms-apps"]) {
         [UIApplication.sharedApplication
          openURL:navigationAction.request.URL options:@{} completionHandler:nil];
     }
     decisionHandler(policy);
}

@end
