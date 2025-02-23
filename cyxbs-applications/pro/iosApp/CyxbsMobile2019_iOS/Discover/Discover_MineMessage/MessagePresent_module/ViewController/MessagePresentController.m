//
//  MessagePresentController.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/23.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "MessagePresentController.h"

#import "MessagePresentView.h"

#pragma mark - MessegePresentController ()

@interface MessagePresentController ()

/// 主要的弹窗视图，请自定义
@property (null_resettable, nonatomic, strong) MessagePresentView *presentView;

@end

#pragma mark - MessegePresentController

@implementation MessagePresentController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        self.view.backgroundColor = [UIColor xFF_R:0 G:15 B:37 Alpha:0.14];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.presentView];
    self.presentView.center = self.view.SuperCenter;
}

#pragma mark - Method

- (void)addTitle:(NSString *)title textColor:(UIColor *)titleColor {
    [self.presentView addTitleStr:title color:titleColor];
}

- (void)addDetail:(NSString *)detail {
    [self.presentView addDetailStr:detail];
}

- (void)addDismiss:(void (^)(BOOL cancel))touchCancel {
    [self.presentView tapButton:^(BOOL isCancel) {
        [self dismissViewControllerAnimated:NO completion:nil];
        if (touchCancel) {
            touchCancel(isCancel);
        }
    }];
}

#pragma mark - Getter

- (MessagePresentView *)presentView {
    if (_presentView == nil) {
        _presentView = [[MessagePresentView alloc] initWithFrame:CGRectMake(0, 0, 255, 146)];
    }
    return _presentView;
}

@end
