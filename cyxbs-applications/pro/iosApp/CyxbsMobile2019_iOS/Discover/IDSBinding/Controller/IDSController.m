//
//  IDSController.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/7.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "IDSController.h"
#import "IdsBindingView.h"
#import "IdsBinding.h"

@interface IDSController ()<IdsBindingViewDelegate>
@property(nonatomic, strong)IdsBindingView *idsBindgView;
@property (nonatomic, strong) IdsBinding * idsBindingModel;//ids绑定
@property (nonatomic, strong) MBProgressHUD *loadHud;
@end

@implementation IDSController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.idsBindgView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(idsBindingSuccess) name:@"IdsBinding_Success" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(idsBindingError) name:@"IdsBinding_Error" object:nil];
}

-(void)idsBindingSuccess {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

-(void)idsBindingError {
    [self.loadHud hide:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.idsBindgView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"绑定失败";
    [hud hide:YES afterDelay:1.0];
}

//MARK: - IdsBindingViewDelegate
- (void)touchBindingButton {
    NSString *bindingNum = [NSString stringWithString:self.idsBindgView.accountfield.text];
    NSString *bindingPasswd = [NSString stringWithString:self.idsBindgView.passTextfield.text];
    if(![bindingNum isEqual: @""] && ![bindingPasswd isEqual: @""]) {
        self.loadHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.loadHud.labelText = @"正在验证";
        IdsBinding *binding = [[IdsBinding alloc]initWithIdsNum:bindingNum isPassword:bindingPasswd];
        [binding fetchData];
    }else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.idsBindgView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入统一认证码和密码呦～";
        [hud hide:YES afterDelay:2.0];
    }
}
- (IdsBindingView *)idsBindgView{
    if (!_idsBindgView) {
        _idsBindgView = [[IdsBindingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _idsBindgView.delegate = self;
    }
    return _idsBindgView;
}

#pragma mark - RisingRouterHandler

+ (NSArray<NSString *> *)routerPath {
    return @[
        @"IDSController"
    ];
}

+ (void)responseRequest:(RisingRouterRequest *)request completion:(RisingRouterResponseBlock)completion {
    
    RisingRouterResponse *response = [[RisingRouterResponse alloc] init];
    
    switch (request.requestType) {
        case RouterRequestPush: {
            
            UINavigationController *nav = (request.requestController ? request.requestController : RisingRouterRequest.useTopController).navigationController;
            
            if (nav) {
                IDSController *vc = [[self alloc] init];
                response.responseController = vc;
                
                [nav pushViewController:vc animated:YES];
            } else {
                
                response.errorCode = RouterWithoutNavagation;
            }
            
        } break;
            
        case RouterRequestParameters: {
            // TODO: 传回参数
        } break;
            
        case RouterRequestController: {
            
            IDSController *vc = [[self alloc] init];
            
            response.responseController = vc;
        } break;
    }
    
    if (completion) {
        completion(response);
    }
}



@end
