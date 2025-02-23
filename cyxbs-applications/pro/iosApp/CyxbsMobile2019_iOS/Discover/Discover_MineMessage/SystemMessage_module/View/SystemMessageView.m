//
//  SystemMessageView.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/18.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SystemMessageView.h"

#pragma mark - SystemMessageView ()

@interface SystemMessageView () <
    UITableViewDelegate
>

/// 主Table，用于展示数据
@property (nonatomic, strong) UITableView *mainTableView;

/// 取消多选按钮
@property (nonatomic, strong) UIButton *cancelBtn;

/// 删除多选按钮
@property (nonatomic, strong) UIButton *deleteBtn;

@end

#pragma mark - SystemMessageView

@implementation SystemMessageView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mainTableView];
    }
    return self;
}

#pragma mark - Method

- (void)reloadData {
    [self closeEdit];
    [self.mainTableView reloadData];
}

- (void)openEdit {
    // 长按开启编辑
    if (!self.mainTableView.editing) {
        [self.mainTableView setEditing:YES animated:YES];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.deleteBtn];
        self.mainTableView.contentInset =
        UIEdgeInsetsMake(self.mainTableView.contentInset.top, 0, 128, 0);
    }
}

- (void)deleteMsgWithIndexSet:(NSIndexSet *)set withWarn:(BOOL)hadWarn {
    // 询问是否需要删，要删则官方动画删除
    if (self.delegate) {
        if (hadWarn) {
            [self.delegate systemMessageTableView:self.mainTableView willDeletePathWithIndexSet:set showPresent:^(BOOL cancel) {
                if (!cancel) {
                    [self deleteMsgWithIndexSet:set];
                }
            }];
        } else {
            [self deleteMsgWithIndexSet:set];
        }
    }
}

- (void)deleteMsgWithIndexSet:(NSIndexSet *)set {
    if (self.delegate) {
        [self.mainTableView beginUpdates];
        
        [self.delegate systemMessageTableView:self.mainTableView mustDeletePathsWithIndexSet:set];
        
        [self.mainTableView deleteSections:set withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.mainTableView endUpdates];
        
        [self closeEdit];
    }
}

// MARK: SEL

- (void)messageViewLongPress:(UILongPressGestureRecognizer *)longp {
    if (longp.state == UIGestureRecognizerStateBegan) {
        // 长按开启编辑
        [self openEdit];
    }
}

- (void)deleteBtnSelected:(UIButton *)btn {
    if (self.mainTableView.isEditing && self.delegate) {
        // 将选中的 indexPaths 转为 indexSet
        NSMutableIndexSet *set = NSMutableIndexSet.indexSet;
        for (NSIndexPath *indexPath in self.mainTableView.indexPathsForSelectedRows) {
            [set addIndex:indexPath.section];
        }
        // 询问是否需要删，要删则官方动画删除
        [self deleteMsgWithIndexSet:set withWarn:YES];
    }
}

- (void)closeEdit {
    // 关闭编辑
    [self.mainTableView setEditing:NO animated:YES];
    [self.cancelBtn removeFromSuperview];
    [self.deleteBtn removeFromSuperview];
    self.mainTableView.contentInset =
    UIEdgeInsetsMake(self.mainTableView.contentInset.top, 0, 0, 0);
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section ? 26 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.isEditing ?
    UITableViewCellEditingStyleDelete |
    UITableViewCellEditingStyleInsert :
    UITableViewCellEditingStyleDelete;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 一个删除Action
    UIContextualAction *deleteRowAction =
    [UIContextualAction
     contextualActionWithStyle:UIContextualActionStyleDestructive
     title:nil
     handler:^(UIContextualAction * _Nonnull action,
               __kindof UIView * _Nonnull sourceView,
               void (^ _Nonnull completionHandler)(BOOL)) {
        
        [self deleteMsgWithIndexSet:[NSIndexSet indexSetWithIndex:indexPath.section]
                           withWarn:YES];

        completionHandler(YES);
    }];
    deleteRowAction.image = [UIImage imageNamed:@"垃圾桶"];
    deleteRowAction.backgroundColor = [UIColor xFF_R:74 G:68 B:288 Alpha:1];

    UISwipeActionsConfiguration *config =
    [UISwipeActionsConfiguration
     configurationWithActions:@[deleteRowAction]];
    config.performsFirstActionWithFullSwipe = NO;

    return config;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 没开启编辑时才做跳转，开启编辑则系统
    if (!tableView.isEditing && self.delegate) {
        // 通知已读
        [self.delegate systemMessageTableView:self.mainTableView hadReadForIndex:indexPath.section];
        // 选中
        [self.delegate systemMessageTableView:self.mainTableView didSelectedAtIndex:indexPath.section];
    }
}

#pragma mark - Getter

- (UITableView *)mainTableView {
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.SuperFrame style:UITableViewStylePlain];
        _mainTableView.backgroundColor = UIColor.clearColor;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerClass:SystemMessageCell.class forCellReuseIdentifier:SystemMessageCellReuseIdentifier];
        _mainTableView.delegate = self;
        _mainTableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        // 长按触发多选
        UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(messageViewLongPress:)];
        [self.mainTableView addGestureRecognizer:longP];
    }
    return _mainTableView;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        CGFloat gap = (self.width - 2 * 120) / 3;
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(gap, 0, 120, 40)];
        _cancelBtn.bottom = self.SuperBottom - 64;
        
        _cancelBtn.layer.cornerRadius = _cancelBtn.height / 2;
        _cancelBtn.clipsToBounds = YES;
        
        _cancelBtn.backgroundColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#C3D4EE" alpha:1]
                              darkColor:[UIColor colorWithHexString:@"#484848" alpha:1]];
        
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont fontWithName:PingFangSC size:18];
        _cancelBtn.titleLabel.textColor = UIColor.whiteColor;
        [_cancelBtn addTarget:self action:@selector(closeEdit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)deleteBtn {
    if (_deleteBtn == nil) {
        CGFloat gap = (self.width - 2 * 120) / 3;
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.cancelBtn.top, 120, 40)];
        _deleteBtn.right = self.SuperRight - gap;
        
        _deleteBtn.layer.cornerRadius = _deleteBtn.height / 2;
        _deleteBtn.clipsToBounds = YES;
        
        _deleteBtn.backgroundColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4A44E4" alpha:1] darkColor:[UIColor colorWithHexString:@"#5852FF" alpha:1]];
        
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont fontWithName:PingFangSC size:18];
        _deleteBtn.titleLabel.textColor = UIColor.whiteColor;
        [_deleteBtn addTarget:self action:@selector(deleteBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (BOOL)isEditing {
    return self.mainTableView.isEditing;
}

#pragma mark - Setter

- (void)setDelegate:(id<SystemMessageViewDelegate>)delegate {
    if (delegate) {
        self.mainTableView.dataSource = delegate;
        _delegate = delegate;
    }
}

- (void)setIsEditing:(BOOL)isEditing {
    isEditing ? [self openEdit] : [self closeEdit];
}

@end
