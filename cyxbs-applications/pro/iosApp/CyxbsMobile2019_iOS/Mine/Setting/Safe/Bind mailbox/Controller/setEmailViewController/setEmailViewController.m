//
//  setEmailViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/29.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "setEmailViewController.h"
#import "setEmail.h"
#import "sendEmailModel.h"
#import "sendCodeViewController.h"

@interface setEmailViewController ()<setEmailDelegate>
@property (nonatomic,strong) setEmail *setEmailView;
@property (nonatomic,assign) int count;
@property (nonatomic, assign) BOOL isConnected;


@end

@implementation setEmailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setEmail *setEmailView = [[setEmail alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self checkNetWorkTrans];
    setEmailView.delegate = self;
    setEmailView.placeholderLab.hidden = YES;
    [self.view addSubview:setEmailView];
    _setEmailView = setEmailView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reSendCodeToEmail:) name:@"sendCodeToEmailAgain" object:nil];
}


- (void)ClickedContactUS {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"570919844";
    
    UIAlertController *feedBackGroupAllert = [UIAlertController alertControllerWithTitle:@"欢迎加入反馈群" message:@"群号已复制到剪切板，快去QQ搜索吧～" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *certainAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
    
    [feedBackGroupAllert addAction:certainAction];
    
    [self presentViewController:feedBackGroupAllert animated:YES completion:nil];
}
- (void)checkNetWorkTrans {
    AFNetworkReachabilityManager *managerAF = [AFNetworkReachabilityManager sharedManager];
    [managerAF startMonitoring];
    [managerAF setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self->_isConnected = true;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self->_isConnected = true;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self->_isConnected = true;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self->_isConnected = false;
                break;
        }
    }];
}


- (void)ClickedNext {
    if (self.isConnected == NO) {
        [self NoNetWorkToBindingEmail];
    }else {
        if ([_setEmailView.emailField.text rangeOfString:@"@"].location == NSNotFound || _setEmailView.emailField.text.length == 0) {
            _setEmailView.placeholderLab.hidden = NO;
        } else {
            _setEmailView.placeholderLab.hidden = YES;
            [self sendCodeToEmail];
        }
    }
}

- (void)sendCodeToEmail {
    sendEmailModel *model = [[sendEmailModel alloc] init];
    [model sendEmail:_setEmailView.emailField.text];
    [model setBlock:^(id  _Nonnull info) {
        if ([info[@"status"] isEqualToNumber:[NSNumber numberWithInt:10000]]) {
            NSDictionary *dic = info[@"data"];
            sendCodeViewController *sendCodeVC = [[sendCodeViewController alloc] initWithExpireTime:dic[@"expired_time"]];
            sendCodeVC.sendCodeToEmialLabel = self->_setEmailView.emailField.text;
            [self.navigationController pushViewController:sendCodeVC animated:YES];
        }else if ([info[@"status"] isEqual:[NSNumber numberWithInt:10022]]) {
            [self EmailPatternWrong];
        }else if ([info[@"status"] isEqual:[NSNumber numberWithInt:10009]]) {
            
        }
    }];
}

- (void)reSendCodeToEmail:(NSNotification *)sender {
    sendEmailModel *model = [[sendEmailModel alloc] init];
    [model sendEmail:_setEmailView.emailField.text];
    [model setBlock:^(id  _Nonnull info) {
        if ([info[@"status"] isEqualToNumber:[NSNumber numberWithInt:10000]]) {
            NSLog(@"重新发送了验证码");
        }else {
            NSLog(@"重新发送验证码失败");
        }
    }];
}

- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}


///弹窗：提示没有网络，无法绑定邮箱
- (void)NoNetWorkToBindingEmail {
//    MBProgressHUD *noNetHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    noNetHud.mode = MBProgressHUDModeText;
//    noNetHud.labelText = @"没有网络，请检查网络连接";
//    [noNetHud hide:YES afterDelay:1.2];
//    [noNetHud setYOffset:-SCREEN_HEIGHT * 0.3704];
//    [noNetHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}

- (void)EmailPatternWrong {
//    MBProgressHUD *emailWrongHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    emailWrongHud.mode = MBProgressHUDModeText;
//    emailWrongHud.labelText = @"邮箱格式有问题";
//    [emailWrongHud hide:YES afterDelay:1.2];
//    [emailWrongHud setYOffset:-SCREEN_HEIGHT * 0.3704];
//    [emailWrongHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}

- (void)EmailLimited {
//    MBProgressHUD *emailLimited = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    emailLimited.mode = MBProgressHUDModeText;
//    emailLimited.labelText = @"今日发送次数已经用完~";
//    [emailLimited hide:YES afterDelay:1.2];
//    [emailLimited setYOffset:-SCREEN_HEIGHT * 0.3704];
//    [emailLimited setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}


@end
