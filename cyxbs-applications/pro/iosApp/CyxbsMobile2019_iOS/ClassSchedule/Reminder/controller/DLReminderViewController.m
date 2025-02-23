//
//  DLReminderViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/9.
//  Copyright © 2020 Redrock. All rights reserved.
//添加备忘的初始界面

#import "DLReminderViewController.h"
#import "DLReminderView.h"
#import "DLReminderSetDetailVC.h"
#import "DLHistodyButton.h"
#import "RemindNotification.h"
#import <Masonry.h>
#import <YYKit.h>
#define kRateX [UIScreen mainScreen].bounds.size.width/375   //以iPhoneX为基准
#define kRateY [UIScreen mainScreen].bounds.size.height/812  //以iPhoneX为基准
@interface DLReminderViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSString *inputString; //
@property (nonatomic, strong) NSMutableArray *buttonTitleArray;  //

//需要删除buttonTitleArray的endIndex
@property (nonatomic, strong) DLReminderView *reminderView;
@end

@implementation DLReminderViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonTitleArray = [@[@"自习", @"值班",@"会议",@"考试",@"作业",@"休息",@"补课",@"实验",@"复习",@"学习",] mutableCopy];
    [self.view addSubview: self.reminderView];
    [self loadHistoryButtons];
    [self.reminderView.nextBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.reminderView.textFiled.mas_bottom).mas_offset(204*kRateY);
        make.centerX.equalTo(self.reminderView.mas_centerX);
        make.width.mas_equalTo(66*kRateX);
        make.height.mas_equalTo(66*kRateX);
    }];
    
}
- (void)didClickNextButton:(UIButton *)button{
    if ([self.reminderView.textFiled.text isEqualToString:@""]
        ||self.reminderView.textFiled.text==nil) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setMode:(MBProgressHUDModeText)];
        hud.labelText = @"标题不能为空哟";
        [hud hide:YES afterDelay:1];
    }else{
        DLReminderSetDetailVC *vc = [[DLReminderSetDetailVC alloc] init];
        vc.remind = self.remind;
        vc.noticeString = self.reminderView.textFiled.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)didClickHistoryButton:(DLHistodyButton *)button{
    self.inputString = self.buttonTitleArray[button.tag];
    
    NSLog(@"%@",self.inputString);
    
    self.reminderView.textFiled.text = self.buttonTitleArray[button.tag];
}
- (void)back{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadHistoryButtons{
    NSInteger count = self.buttonTitleArray.count;
    int row,line;
    for (int i = 0; i < count; i++) {
        row = i/5;
        line = i%5;
        DLHistodyButton *button = [[DLHistodyButton alloc] init];
        [button setTitle:self.buttonTitleArray[i] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(didClickHistoryButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview: button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.reminderView.textFiled.mas_bottom).mas_offset(18 * kRateY+row*48*kRateY);
            make.left.equalTo(self.view.mas_left).mas_offset(20*kRateX+60*kRateX*line);
            make.width.mas_equalTo(0.1333*MAIN_SCREEN_W);
            make.height.mas_equalTo(0.08*MAIN_SCREEN_W);
        }];
    }
}

- (DLReminderView *)reminderView{
    if (!_reminderView) {
        _reminderView = [[DLReminderView alloc] init];
        _reminderView.frame = self.view.frame;
        _reminderView.titleLab.text = @"为你的行程添加 一个标题";
        _reminderView.textFiled.delegate = self;
        [_reminderView.nextBtn addTarget:self action:@selector(didClickNextButton:) forControlEvents:UIControlEventTouchUpInside];
        [_reminderView.backBtn addTarget: self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reminderView;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
