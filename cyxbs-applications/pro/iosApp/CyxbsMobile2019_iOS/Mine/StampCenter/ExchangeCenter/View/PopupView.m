//
//  PopupView.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/8/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "PopupView.h"
#import <Masonry/Masonry.h>
#import "Goods.h"
#import "BuyModel.h"

@implementation PopupView

- (instancetype)initWithGoodsName:(NSString *)name AndCount:(NSString *)count AndAmount:(int)amount AndID:(NSString *)ID {
    if ([super init]) {
        self.goodsID = ID;
        [self addgrayView];
        [self addwhiteView];
        [self addLabel];
        _is = 1;
        _grayView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        _whiteView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#1C1C1C" alpha:1]];
        NSLog(@"%d", amount);
        if (amount <= 0) {
            self.textLabel.text = @"啊哦！手慢了！下次再来吧！";
            [self addNoamountButton];
        }else{
            self.textLabel.text = [NSString stringWithFormat:@"确认要用%@邮票兑换%@吗",count,name];
            [self addExchangeButton];
        }
    }
    return  self;
}

// 点击确定后，调用网络请求，如果兑换成功了，调用此方法
- (void)refresh1 {
    [self moveBtn];
    self.textLabel.text = @"兑换成功\n请尽快到红岩网校领取！";
    UIButton *btn = [[UIButton alloc]init];
    [self.whiteView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_whiteView);
            make.top.equalTo(_whiteView).offset(110);
            make.width.mas_equalTo(129);
            make.height.mas_equalTo(34);
    }];
    btn.layer.cornerRadius = 18;
    btn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4943E3" alpha:1] darkColor:[UIColor colorWithHexString:@"#5555FF" alpha:1]];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}

// 点击确定后，调用网络请求，如果积分不足了，调用此方法
- (void)refresh2 {
    [self moveBtn];
    self.textLabel.text = @"积分不足\n兑换失败\n";
//    self.textLabel.font = [UIFont systemFontOfSize:24];
    UIButton *btn = [[UIButton alloc]init];
    [self.whiteView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_whiteView);
            make.top.equalTo(_whiteView).offset(110);
            make.width.mas_equalTo(129);
            make.height.mas_equalTo(34);
    }];
    btn.layer.cornerRadius = 18;
    btn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4943E3" alpha:1] darkColor:[UIColor colorWithHexString:@"#5555FF" alpha:1]];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}

// 点击确定后，调用网络请求，如果无库存了，调用此方法
- (void)refresh3 {
    [self moveBtn];
    self.textLabel.text = @"啊哦！手慢了！下次再来吧！\n";
    UIButton *btn = [[UIButton alloc]init];
    [self.whiteView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_whiteView);
            make.top.equalTo(_whiteView).offset(110);
            make.width.mas_equalTo(129);
            make.height.mas_equalTo(34);
    }];
    btn.layer.cornerRadius = 18;
    btn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4943E3" alpha:1] darkColor:[UIColor colorWithHexString:@"#5555FF" alpha:1]];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}
//添加灰色框
- (void)addgrayView {
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self addSubview:grayView];
    _grayView = grayView;
}
//添加白色框
- (void)addwhiteView {
    UIView *whiteView = [[UIView alloc]init];
    [_grayView addSubview:whiteView];
    _whiteView = whiteView;
    [whiteView  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(255);
                make.height.mas_equalTo(178);
                make.centerX.equalTo(_grayView);
                make.centerY.equalTo(_grayView);
    }];
    whiteView.layer.cornerRadius = 20;
}

///没库存按钮
- (void)addNoamountButton {
    UIButton *noamountcomfirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_whiteView addSubview:noamountcomfirmBtn];
    _noamountComfirmBtn = noamountcomfirmBtn;
    noamountcomfirmBtn.frame = CGRectMake(138, 110, 129, 34);
    [noamountcomfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_grayView);
            make.top.equalTo(_whiteView).offset(110);
            make.width.mas_equalTo(129);
            make.height.mas_equalTo(34);
    }];
    noamountcomfirmBtn.layer.cornerRadius = 18;
    noamountcomfirmBtn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4943E3" alpha:1] darkColor:[UIColor colorWithHexString:@"#5555FF" alpha:1]];
    [noamountcomfirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [noamountcomfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [noamountcomfirmBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}
///有库存按钮
- (void)addExchangeButton {
    //取消按钮
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancleBtn = cancleBtn;
    [_whiteView addSubview:cancleBtn];
    cancleBtn.frame = CGRectMake(26, 110, 93, 34);
    cancleBtn.layer.cornerRadius = 18;
    cancleBtn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#C3D3ED" alpha:1] darkColor:[UIColor colorWithHexString:@"#4E4E4E" alpha:1]];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    //确认按钮
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_whiteView addSubview:comfirmBtn];
    _comfirmBtn = comfirmBtn;
    comfirmBtn.frame = CGRectMake(138, 110, 93, 34);
    comfirmBtn.layer.cornerRadius = 18;
    comfirmBtn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4943E3" alpha:1] darkColor:[UIColor colorWithHexString:@"#5555FF" alpha:1]];
    [comfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [comfirmBtn addTarget:self action:@selector(comfirm) forControlEvents:UIControlEventTouchUpInside];
}
///添加文字框
- (void)addLabel {
    UILabel *textlabel = [[UILabel alloc]init];
    [self.whiteView addSubview:textlabel];
    _textLabel = textlabel;
    [textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_grayView);
            make.top.equalTo(self.whiteView).offset(44);
            make.width.mas_equalTo(200);
    }];
    textlabel.numberOfLines = 0;
    textlabel.textAlignment = NSTextAlignmentCenter;
    textlabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    textlabel.font = [UIFont systemFontOfSize:14];
}
///移除弹窗
- (void)remove {
    [self removeFromSuperview];
}
///确定
- (void)comfirm {
    BuyModel *model = [[BuyModel alloc] init];
    [model buyGoodsWithID:self.goodsID];
    [model setBlock:^(id  _Nonnull info) { //3
        NSLog(@"%@", info);
        if ([info intValue] == 10000) {
            [self refresh1];
        }else if ([info intValue] == 50000) {
            [self refresh2];
        }else if([info intValue] == 50001){
            [self refresh3];
        }
    }];
}
///溢出按钮
- (void)moveBtn {
    [self.cancleBtn removeFromSuperview];
    [self.comfirmBtn removeFromSuperview];
}
@end
