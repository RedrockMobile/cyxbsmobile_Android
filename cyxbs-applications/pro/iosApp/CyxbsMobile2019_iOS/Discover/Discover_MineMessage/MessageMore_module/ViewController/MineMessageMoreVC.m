//
//  MineMessageMoreVC.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/19.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "MineMessageMoreVC.h"

#import "MessageMoreCell.h"

#import "MessageMoreModel.h"

#pragma mark - MineMessageMoreVC ()

@interface MineMessageMoreVC () <
    UITableViewDelegate,
    UITableViewDataSource,
    UIPopoverPresentationControllerDelegate
>

/// 为了更好的扩展性，这里用tableView
@property (nonatomic, strong) UITableView *tableView;

/// 模型
@property (nonatomic, strong) NSArray <MessageMoreModel *> *moreModel;

/// 临时保存的size
@property (nonatomic) CGSize mainSize;

@end

#pragma mark - MineMessageMoreVC

@implementation MineMessageMoreVC

#pragma mark - Life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // > 设置弹出的控制器的显示样式
        self.modalPresentationStyle = UIModalPresentationPopover;
        // > 弹出模式
        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        self.preferredContentSize = self.view.size;
        
        UIPopoverPresentationController *popVC = self.popoverPresentationController;
        popVC.canOverlapSourceViewRect = NO;
        
        
        popVC.backgroundColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F2F1" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
        
        popVC.permittedArrowDirections = UIPopoverArrowDirectionUp;
        popVC.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.size = CGSizeMake(120, 40);
    self.preferredContentSize = self.view.size;
    self.view.backgroundColor = UIColor.clearColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 询问size
    UIPopoverPresentationController *popVC = self.popoverPresentationController;
    
    UIView *view = [popVC valueForKeyPath:@"popoverView"];
    [view.subviews.firstObject removeFromSuperview];
    
    // 问tag
    self.mainSize = CGSizeMake(self.view.width, (!popVC.sourceView.tag ? 120 : 80));
    self.view.size = self.mainSize;
    
    self.moreModel = (!popVC.sourceView.tag ?
                      MessageMoreModel.systemModels :
                      MessageMoreModel.activeModels);
    [self.view addSubview:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView
     animateWithDuration:0.2
     animations:^{
        self.preferredContentSize = self.mainSize;
    }];
    
    self.tableView.size = self.mainSize;
    self.tableView.bottom = self.view.SuperBottom;
}

#pragma mark - <UIPopoverPresentationControllerDelegate>

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 如果是设置，则取消小红点（之后可以封装）
    MessageMoreModel *model = self.moreModel[indexPath.row];
    if ([model.msgStr isEqualToString:@"设置"]) {
        MessageMoreCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.needBall = NO;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.delegate) {
        [self.delegate mineMessageMoreVC:self selectedTitle:model.msgStr];
    }
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.moreModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageMoreModel *model = self.moreModel[indexPath.row];
    MessageMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageMoreCellReuseIdentifier forIndexPath:indexPath];
    
    [cell
     drawImg:model.msgImg
     title:model.msgStr];
    
    if ([model.msgStr isEqualToString:@"设置"]) {
        cell.needBall = ![USER_DEFAULT boolForKey:MineMessage_hadSettle_BOOL];
    }
    
    return cell;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 13, 120, 60) style:UITableViewStylePlain];
        _tableView.layer.cornerRadius = 10;
        _tableView.clipsToBounds = YES;
        
        _tableView.backgroundColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]
                              darkColor:[UIColor colorWithHexString:@"#2C2C2C" alpha:1]];
        
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:MessageMoreCell.class forCellReuseIdentifier:MessageMoreCellReuseIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
