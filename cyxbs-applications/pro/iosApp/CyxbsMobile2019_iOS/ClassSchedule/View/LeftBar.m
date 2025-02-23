//
//  LeftBar.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/17.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "LeftBar.h"
//一小节课item的高度
#define H_H (MAIN_SCREEN_W*0.1426)
#define dis (MAIN_SCREEN_W*0.00795)
@interface LeftBar()
/// 标记当前是第几节课
@property(nonatomic,strong)UIView *markView;
@end

@implementation LeftBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, MONTH_ITEM_W, 12*H_H+11*dis);
        for (int i=0; i<12; i++) {
            UILabel *label = [self getLabelWithString:[NSString stringWithFormat:@"%d",i+1]];
            [self addSubview:label];
            [label setFrame:CGRectMake(0, i*(H_H+dis), MONTH_ITEM_W, H_H)];
        }
        [self getTipView];
    }
    return self;
}

- (void)getTipView{
    float y = [self getTipViewY];
    //如果y<0那就意味着不用添加提示view
    if(y<0)return;
    
    UIView *view = [[UIView alloc] init];
    
    UIView *bollView = [[UIView alloc] init];
    [view addSubview:bollView];
    bollView.layer.cornerRadius = MAIN_SCREEN_W*0.008;
    [bollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.centerY.equalTo(view);
        make.width.height.mas_equalTo(MAIN_SCREEN_W*0.016);
    }];
    
    
    UIView *longView = [[UIView alloc] init];
    [view addSubview:longView];
    [longView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bollView.mas_right);
        make.centerY.equalTo(view);
        make.width.mas_equalTo(MAIN_SCREEN_W*0.0666);
        make.height.mas_equalTo(1);
    }];
    if (@available(iOS 11.0, *)) {
        longView.backgroundColor =
        bollView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        longView.backgroundColor =
        bollView.backgroundColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    [view setFrame:CGRectMake(MAIN_SCREEN_W*0.012, y, MAIN_SCREEN_W*0.0826, MAIN_SCREEN_W*0.016)];
    [self addSubview:view];
}
/// 获取左侧课条内部的小课块
/// @param text 实际上是一个数字，范围：[1,12]
- (UILabel*)getLabelWithString:(NSString*)text{
    UILabel *label = [[UILabel alloc] init];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    label.font = [UIFont fontWithName:PingFangSCMedium size: 12];
    [label setTextAlignment:(NSTextAlignmentCenter)];
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    return label;
}
/**
    返回的字典的结构：@{
    @"y":年,
    @"M":月,
    @"d":日,
    @"k":小时（24小时制）,[1, 24]
    @"m:分"
    @"e":周几，2～周一，1~周日，4～周3
    @"c":周几，2～周一，1~周日，4～周3
    };
*/
//获取当前时间信息的方法
- (NSDictionary *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSArray *array = @[@"y",@"M",@"d",@"k",@"m",@"e",@"c"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *str in array) {
        [formatter setDateFormat:str];
        [dict setValue:[formatter stringFromDate:[NSDate date]]forKey:str];
    }
    return dict;
}
//获取提示view的y，如果y是负数，代表当前时间不在第一节课和最后一节课之间
- (float)getTipViewY{
    NSDate *nowTime = [NSDate date];
    long totalMinute =  nowTime.hour*60+nowTime.minute;
    float percent,y;
    int i;
    if(480<totalMinute&&totalMinute<1350){
        int timePoints[] = {480,615,840,975,1140,1250,1350};
        for (i=1; i<6; i++) {
            if(timePoints[i]>totalMinute)break;
        }
        percent = (totalMinute-timePoints[i-1])/100.0;
        if(percent<1){
            y = (i-1)*(2*H_H+2*dis)+percent*(2*H_H+dis);
        }else{
            y = i*(2*H_H+2*dis)-1.5*dis;
        }
    }else{
        y = -1;
    }
    return y;
}
@end
