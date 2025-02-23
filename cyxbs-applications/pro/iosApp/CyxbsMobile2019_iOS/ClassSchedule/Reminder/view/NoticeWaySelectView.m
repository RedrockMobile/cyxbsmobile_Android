//
//  NoticeWaySelectView.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/21.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "NoticeWaySelectView.h"
@interface NoticeWaySelectView()<UIPickerViewDelegate,UIPickerViewDataSource>

/// 弹窗
@property (nonatomic, strong)UIView *backView;

/// 提醒时间选择期
@property (nonatomic, strong)UIPickerView *picker;

//选择的提醒时间
@property (nonatomic, copy)NSString *notiTimeStr;

/// 提醒方式的字符串数组@"提前5分钟"等
@property (nonatomic, strong)NSArray <NSString*>*notiTextArray;

/// 确定按钮
@property (nonatomic, strong)UIButton *confirmBtn;
@end

@implementation NoticeWaySelectView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.notiTextArray = @[@"不提醒",@"提前五分钟",@"提前十分钟",@"提前二十分钟",@"提前三十分钟",@"提前一小时"];
        self.notiTimeStr = @"不提醒";
        [self addBackView];
        [self addPicker];
        [self addConfirmBtn];
        [self addGesture];
    }
    return self;
}

- (void)addBackView{
    UIView *backView = [[UIView alloc] init];
    self.backView = backView;
    [self addSubview:backView];
    
    backView.layer.shadowOffset = CGSizeMake(0,5);
    backView.layer.shadowRadius = 16;
    backView.layer.shadowOpacity = 1;
    backView.layer.cornerRadius = 16;
    backView.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        backView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    } else {
         backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    
    backView.layer.shadowOffset = CGSizeMake(0,2.5);
    backView.layer.shadowRadius = 15;
    backView.layer.cornerRadius = 16;
    backView.layer.shadowOpacity = 0.3;
    //给backview加一个空手势，以屏蔽移除弹窗手势
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender){ }]];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self).offset(20);
        make.height.mas_equalTo(0.4261*MAIN_SCREEN_H+20);
    }];
}
- (void)addPicker{
    UIPickerView *picker = [[UIPickerView alloc] init];
    self.picker = picker;
    [self addSubview:picker];
    
    picker.delegate = self;
    picker.dataSource = self;
    
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView);
        make.right.equalTo(self.backView);
        make.top.equalTo(self.backView);
//        make.bottom.equalTo(self.backView).offset(-20);
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.notiTextArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.notiTextArray[row];
}

//实现这个方法，可以自定义picker的外观
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        if (@available(iOS 11.0, *)) {
            pickerLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#122D55" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
             pickerLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        }
        [pickerLabel setFont: [UIFont fontWithName:PingFangSCSemibold size: 16]];
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.notiTimeStr = self.notiTextArray[row];

}

- (void)addConfirmBtn{
    self.confirmBtn = [[UIButton alloc] init];
    self.confirmBtn.backgroundColor = [UIColor colorWithHexString:@"#4841E2"];
    
    [self.confirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(130.0,728.0,120.0,40.0);
    gl.startPoint = CGPointMake(0.3560017943382263, 0.8500478863716125);
    gl.endPoint = CGPointMake(4.006013870239258, -5.502598762512207);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:72/255.0 green:65/255.0 blue:226/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:93/255.0 green:93/255.0 blue:247/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0),@(1.0f)];
    [self.confirmBtn.layer addSublayer:gl];
    self.confirmBtn.layer.cornerRadius = 0.05333*MAIN_SCREEN_W;
    self.confirmBtn.layer.masksToBounds = YES;
    [self.confirmBtn.titleLabel setTextColor: [UIColor whiteColor]];
    self.confirmBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size:18];
    self.confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.confirmBtn.titleLabel.frame = self.confirmBtn.frame;
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView).mas_offset(-0.07*MAIN_SCREEN_H);
        make.centerX.equalTo(self.backView);
        make.width.mas_equalTo(0.32*MAIN_SCREEN_W);
        make.height.mas_equalTo(0.10666*MAIN_SCREEN_W);
    }];
}
- (void)confirmBtnClicked{
    [self removeSelf];
    [self.delegate notiPickerDidSelectedWithString:self.notiTimeStr];
}
- (void)removeSelf{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H+0.4261*MAIN_SCREEN_H);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

 - (void)addGesture{
     UITapGestureRecognizer *TGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
     [self addGestureRecognizer:TGR];
 }
@end
