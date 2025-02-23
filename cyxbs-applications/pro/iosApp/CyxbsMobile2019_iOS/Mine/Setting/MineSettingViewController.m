//
//  MineSettingViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/12/14.
//  Copyright © 2020 Redrock. All rights reserved.
//在我的页面点击 “设置” 后 push出来的就是这个控制器

#import "MineSettingViewController.h"
#import "selfSafeViewController.h"
#import "QuitTipView.h"
#import <UserNotifications/UserNotifications.h>


@interface MineSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

/// tableView
@property(nonatomic,strong)UITableView *tableView;

/// cell标题字符串数组
@property(nonatomic,strong)NSArray <NSString*>* cellTitleStrArr;

/// 退出登录按钮
@property(nonatomic,strong)UIButton *quitBtn;

/// 点击“退出登录按钮”后弹出的提示弹窗
@property(nonatomic,strong)QuitTipView *quitTipView;
@end

@implementation MineSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F7F8FB" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
    } else {
        self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:252/255.0 alpha:1];
    }
    self.cellTitleStrArr = @[@"启动APP时最先显示课表页面", @"上课前提醒我", @"每天晚上推送课表给我", @"账号与安全"];
    
    [NSUserDefaults.standardUserDefaults removeObjectForKey:@"zxsd"];
    //父类是TopBarBasicViewController，调用父类的vcTitleStr的set方法，自动完成顶部的bar的设置
    self.VCTitleStr = @"设置";
//    [self addTitleBar];
    [self addTableView];
    [self addQuitBtn];
}


//MARK: - 重写的方法：
- (UIView *)quitTipView{
    if(_quitTipView==nil){
        _quitTipView = [[QuitTipView alloc] init];
    }
    return _quitTipView;
}

//MARK: - UI布局方法：

/// 添加tableView
- (void)addTableView{
    UITableView *tableView = [[UITableView alloc] init];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topBarView.mas_bottom);
    }];
    
    [tableView setScrollEnabled:NO];
    tableView.rowHeight = 55;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.backgroundColor = self.view.backgroundColor;
    
    
    tableView.delegate = self;
    tableView.dataSource = self;
}

/// 添加退出登录按钮
- (void)addQuitBtn {
    UIButton *btn = [[UIButton alloc] init];
    self.quitBtn = btn;
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0.2523*SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(-0.2176*SCREEN_HEIGHT);
        make.width.mas_equalTo(0.4933*SCREEN_WIDTH);
        make.height.mas_equalTo(40.0125*HScaleRate_SE);
    }];
    
    btn.layer.cornerRadius = 20.006*HScaleRate_SE;
    
    btn.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:18*fontSizeScaleRate_SE];
    
    [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    [btn setTitle:@"退 出 登 录" forState:UIControlStateNormal];
    
   
    btn.backgroundColor = [UIColor colorWithRed:72/255.0 green:65/255.0 blue:226/255.0 alpha:1];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(quitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}


//MARK:- UITableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellTitleStrArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MineSettingViewController_CellID"];
    
    cell.textLabel.text = self.cellTitleStrArr[indexPath.row];
    cell.backgroundColor = tableView.backgroundColor;
    cell.textLabel.font = [UIFont fontWithName:PingFangSCRegular size:15*fontSizeScaleRate_SE];
//    [UIFont systemFontOfSize:15*fontSizeScaleRate_SE];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (@available(iOS 11.0, *)) {
        
        cell.textLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#193866" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF2" alpha:1]];
    } else {
        cell.textLabel.textColor = [UIColor colorWithRed:25/255.0 green:56/255.0 blue:102/255.0 alpha:1];
    }
    if(indexPath.row < 3){
        UISwitch *settingSwitch = [self getSwitch];
        SEL s;
        switch (indexPath.row) {
            case 0:
                s = @selector(switchedLaunchingWithClassScheduleView:);
            settingSwitch.on = ![NSUserDefaults.standardUserDefaults valueForKey:@"PRSENT_SCHEDULE_WHEN_OPEN_APP"];
                break;
            case 1:
                s = @selector(switchedRemindBeforeClass:);
                break;
            case 2:
                s = @selector(switchedRemindEveryDay:);
                break;
            default:
                s = NULL;
                break;
        }
        if(indexPath.row==0){
            
        }else{
            
        }
        [settingSwitch addTarget:self action:s forControlEvents:UIControlEventValueChanged];
        [cell setAccessoryView:settingSwitch];
    }else{
        [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60* HScaleRate_SE;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 3:
            [self selectedSafeCell];
            break;
        default:
            break;
    }

}


