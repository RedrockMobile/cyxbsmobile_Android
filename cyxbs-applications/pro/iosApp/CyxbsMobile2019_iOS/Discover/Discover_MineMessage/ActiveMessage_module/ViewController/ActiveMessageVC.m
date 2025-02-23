//
//  ActiveMessageVC.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ActiveMessageVC.h"

#import "ActiveMessageCell.h"

#import "MessageDetailVC.h"

#pragma mark - ActiveMessageVC ()

@interface ActiveMessageVC () <
    UITableViewDelegate,
    UITableViewDataSource
>

/// 展示信息的tableView
@property (nonatomic, strong) UITableView *msgTableView;

@end

#pragma mark - ActiveMessageVC

@implementation ActiveMessageVC

#pragma mark - Life cycle

- (instancetype)initWithActiveMessage:(ActiveMessageModel *)model frame:(CGRect)frame{
    self = [super init];
    if (self) {
        self.sysModel = model;
        self.view.frame = frame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.view addSubview:self.msgTableView];
}

#pragma mark - Method

- (BOOL)hadReadAfterReloadData {
    [self.msgTableView reloadData];
    BOOL needBall = NO;
    for (ActiveMessage *msg in self.sysModel.activeMsgAry) {
        needBall |= !msg.hadRead;
    }
    return needBall;
}

- (void)readAllMessage {
    NSIndexSet *set = [NSIndexSet
                       indexSetWithIndexesInRange:
                           NSMakeRange(0, self.sysModel.activeMsgAry.count)];
    [self.sysModel
     requestReadForIndexSet:set
     success:^{
        // 什么都不用干
     }
     failure:^(NSError * _Nonnull error) {
        // -- 没有网络，请连接网络再次尝试 --
     }];
    [self.msgTableView reloadData];
    if (self.delegate) {
        [self.delegate activeMessageVC_hadReadAllMsg:self];
    }
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ActiveMessageCell heightForContent:self.sysModel.activeMsgAry[indexPath.row].content forWidth:tableView.width - 2 * 17];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.sysModel
     requestReadForIndexSet:[NSIndexSet indexSetWithIndex:indexPath.row]
     success:^{
         // 什么都可以不用做
    }
     failure:^(NSError * _Nonnull error) {
         // 什么都可以不用做
    }];
    
    ActiveMessage *msg = self.sysModel.activeMsgAry[indexPath.row];
    // -- 选中了哪个 --
    msg.hadRead = YES;
    
    ActiveMessageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.hadRead = YES;
    
    BOOL needBall = NO;
    for (ActiveMessage *msg in self.sysModel.activeMsgAry) {
        needBall |= !msg.hadRead;
    }
    if (!needBall && self.delegate) {
        [self.delegate activeMessageVC_hadReadAllMsg:self];
    }
    
    [self.navigationController
     pushViewController:
         [[MessageDetailVC alloc]
          initWithURL:msg.articleURL
          useSpecialModel:^__kindof UserPublishModel * _Nonnull {
                return msg;
          }
          moreURL:msg.redirectURL]
     animated:YES];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sysModel.activeMsgAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActiveMessage *msg = self.sysModel.activeMsgAry[indexPath.row];
    
    ActiveMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ActiveMessageCellReuseIdentifier forIndexPath:indexPath];
    
    [cell
     drawTitle:msg.title
     headURL:msg.headURL
     author:msg.author
     date:msg.uploadDate
     content:msg.content
     msgImgURL:msg.picURL];
    
    cell.hadRead = msg.hadRead;
    
    return cell;
}

#pragma mark - Getter

- (UITableView *)msgTableView {
    if (_msgTableView == nil) {
        _msgTableView = [[UITableView alloc] initWithFrame:self.view.SuperFrame style:UITableViewStylePlain];
        
        _msgTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _msgTableView.separatorColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:0.8]
                              darkColor:[UIColor colorWithHexString:@"#676767" alpha:0.8]];
        
        _msgTableView.backgroundColor = UIColor.clearColor;
        _msgTableView.showsVerticalScrollIndicator = NO;
        _msgTableView.showsHorizontalScrollIndicator = NO;
        [_msgTableView registerClass:ActiveMessageCell.class forCellReuseIdentifier:ActiveMessageCellReuseIdentifier];
        _msgTableView.delegate = self;
        _msgTableView.dataSource = self;
    }
    return _msgTableView;
}

@end
