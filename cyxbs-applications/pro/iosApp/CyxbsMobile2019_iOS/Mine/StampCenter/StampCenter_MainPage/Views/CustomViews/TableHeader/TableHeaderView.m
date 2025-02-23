//
//  TableHeaderView.m
//  Demo5
//
//  Created by 钟文韬 on 2021/8/11.
//

#import "TableHeaderView.h"
#import "PrefixHeader.pch"
#import "StampTaskData.h"
#import "CheckInModel.h"

#import "RemindHUD.h"

@implementation TableHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self addSubview:self.button];
        [self addSubview:self.mainLabel];
        [self addSubview:self.detailLabel];
        //检查签到情况
        [CheckInModel requestCheckInInfoSucceeded:nil Failed:nil];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    UIBezierPath  *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame =self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (GotoButton *)button{
    if (!_button) {
        GotoButton *button = [[GotoButton alloc]initWithFrame:CGRectMake(0.781*SCREEN_WIDTH, 32, 66, 28) AndTitle:@"去签到"];
        [StampTaskData TaskDataWithSuccess:^(NSArray * _Nonnull array) {
            if (!array || array.count <= 0) {
                [RemindHUD.shared showDefaultHUDWithText:@"Token失效了，重新登录掌邮试试吧" completion:nil];
                return;
            }
            StampTaskData *data = array[0];
            if ([data.title isEqualToString:@"NULL"]) {
                [RemindHUD.shared showDefaultHUDWithText:@"Token失效了，重新登录掌邮试试吧" completion:nil];
                return;
            }
            if (data.current_progress == data.max_progress) {
                self.button.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#C1C1C1" alpha:1] darkColor:[UIColor colorWithHexString:@"#474747" alpha:1]];
                [self.button setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]] forState:UIControlStateNormal];
                self.button.enabled = NO;
                [self.button setTitle:@"已签到" forState:UIControlStateNormal];
                self.detailLabel.text = [NSString stringWithFormat:@"明日签到 +%d",  ([[UserItemTool defaultItem].checkInDay intValue]+2)*5];
            }
        } error:^{
            
        }];
        [button addTarget:self action:@selector(checkIn) forControlEvents:UIControlEventTouchUpInside];
        _button = button;
    }
    return _button;
}

- (UILabel *)mainLabel{
    if (!_mainLabel) {
        UILabel *mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.06*SCREEN_WIDTH, 24, 64, 22)];
        mainLabel.text = @"今日打卡";
        mainLabel.font = [UIFont fontWithName:PingFangSCMedium size:16];
        mainLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        _mainLabel = mainLabel;
    }
    return _mainLabel;
}

-(UILabel *)detailLabel{
    if (!_detailLabel) {
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.06*SCREEN_WIDTH, 50, 91, 20)];
        detailLabel.text = [NSString stringWithFormat:@"每日签到 +%d",  ([[UserItemTool defaultItem].checkInDay intValue]+2)*5];
        detailLabel.font = [UIFont fontWithName:PingFangSCRegular size:14];
        detailLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.4] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:0.4]];
        _detailLabel = detailLabel;
    }
    return _detailLabel;
}

- (void)checkIn{
    [CheckInModel CheckInSucceeded:^{
        self.button.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#C1C1C1" alpha:1] darkColor:[UIColor colorWithHexString:@"#474747" alpha:1]];
        [self.button setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]] forState:UIControlStateNormal];
        self.button.enabled = NO;
        [self.button setTitle:@"已签到" forState:UIControlStateNormal];
        self.detailLabel.text = [NSString stringWithFormat:@"明日签到 +%d",  ([[UserItemTool defaultItem].checkInDay intValue]+2)*5];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshPage" object:nil];
    } Failed:^(NSError * _Nonnull err) {
        NSLog(@"出错了");
    }];
    
}
@end
