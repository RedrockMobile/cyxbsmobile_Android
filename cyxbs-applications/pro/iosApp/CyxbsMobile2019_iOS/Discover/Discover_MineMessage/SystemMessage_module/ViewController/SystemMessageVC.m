//
//  SystemMessageVC.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SystemMessageVC.h"

#import "MessagePresentController.h"

#import "SystemMessageView.h"

#import "MessageDetailVC.h"

#import "RemindHUD.h"

#pragma mark - SystemMessageVC ()

@interface SystemMessageVC () <
    SystemMessageViewDelegate
>

/// 视图，等大view
@property (nonatomic, strong) SystemMessageView *messageView;

@end

#pragma mark - SystemMessageVC

@implementation SystemMessageVC

#pragma mark - Life cycle

- (instancetype)initWithSystemMessage:(SystemMsgModel *)model frame:(CGRect)frame{
    self = [super init];
    if (self) {
        self.sysMsgModel = model;
        self.view.frame = frame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.messageView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.view.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.messageView.isEditing = NO;
}

#pragma mark - Method

- (BOOL)hadReadAfterReloadData {
    [self.messageView reloadData];
    BOOL needBall = NO;
    for (SystemMessage *msg in self.sysMsgModel.msgAry) {
        needBall |= !msg.hadRead;
    }
    return needBall;
}

- (void)readAllMessage {
    NSIndexSet *set = [NSIndexSet
                       indexSetWithIndexesInRange:
                           NSMakeRange(0, self.sysMsgModel.msgAry.count)];
    [self.sysMsgModel
     requestReadForIndexSet:set
     success:^{
        [RemindHUD.shared showDefaultHUDWithText:@"已全部已读" completion:nil];
     }
     failure:^(NSError * _Nonnull error) {
        [RemindHUD.shared showDefaultHUDWithText:@"无法连接网络" completion:nil];
     }];
    [self.messageView reloadData];
    if (self.delegate) {
        [self.delegate systemMessageVC_hadReadAllMsg:self];
    }
}

- (void)deleteAllReadMessage {
    MessagePresentController *pc = [[MessagePresentController alloc] init];
    [pc addDetail:@"确定删除所有已读信息吗"];
    [self.navigationController presentViewController:pc animated:NO completion:nil];
    [pc addDismiss:^(BOOL cancel) {
        // 不是取消（那就删）
        if (!cancel) {
            NSMutableIndexSet *set = NSMutableIndexSet.indexSet;
            for (NSInteger i = 0; i < self.sysMsgModel.msgAry.count; i++) {
                if (self.sysMsgModel.msgAry[i].hadRead) {
                    [set addIndex:i];
                }
            }
            [self.messageView deleteMsgWithIndexSet:set.copy withWarn:NO];
        }
    }];
}

#pragma mark - <SystemMessageViewDelegate>

- (void)systemMessageTableView:(UITableView *)view didSelectedAtIndex:(NSInteger)index {
    // 选择了，应该跳转
    SystemMessage *msg = self.sysMsgModel.msgAry[index];
    
    [self.navigationController
     pushViewController:
     [[MessageDetailVC alloc]
      initWithURL:msg.articleURL
      useSpecialModel:^__kindof UserPublishModel * _Nonnull{
        msg.headURL = nil;
        msg.author = nil;
        return msg;
    }
      moreURL:nil]
     animated:YES];
}

- (void)systemMessageTableView:(UITableView *)view willDeletePathWithIndexSet:(nonnull NSIndexSet *)set showPresent:(nonnull void (^)(BOOL))needCancel {
    // 是否需要删
    NSArray <SystemMessage *> *ary = [self.sysMsgModel.msgAry objectsAtIndexes:set];
    NSInteger notReadCount = 0;
    for (SystemMessage *msg in ary) {
        notReadCount += !msg.hadRead;
    }
    // PC
    MessagePresentController *pc = [[MessagePresentController alloc] init];
    if (notReadCount == 0) {
        // 0:确定要删除选中ary.count条信息吗
        [pc addDetail:[NSString stringWithFormat:@"确定要删除选中%ld条信息吗", ary.count]];
    } else if (notReadCount == 1 && ary.count == 1) {
        // 1:此条消息未读\n确定删除此消息吗
        [pc addTitle:@"此条消息未读"
           textColor:
         [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1]
                               darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]]];
        
        [pc addDetail:@"确定删除此消息吗"];
    } else {
        // ♾️:选中的信息包含notReadCount条未读信息，\n确定删除选中的ary.count条消息吗？
        
        [pc addTitle:[NSString stringWithFormat:@"选中的信息包含%ld条未读信息,", notReadCount]
           textColor:
         [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4944E3" alpha:1]
                               darkColor:[UIColor colorWithHexString:@"#9A97FF" alpha:1]]];
        
        [pc addDetail:[NSString stringWithFormat:@"确定删除选中的%ld条消息吗？ ", ary.count]];
    }
    [pc addDismiss:needCancel];
    [self.navigationController presentViewController:pc animated:NO completion:nil];
}

- (void)systemMessageTableView:(UITableView *)view mustDeletePathsWithIndexSet:(NSIndexSet *)set {
    // 直接删
    [self.sysMsgModel
     requestRemoveForIndexSet:set success:^{
        // 成功什么都可以不用做
    }
     failure:^(NSError *error) {
        // 失败去跳转，其实也没啥
    }];
}

- (void)systemMessageTableView:(UITableView *)view hadReadForIndex:(NSInteger)index {
    // 直接已读
    [self.sysMsgModel
     requestReadForIndexSet:[NSIndexSet indexSetWithIndex:index]
     success:^{
        // 成功什么都可以不用做
    }
     failure:^(NSError *error) {
        // 失败去跳转，其实也没啥
    }];
    
    BOOL needBall = NO;
    for (SystemMessage *msg in self.sysMsgModel.msgAry) {
        needBall |= !msg.hadRead;
    }
    if (!needBall && self.delegate) {
        [self.delegate systemMessageVC_hadReadAllMsg:self];
    }
    
    SystemMessageCell *cell = [view cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]];
    cell.hadRead = YES;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sysMsgModel.msgAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemMessage *model = self.sysMsgModel.msgAry[indexPath.section];
    
    SystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:SystemMessageCellReuseIdentifier forIndexPath:indexPath];
    
    [cell drawWithTitle:model.title
                content:model.content
                   date:model.uploadDate];
    
    cell.hadRead = model.hadRead;
    
    return cell;
}

#pragma mark - Getter

- (SystemMessageView *)messageView {
    if (_messageView == nil) {
        _messageView = [[SystemMessageView alloc] initWithFrame:self.view.SuperFrame];
        _messageView.delegate = self;
    }
    return _messageView;
}

- (BOOL)isEditing {
    return self.messageView.isEditing;
}

#pragma mark - Setter

- (void)setIsEditing:(BOOL)isEditing {
    self.messageView.isEditing = isEditing;
}

@end
