//
//  ElectricViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/4/12.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "ElectricFeeModel.h"
#import "ElectricityView.h"
#import "ElectricViewController.h"
#import "PickerDormitoryModel.h"
#import "PickerDormitoryViewController.h"

#import "RemindHUD.h"

@interface ElectricViewController ()

/// 电费View
@property (nonatomic, strong) ElectricityView *eleView;
/// 电费Model
@property (nonatomic, strong) ElectricFeeModel *elecModel;

@end

@implementation ElectricViewController

#pragma mark- life cicrle
- (void)viewWillAppear:(BOOL)animated {
    if ([UserItemTool defaultItem].room == nil &&[UserItemTool defaultItem].building == nil) {
        [self.eleView refreshViewIfNeeded];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    [self addEleView];
    [self requestData];
}

#pragma mark - Lazy
- (ElectricityView *)eleView {
    if (!_eleView) {
        _eleView = [[ElectricityView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 152)];
    }
    return _eleView;
}

- (ElectricFeeModel *)elecModel {
    if (!_elecModel) {
        _elecModel = [[ElectricFeeModel alloc] init];
    }
    return _elecModel;
}

#pragma mark - Method
- (void)addEleView {
    [self.view addSubview:self.eleView];
}

- (void)requestData {
    [self.elecModel requestSuccess:^{
        if (self.elecModel.electricFeeItem) {
            if (self.elecModel.electricFeeItem.buildAndRoom) {
                NSString *buildAndRoom = self.elecModel.electricFeeItem.buildAndRoom;
                [UserItemTool defaultItem].building = [buildAndRoom substringToIndex:2];
                [UserItemTool defaultItem].room = [buildAndRoom substringFromIndex:3];
                NSLog(@"%@,%@", [UserItemTool defaultItem].building, [UserItemTool defaultItem].room);
                [self updateElectricFeeUI];
            } else {
                NSLog(@"可能是房间号输入错误");
                //提醒用户重新绑定
                [self bindingRoomFailed];
            }
        }
    }
    failure:^(NSError *_Nonnull error) {
        [self requestElectricFeeFailed];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    PickerDormitoryViewController *vc = [[PickerDormitoryViewController alloc] init];
    vc.block = ^{
        [self requestData];
    };
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //填充全屏(原视图不会消失)
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)bindingRoomFailed {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setMode:(MBProgressHUDModeText)];
    hud.labelText = @"绑定的宿舍号可能有问题哦，请重新绑定";
    [UserItemTool defaultItem].building = nil;
    [UserItemTool defaultItem].room = nil;
    [hud hide:YES afterDelay:1.2];
}

- (void)requestElectricFeeFailed {
    [RemindHUD.shared showDefaultHUDWithText:@"电费查询服务器开小差了哦，请稍后重试" completion:nil];
}

- (void)updateElectricFeeUI {
    //先写入缓存
    [NSUserDefaults.standardUserDefaults setObject:self.elecModel.electricFeeItem.money forKey:@"ElectricFee_money"];
    [NSUserDefaults.standardUserDefaults setObject:self.elecModel.electricFeeItem.consume forKey:@"ElectricFee_degree"];
    [NSUserDefaults.standardUserDefaults setObject:self.elecModel.electricFeeItem.time forKey:@"ElectricFee_time"];
    [self.eleView refreshViewIfNeeded];
    [self.eleView.electricFeeMoney setText:self.elecModel.electricFeeItem.money];
//    [self.eleView.electricFeeMoney setTitle:self.elecModel.electricFeeItem.money forState:UIControlStateNormal];
    //self.eleView.electricConsumption.text = self.elecModel.electricFeeItem.consume;
    //这里读缓存以后日期的样式就改回去了，所以先屏蔽
}

@end
