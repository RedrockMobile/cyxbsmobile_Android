//
//  sendCodeViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/11/3.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "sendCodeViewController.h"
#import "sendCodeView.h"
#import "sendCodeModel.h"
#import <MBProgressHUD.h>

@interface sendCodeViewController ()<sendCodeDelegate>

@property (nonatomic, strong) sendCodeView *sendcodeview;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) MBProgressHUD *failureHud;
@property (nonatomic, strong) MBProgressHUD *successHud;

@end

@implementation sendCodeViewController

- (instancetype)initWithExpireTime:(NSString *)time {
    if ([super init]) {
        self.time = time;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NoNetWorkToBindingEmail) name:@"NoNetWorkToBindingEmail" object:nil];
    sendCodeView *sendcodeview = [[sendCodeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    sendcodeview.delegate  = self;
    sendcodeview.sendCodeLab.text = [[NSString alloc] initWithFormat:@"%@%@%@",@"掌邮向你的邮箱",_sendCodeToEmialLabel,@"发送了验证码"];
    [self.view addSubview:sendcodeview];
    _sendcodeview = sendcodeview;
    
    _sendcodeview.resend.userInteractionEnabled = NO;
    [self performSelectorInBackground:@selector(Thread) withObject:nil];
}

#pragma mark - 发送验证码页面的代理方法
- (void)ClickedContactUS {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"570919844";
    
    UIAlertController *feedBackGroupAllert = [UIAlertController alertControllerWithTitle:@"欢迎加入反馈群" message:@"群号已复制到剪切板，快去QQ搜索吧～" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *certainAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
    
    [feedBackGroupAllert addAction:certainAction];
    
    [self presentViewController:feedBackGroupAllert animated:YES completion:nil];
}

- (void)ClickedSure {
    if ([[self getNowTimeTimestamp] longValue] <= [self.time longValue]) {
        sendCodeModel *model = [[sendCodeModel alloc] init];
        [model sendCode:_sendcodeview.codeField.text ToEmail:_sendCodeToEmialLabel];
        [model setBlock:^(id  _Nonnull info) {
            if ([info[@"status"] isEqualToNumber:[NSNumber numberWithInt:10000]]) {
                [self sendCodeSuccessful];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }else if ([info[@"status"] isEqualToNumber:[NSNumber numberWithInt:10007]]) {
                [self codeWrong];
            }
        }];
    }else {
        [self sendCodeFailure];
    }
    
}

- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)ClickedResend {
    ///设置倒计时
    NSDictionary *dic = @{@"email":_sendCodeToEmialLabel};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendCodeToEmailAgain" object:nil userInfo:dic];
    [self performSelectorInBackground:@selector(Thread) withObject:nil];
}

///倒计时的方法
- (void)Thread
{
    for(int i=60;i>=0;i--) {
        _count = i;
        // 回调主线程
        [self performSelectorOnMainThread:@selector(showResendTitle) withObject:nil waitUntilDone:YES];
        sleep(1);
    }
}

- (void)showResendTitle {
    _sendcodeview.resend.text = [NSString stringWithFormat:@"%@%d%@",@"正在发送(",_count,@")"];
    if (_count==0) {
        _sendcodeview.resend.text = @"重新发送";
        _sendcodeview.resend.userInteractionEnabled = YES;
    }else {
        _sendcodeview.resend.userInteractionEnabled = NO;
    }
}

///弹窗：提示成功
- (void)sendCodeSuccessful {
//    self.successHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    self.successHud.mode = MBProgressHUDModeText;
//    self.successHud.label.text = @"验证成功";
//
//    [self.successHud hide:YES afterDelay:1.2];
//    [self.successHud setYOffset:-SCREEN_HEIGHT * 0.3704];
//    [self.successHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}

///弹窗：提示失败
- (void)sendCodeFailure{
//    self.failureHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    self.failureHud.mode = MBProgressHUDModeText;
//    self.failureHud.labelText = @"验证码已失效";
//    [self.failureHud hide:YES afterDelay:1.2];
//    [self.failureHud setYOffset:-SCREEN_HEIGHT * 0.3704];
//    [self.failureHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
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

///弹窗：验证码错误
- (void)codeWrong {
//    MBProgressHUD *codeWrongHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    codeWrongHud.mode = MBProgressHUDModeText;
//    codeWrongHud.labelText = @"验证码错误";
//    [codeWrongHud hide:YES afterDelay:1.2];
//    [codeWrongHud setYOffset:-SCREEN_HEIGHT * 0.3704];
//    [codeWrongHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}

- (NSString *)getNowTimeTimestamp {
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f",a];
    return timeString;
}




@end
