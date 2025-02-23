//
//  MessageDetailVC.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/30.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "MessageDetailVC.h"

#import <WebKit/WebKit.h>

#import "SSRTopBarBaseView.h"

#import "MessageDetailTitleView.h"

#pragma mark - MessageDetailVC ()

@interface MessageDetailVC () <
    WKNavigationDelegate
>

/// 顶视图，可能会有的那种
@property (nonatomic, strong) MessageDetailTitleView *titleView;

/// 用户发布信息
@property (nonatomic, strong) UserPublishModel __kindof *publishModel;

/// 顶视图
@property (nonatomic, strong) SSRTopBarBaseView *topView;

/// 加载的URL
@property (nonatomic, copy) NSString *url;

/// 加载页
@property (nonatomic, strong) WKWebView *webView;

/// 加载更多的button
@property (nonatomic, strong) UIButton *moreBtn;

/// 加载更多的URL，可空
@property (nonatomic, copy, nullable) NSString *moreURL;

@end

#pragma mark - MessageDetailVC

@implementation MessageDetailVC

#pragma mark - Life cycle

/// 根据URL加载页面
/// @param url 传入url
- (instancetype)initWithURL:(NSString *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)url
            useSpecialModel:(nullable __kindof UserPublishModel * (^)(void))useModel
                    moreURL:(NSString *)moreURL {
    self = [super init];
    if (self) {
        self.url = url;
        
        if (useModel) {
            UserPublishModel *model = useModel();
            if (model) {
                self.publishModel = model;
            }
        }
        
        if (moreURL && ![moreURL isEqualToString:@""]) {
            self.moreURL = moreURL;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =
    [UIColor dm_colorWithLightColor:[UIColor xFF_R:248 G:249 B:252 Alpha:1]
                          darkColor:[UIColor xFF_R:0 G:1 B:1 Alpha:1]];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.webView];
    
    if (self.moreURL) {
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(self.webView.scrollView.contentInset.top, 0, 116, 0);
        [self.webView.scrollView addSubview:self.moreBtn];
    }
    
    if (self.publishModel) {
        self.titleView = [[MessageDetailTitleView alloc] initWithWidth:self.webView.width specialUserPublishModel:self.publishModel];
        self.titleView.top = -self.titleView.height;
        
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(self.titleView.height, 0, self.webView.scrollView.contentInset.bottom, 0);
        [self.webView.scrollView addSubview:self.titleView];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.webView.navigationDelegate = nil;
}

#pragma mark - Method

// MARK: SEL

- (void)messageDetailVC_pop {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)messageDetailVC_showWebView {
    self.webView.hidden = NO;
    self.moreBtn.top = self.webView.scrollView.contentSize.height + 36;
    [self.webView.scrollView scrollToTopAnimated:NO];
}

- (void)messageDetailVC_push {
    [self.navigationController
     pushViewController:
         [[MessageDetailVC alloc]
          initWithURL:self.moreURL
          useSpecialModel:nil
          moreURL:nil]
     animated:YES];
}

#pragma mark - <WKNavigationDelegate>

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *backgroundColor =
    [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1]
                          darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]].hexString;
    
    NSString *textColor =
    [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1]
                          darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:1]].hexString;
    
    [webView evaluateJavaScript:
     [NSString stringWithFormat:@"document.body.style.backgroundColor = \"%@\"", backgroundColor]
              completionHandler:nil];
    
    [webView evaluateJavaScript:
     [NSString stringWithFormat:@"document.body.style.webkitTextFillColor = \"%@\"", textColor]
              completionHandler:nil];
    
    [webView evaluateJavaScript:@"document.body.style.fontFamily = \"PingFang SC\"" completionHandler:nil];
    
    NSString *injectionJSString = @"var script = document.createElement('meta');"
                                   "script.name = 'viewport';"
                                   "script.content=\"width=device-width, user-scalable=no\";"
                                   "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
    
    [self performSelector:@selector(messageDetailVC_showWebView) afterDelay:0.1];
}

#pragma mark - Getter

- (SSRTopBarBaseView *)topView {
    if (_topView == nil) {
        _topView = [[SSRTopBarBaseView alloc] initWithSafeViewHeight:44];
        _topView.hadLine = NO;
        [_topView addTitle:@"详情" withTitleLay:SSRTopBarBaseViewTitleLabLayLeft withStyle:nil];
        [_topView addBackButtonTarget:self action:@selector(messageDetailVC_pop)];
    }
    return _topView;
}

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(16, self.topView.bottom, self.view.width - 2 * 16, self.view.height - self.topView.bottom)];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        
        [_webView loadRequest:
         [HttpTool.shareTool
          URLRequestWithURL:self.url
          bodyParameters:nil]];
        
        _webView.hidden = YES;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (UIButton *)moreBtn {
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 184, 40)];
        _moreBtn.centerX = self.webView.scrollView.SuperCenter.x;
        _moreBtn.layer.cornerRadius = _moreBtn.height / 2;
        
        _moreBtn.backgroundColor = [UIColor colorWithHexString:@"#4A44E4" alpha:1];
        [_moreBtn setTitle:@"点击前往" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont fontWithName:PingFangSC size:18];
        [_moreBtn addTarget:self action:@selector(messageDetailVC_push) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

@end
