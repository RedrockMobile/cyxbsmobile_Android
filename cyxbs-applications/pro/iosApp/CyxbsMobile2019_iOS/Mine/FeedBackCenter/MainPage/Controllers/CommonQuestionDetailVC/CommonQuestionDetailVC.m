//
//  CommonQuestionDetailVC.m
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/27.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "CommonQuestionDetailVC.h"
#import "CommonQuestionData.h"
#import <WebKit/WebKit.h>

@interface CommonQuestionDetailVC () <WKUIDelegate,WKNavigationDelegate> 

@end

@implementation CommonQuestionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupBar];
    [self.view addSubview:self.webView];
    
}
#pragma mark - setter
- (void)setCommonQuestionAry:(NSArray *)CommonQuestionAry{
    _CommonQuestionAry = CommonQuestionAry;
    CommonQuestionData *data = _CommonQuestionAry[self.row];
    self.VCTitleStr = data.title;
    [self.webView loadHTMLString:data.content baseURL:nil];
}

#pragma mark - getter
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, Bar_H, SCREEN_WIDTH, SCREEN_HEIGHT - Bar_H)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}
#pragma mark - 私有方法
- (void)setupBar{
    self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    self.VCTitleStr = @"";
    self.topBarView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    self.splitLineColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E4E4E9" alpha:1] darkColor:[UIColor colorWithHexString:@"#2C2B2E" alpha:1]];
    self.titlePosition = TopBarViewTitlePositionLeft;
    self.titleFont = [UIFont fontWithName:PingFangSCSemibold size:21];
}

- (instancetype)initWithIndexPathRow:(NSInteger)row{
    if (self = [super init]) {
        self.row = row;
    }
    return self;
}

- (void)setupData{
    [CommonQuestionData CommonQuestionDataWithSuccess:^(NSArray * _Nonnull array) {
        self.CommonQuestionAry = array;
        } error:^{
            [NewQAHud showHudWith:@"网络异常" AddView:self.view];
        }];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    //修改字体大小 300%
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'" completionHandler:nil];
}
@end