//MARK:- 按钮、cell选中后调用的方法：

//选中 “账号与安全” cell 后调用
- (void)selectedSafeCell {
    selfSafeViewController *vc = [[selfSafeViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/// 滑动 “每天推送课表”开关后调用
/// @param sender 开关
- (void)switchedRemindEveryDay:(UISwitch *)sender {
    if (sender.on) {            // 打开开关
//        [UserDefaultTool saveValue:@"test" forKey:@"Mine_RemindEveryDay"];
    } else {                    // 关闭开关
        
        NSArray *idStrArr = @[@"每天晚上推送课表0",@"每天晚上推送课表1",@"每天晚上推送课表2",
                              @"每天晚上推送课表3",@"每天晚上推送课表4",@"每天晚上推送课表5",
                              @"每天晚上推送课表6",];
        //移除已发送的通知
        [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:idStrArr];
        
        //移除未发送的通知
        [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:idStrArr];
        
        [NSUserDefaults.standardUserDefaults removeObjectForKey:@"Mine_RemindEveryDay"];
        [NSUserDefaults.standardUserDefaults synchronize];
    }
}

/// 退出登录按钮点击后调用
/// @param sender 退出登录按钮
- (void)quitButtonClicked:(UIButton *)sender {
    [self.view addSubview:self.quitTipView];
}

/// 滑动 “课前提醒”开关后调用
/// @param sender 开关
- (void)switchedRemindBeforeClass:(UISwitch *)sender{
    if (sender.on) {            // 打开开关
//        [UserDefaultTool saveValue:@"test" forKey:@"Mine_RemindBeforeClass"];
        //通知WYCClassBookViewController要课前提醒
        [[NSNotificationCenter defaultCenter] postNotificationName:@"remindBeforeClass" object:nil];
    } else {                    // 关闭开关
        [NSUserDefaults.standardUserDefaults removeObjectForKey:@"Mine_RemindBeforeClass"];
        [NSUserDefaults.standardUserDefaults synchronize];
        //通知WYCClassBookViewController不要课前提醒
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notRemindBeforeClass" object:nil];
    }
}

/// 滑动 “启动时优先显示课表” 开关后调用
/// @param sender 开关
- (void)switchedLaunchingWithClassScheduleView:(UISwitch *)sender {
    BOOL presentScheduleWhenOpenApp = sender.on;
    [[NSUserDefaults standardUserDefaults] setBool:presentScheduleWhenOpenApp forKey:@"PRSENT_SCHEDULE_WHEN_OPEN_APP"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




//MARK:-其他方法：

/// 获取一个开关
- (UISwitch*)getSwitch{
    UISwitch *settingSwitch = [[UISwitch alloc] init];
    settingSwitch.frame = CGRectMake(MAIN_SCREEN_W - 80, 11.5, 53, 27);
    if (@available(iOS 11.0, *)) {
        settingSwitch.onTintColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2927D0" alpha:1] darkColor:[UIColor colorWithHexString:@"#465FFF" alpha:1]];
        settingSwitch.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#C3D3EE" alpha:1] darkColor:[UIColor colorWithHexString:@"#2F2F2F" alpha:1]];
    } else {
        settingSwitch.onTintColor = [UIColor colorWithRed:41/255.0 green:33/255.0 blue:214/255.0 alpha:1.0];
        settingSwitch.backgroundColor = [UIColor colorWithRed:195/255.0 green:212/255.0 blue:238/255.0 alpha:1.0];
    }
    settingSwitch.layer.cornerRadius = settingSwitch.height / 2.0;
    
    return settingSwitch;
}

@end
