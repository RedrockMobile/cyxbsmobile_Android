//
//  DiscoverMineMessageVC.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "DiscoverMineMessageVC.h"

#import "MineMessageVC.h"

#import "SystemMsgModel.h"

#import "掌上重邮-Swift.h"

#pragma mark - MineMessageViewController ()

@interface DiscoverMineMessageVC ()

/// the messageBtn should the same frame with view
@property (nonatomic, strong) UIButton *messageBtn;

@end

#pragma mark - MineMessageViewController

@implementation DiscoverMineMessageVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat cap = 24.0 / 20.0;
    self.view.frame = CGRectMake(0, 0, 24 * cap, 24);
    
    [self.view addSubview:self.messageBtn];
    self.hadRead = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
    
    [JudgeArrangeMessage isNeedRedDotWithCompletion:^(BOOL need) {
        if (need) {
            [self->_messageBtn
             setImage:[UIImage imageNamed:@"message_c"]
             forState:UIControlStateNormal];
        } else {
            [self->_messageBtn
             setImage:[UIImage imageNamed:@"message_d"]
             forState:UIControlStateNormal];
        }
    }];
}

#pragma mark - Method

- (void)reloadData {
    
    [HttpTool.shareTool
     request:Discover_GET_userHadRead_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        BOOL hadread = [object[@"data"][@"has"] boolValue];
        self.hadRead = hadread;
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// MARK: SEL

- (void)discoverMinePushToMineMessage {
    MineMessageVC *vc = [[MineMessageVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController
     pushViewController:vc
     animated:YES];
}

#pragma mark - Getter

- (UIButton *)messageBtn {
    if (_messageBtn == nil) {
        _messageBtn = [[UIButton alloc] initWithFrame:self.view.SuperFrame];
        [_messageBtn
         setImage:[UIImage imageNamed:@"message_d"]
         forState:UIControlStateNormal];
        [_messageBtn addTarget:self action:@selector(discoverMinePushToMineMessage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

#pragma mark - Setter

- (void)setHadRead:(BOOL)hadRead {
    if (_hadRead == hadRead) {
        return;
    }
    if (hadRead) {
        [self.messageBtn setImage:[UIImage imageNamed:@"message_c"] forState:UIControlStateNormal];
    } else {
        [self.messageBtn setImage:[UIImage imageNamed:@"message_d"] forState:UIControlStateNormal];
    }
    _hadRead = hadRead;
}

@end
