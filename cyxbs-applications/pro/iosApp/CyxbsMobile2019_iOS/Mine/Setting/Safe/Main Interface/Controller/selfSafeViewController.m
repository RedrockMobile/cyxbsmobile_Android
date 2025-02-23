//
//  selfSafeViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/27.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "selfSafeViewController.h"
#import "SelfSafeView.h"
#import "ChangePwdViewController.h"
#import "ResetPwdViewController.h"
#import "SetQuestionViewController.h"
#import "setEmailViewController.h"
#import "setEmailViewController.h"
#import "safePopView.h"
#import "questionAndEmail.h"

@interface selfSafeViewController ()<SelfSafeViewDelegate,safePopViewDelegate>
@property (nonatomic, strong) safePopView *popView;

@property (nonatomic, strong) NSNumber *question_is;
@property (nonatomic, strong) NSNumber *email_is;
@end

@implementation selfSafeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SelfSafeView *safeView = [[SelfSafeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    safeView.delegate = self;
    [self.view addSubview:safeView];
    
    ///如果未绑定邮箱或者设置密保，则弹出次页面
    [self isBingind];
}

///设置提示绑定邮箱和设置密保的弹窗
- (void)setAlertView {
    safePopView *popView = [[safePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    popView.delegate = self;
    [self.view addSubview:popView];
    _popView = popView;
}

#pragma mark - safeView的代理方法
///点击返回按钮
- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

///点击修改密码
- (void)selectedChangePassword {
    ChangePwdViewController *changePwdVC = [[ChangePwdViewController alloc] init];
    [self.navigationController pushViewController:changePwdVC animated:YES];
}

///点击修改密保
- (void)selectedChangeQuestion {
    SetQuestionViewController *setquestionVC = [[SetQuestionViewController alloc] init];
    [self.navigationController pushViewController:setquestionVC animated:YES];
}

///点击修改绑定邮箱
- (void)selectedChangeEmail {
    setEmailViewController *setEmailVC = [[setEmailViewController alloc] init];
    [self.navigationController pushViewController:setEmailVC animated:YES];
}


///判断是否已经绑定过邮箱了
- (void)isBingind {
    questionAndEmail *model = [[questionAndEmail alloc] init];
    [model isBindEmailAndQuestion];
    [model setBlock:^(id  _Nonnull info) {
        if ([info[@"status"] isEqualToNumber:[NSNumber numberWithInt:10000]]) {
            self->_question_is = info[@"data"][@"question_is"];
            self->_email_is = info[@"data"][@"email_is"];
            if ([self->_question_is intValue] == 0 || [self->_email_is intValue] == 0) {
                [self setAlertView];
            }
        }
    }];
}

#pragma mark - popView的代理方法
///点击旁边弹窗消失
- (void)dismissAlertView {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_popView removeFromSuperview];
    }];
}

///进入设置问题界面
- (void)setQuestion {
    SetQuestionViewController *setquestionVC = [[SetQuestionViewController alloc] init];
    [self.navigationController pushViewController:setquestionVC animated:YES];
    [self dismissAlertView];
}

///进入设置邮箱界面
- (void)setEmail {
    setEmailViewController *setEmailVC = [[setEmailViewController alloc] init];
    [self.navigationController pushViewController:setEmailVC animated:YES];
    [self dismissAlertView];
}


@end
