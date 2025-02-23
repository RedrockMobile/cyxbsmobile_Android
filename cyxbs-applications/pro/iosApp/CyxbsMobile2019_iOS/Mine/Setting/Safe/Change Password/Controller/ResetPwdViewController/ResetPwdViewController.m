//
//  ResetPwdViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/27.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "ResetPwdView.h"
#import "changePassword.h"
#import <MBProgressHUD.h>
#import <Masonry.h>

@interface ResetPwdViewController ()<ResetpwdViewDelegate>
@property (nonatomic, strong) UILabel *emptyLab1;
@property (nonatomic, strong) UILabel *emptyLab2;
@property (nonatomic, strong) MBProgressHUD *successfulHud;
@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    if (@available(iOS 11.0, *)) {
        self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NoNetWorkToChangePassword) name:@"NoNetWorkToChangePassword" object:nil];
    ResetPwdView *resetView = [[ResetPwdView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    resetView.delegate = self;
    resetView.placeholder1Error.hidden = YES;
    resetView.placeholder1Empty.hidden = YES;
    resetView.placeholder2Error.hidden = YES;
    resetView.placeholder2Empty.hidden = YES;
    [self.view addSubview:resetView];
    _resetView = resetView;
}

#pragma mark - ResetView的代理

///返回按钮的点击事件
- (void)backButtonClicked {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

///点击下一步按钮后，进行以下下判断，出现相应的提示文字
- (void)ClickedNext {
    if (_resetView.passwordField1.text.length == 0) {
        [self placeholderShowEmpty1:NO AndEmpty2:YES AndError1:YES AndError:YES];
    }else if (_resetView.passwordField2.text.length == 0) {
        [self placeholderShowEmpty1:YES AndEmpty2:NO AndError1:YES AndError:YES];
    }else if (_resetView.passwordField1.text.length == 0 && _resetView.passwordField2.text.length == 0) {
        [self placeholderShowEmpty1:NO AndEmpty2:NO AndError1:YES AndError:YES];
    }else if (_resetView.passwordField1.text.length < 6 && _resetView.passwordField1.text.length > 0) {
        [self placeholderShowEmpty1:YES AndEmpty2:YES AndError1:NO AndError:YES];
    }else if (_resetView.passwordField2.text.length < 6 && _resetView.passwordField2.text.length > 0) {
        [self placeholderShowEmpty1:YES AndEmpty2:YES AndError1:YES AndError:NO];
    }else if (_resetView.passwordField2.text.length < 6 && _resetView.passwordField2.text.length > 0 && _resetView.passwordField1.text.length < 6 && _resetView.passwordField1.text.length > 0) {
        [self placeholderShowEmpty1:YES AndEmpty2:YES AndError1:NO AndError:NO];
    }else if (![_resetView.passwordField1.text isEqual:_resetView.passwordField2.text]) {
        [self placeholderShowEmpty1:YES AndEmpty2:YES AndError1:YES AndError:NO];
    }else {
        [self placeholderShowEmpty1:YES AndEmpty2:YES AndError1:YES AndError:YES];
        [self changePasswordWithNewPwd:_resetView.passwordField1.text];
    }
}

///提示文字的隐藏判断
- (void)placeholderShowEmpty1:(BOOL)empty1 AndEmpty2:(BOOL)empty2 AndError1:(BOOL) error1 AndError:(BOOL)error2 {
    _resetView.placeholder1Empty.hidden = empty1;
    _resetView.placeholder2Empty.hidden = empty2;
    _resetView.placeholder1Error.hidden = error1;
    _resetView.placeholder2Error.hidden = error2;
}

- (UILabel *)creatLabelWithText:(NSString *)text AndFont:(UIFont *)font AndTextColor:(UIColor *)color {
    UILabel *lab = [[UILabel alloc] init];
    lab.font = font;
    lab.text = text;
    lab.textColor = color;
    return lab;
}

///将新密码传到后端，并更新缓存
- (void)changePasswordWithNewPwd:(NSString *)password {
    changePassword *model = [[changePassword alloc] init];
    [model changePasswordWithNewPassword:password :self.stuID :self.changeCode];
    [model setBlock:^(id  _Nonnull info) {
        if ([info[@"status"] isEqualToNumber:[NSNumber numberWithInt:10000]]) {
            ///修改密码成功
            NSLog(@"修改密码成功");
            [self updatePassword];
            [self changePasswordSuccessful];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else if ([info[@"status"] isEqualToNumber:[NSNumber numberWithInt:10004]]) {
            ///密码格式有问题
            [self PasswordIsIllegal];
        }else if ([info[@"status"] isEqualToNumber:[NSNumber numberWithInt:10020]]) {
            ///新旧密码重复
            [self PasswordIsRepate];
        }
    }];
}

///更新密码的缓存
- (void)updatePassword {
    [NSUserDefaults.standardUserDefaults setValue:_resetView.passwordField1.text forKey:@"idNum"];
}

///弹窗：提示修改成功
- (void)changePasswordSuccessful{
    self.successfulHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.successfulHud.mode = MBProgressHUDModeText;
    self.successfulHud.detailsLabelText = @"重置密码成功！由于账号互通，重邮帮小程序的密码也会一起更改哦~";
    [self.successfulHud hide:YES afterDelay:1.2];
    [self.successfulHud setYOffset:-SCREEN_HEIGHT * 0.3704];
    [self.successfulHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}

///弹窗：提示密码格式有问题
- (void)PasswordIsIllegal{
    MBProgressHUD *illegalHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    illegalHud.mode = MBProgressHUDModeText;
    illegalHud.labelText = @"密码格式有问题，请重新设置吧~";
    [illegalHud hide:YES afterDelay:1.2];
    [illegalHud setYOffset:-SCREEN_HEIGHT * 0.3704];
    [illegalHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}

///弹窗：提示新旧密码重复
- (void)PasswordIsRepate{
    MBProgressHUD *repateHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    repateHud.mode = MBProgressHUDModeText;
    repateHud.labelText = @"新旧密码不能重复，请重新设置吧~";
    [repateHud hide:YES afterDelay:1.2];
    [repateHud setYOffset:-SCREEN_HEIGHT * 0.3704];
    [repateHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}

///弹窗：提示没有网络，无法更改密码
- (void)NoNetWorkToChangePassword {
    MBProgressHUD *noNetHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    noNetHud.mode = MBProgressHUDModeText;
    noNetHud.labelText = @"没有网络，请检查网络连接";
    [noNetHud hide:YES afterDelay:1.2];
    [noNetHud setYOffset:-SCREEN_HEIGHT * 0.3704];
    [noNetHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}





@end
