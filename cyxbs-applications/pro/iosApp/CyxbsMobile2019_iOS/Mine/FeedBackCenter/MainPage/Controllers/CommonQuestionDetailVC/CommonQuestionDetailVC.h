//
//  CommonQuestionDetailVC.h
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/27.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "TopBarBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class WKWebView;
@interface CommonQuestionDetailVC : TopBarBasicViewController

///常见问题数组
@property (nonatomic,strong) NSArray *CommonQuestionAry;
///webview
@property (nonatomic,strong) WKWebView *webView;
///当前的行 （Row）
@property (nonatomic,assign) NSInteger row;
///初始化 传入行（Row）
- (instancetype)initWithIndexPathRow:(NSInteger)row;
@end

NS_ASSUME_NONNULL_END
