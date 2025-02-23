//
//  DayBarView.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/16.
//  Copyright © 2020 Redrock. All rights reserved.
//显示星期、月份、日期信息的view

#import "DayBarView.h"
@interface DayBarView ()
@property (nonatomic,strong)NSMutableArray *weekLabelViewArray;

/// 显示月份的View
@property (nonatomic,strong)UIView *monthView;

/// 数据字典组成的数组@[
/// @{@"month":@2,    @"day":@24 },
/// @{},.....
/// ],7个字典，代表一周七天的日期
@property (nonatomic,strong)NSArray *dataArray;
@end

@implementation DayBarView
/// 初始化成为某周准备的bar
- (instancetype)initWithDataArray:(NSArray*)dataArray{
    self = [super init];
    if(self){
        self.dataArray = dataArray;
        
        NSDictionary *firstDay =[dataArray firstObject];
        self.monthView = [self getMonthViewWithNum:firstDay[@"month"]];
        [self addSubview:self.monthView];
        
        self.weekLabelViewArray = [NSMutableArray array];
        for (int i=0; i<7; i++) {
            NSDictionary *dayData = [self transferData:@{
                @"day":dataArray[i][@"day"],
                @"index":[NSNumber numberWithInt:i],
            }];
            
            UIView *weekLabelView = [self getLabelViewWithDict:dayData];
            [self addSubview:weekLabelView];
            [self.weekLabelViewArray addObject:weekLabelView];
        }
        
        [self updata];
        [self addConstraint];
    }
    return self;
}

/// 初始化成为整学期准备的bar
- (instancetype)initForWholeTerm{
    self = [super init];
    if(self){
        self.monthView = [self getMonthViewWithNum:nil];
        [self addSubview:self.monthView];
        self.weekLabelViewArray = [NSMutableArray array];
        for (int i=0; i<7; i++) {
            NSDictionary *dayData = [self transferData:@{
                @"index":[NSNumber numberWithInt:i],
            }];
            UIView *weekLabelView = [self getLabelViewWithDict:dayData];
            [self addSubview:weekLabelView];
            [self.weekLabelViewArray addObject:weekLabelView];
        }
        [self addConstraint];
    }
    return self;
}

/// 得到一个显示”周x“和@”x日“的view
/// @param dict 结构：@{@"week":@"周x", @"day":@"x日"}
- (UIView*)getLabelViewWithDict:(NSDictionary*)dict{
    UIView *backView = [[UIView alloc] init];
    if (@available(iOS 11.0, *)) {
        backView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
    } else {
        backView.backgroundColor = [UIColor whiteColor];
    }
    backView.layer.cornerRadius = 8;
    
    
    UILabel *week = [[UILabel alloc] init];
    [backView addSubview:week];
    
    week.tag = 1;
    [week setTextAlignment:(NSTextAlignmentCenter)];
    week.backgroundColor = UIColor.clearColor;
    week.font = [UIFont fontWithName:PingFangSCRegular size: 12];
    week.text = dict[@"week"];
    if (@available(iOS 11.0, *)) {
        week.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        week.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    
    [week mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(DAY_BAR_ITEM_H*0.12);
        make.centerX.equalTo(backView);
    }];
    
    
    UILabel *day = [[UILabel alloc] init];
    [backView addSubview:day];
    
    day.tag = 2;
    [day setTextAlignment:(NSTextAlignmentCenter)];
    day.backgroundColor = UIColor.clearColor;
    day.font = [UIFont fontWithName:PingFangSCRegular size: 12];
    day.text = dict[@"day"];
    if (@available(iOS 11.0, *)) {
        day.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        day.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    day.alpha = 0.77;
    
    [day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView).offset(-DAY_BAR_ITEM_H*0.12);
        make.centerX.equalTo(backView);
    }];
    //布局调试用
//    backView.backgroundColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:0.7];
    return backView;
}

//得到一个显示@“num月”的monthView,如果num==nil那么显示的文字为@“”
- (UIView*)getMonthViewWithNum:(NSNumber*)num{
    UIView *backView = [[UIView alloc] init];
    if (@available(iOS 11.0, *)) {
        backView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
    } else {
        backView.backgroundColor = [UIColor whiteColor];
    }
    
    UILabel *month =  [[UILabel alloc] init];
    [backView addSubview:month];
    
    month.backgroundColor = UIColor.clearColor;
    month.font = [UIFont fontWithName:PingFangSCRegular size: 12];
    if(num==nil){
        month.text = @"";
    }else{
        month.text = [NSString stringWithFormat:@"%@月",num];
    }
    if (@available(iOS 11.0, *)) {
        month.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        month.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    
    [month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backView);
    }];
    //布局调试用
//    backView.backgroundColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:0.7];
    return backView;
}

/// 加约束，调用前需确保：self.weekLabelViewArray、self.monthView初始化完成，且已经加到父控件
- (void)addConstraint{
    [self.monthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(1.4);
        make.bottom.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(MONTH_ITEM_W);
    }];
    
    UIView *anchorView = self.monthView;
    for (UIView *v in self.weekLabelViewArray) {
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(anchorView.mas_right).offset(DAYBARVIEW_DISTANCE);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.width.mas_equalTo(DAY_BAR_ITEM_W);
        }];
        anchorView = v;
    }
    
    [anchorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
    }];
}

///字典的键值对转换：
//@"index":@3, -> @"week":@"周四",
//@"day":26, -> @"day":@"x日",
- (NSDictionary*)transferData:(NSDictionary*)dict{
    NSString *index = dict[@"index"];
    NSString *day = dict[@"day"];
    NSArray *transfer = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSString *dayStr;
    if(day==nil){
        dayStr = @"";
    }else{
        dayStr = [NSString stringWithFormat:@"%@日",day];
    }
    return @{
        @"week":transfer[[index intValue]],
        @"day":dayStr,
    };
    
}

//更新一下，让今日的weekLabelView变一下色
- (void)updata{
    NSDate *now = [NSDate date];
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"y"];
    NSString *year = [formate stringFromDate:[NSDate date]];
    
    NSString *selfMonth = self.dataArray[3][@"month"];
    NSString *selfDay = self.dataArray[3][@"day"];
    NSString *dataStr = [NSString stringWithFormat:@"%@-%@-%@-%ld-%ld-%ld",year,selfMonth,selfDay,(long)now.hour,(long)now.minute,(long)now.second];
    
    formate.dateFormat = @"yyyy-M-d-H-m-s";
    
    //得到该周周4的日期
    NSDate *Thurs = [formate dateFromString:dataStr];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    
    NSDateComponents *compsday = [calender components:NSCalendarUnitHour fromDate:Thurs toDate:now options:0];
    
    long interval;
    //得到周四和今日隔了几天
    if(compsday.hour>=0){
        interval = (int)(compsday.hour/24.0+0.5);
    }else{
        interval = (int)(compsday.hour/24.0-0.5);
    }
    
    if(labs(interval)<4){//时间间隔小于4，代表这个课表是本周课表
        [formate setDateFormat:@"d"];
        NSString *day = [formate stringFromDate:[NSDate date]];
        
        UIView *view;
        int num1 = [self.dataArray[3+interval][@"day"] intValue];
        int num2 = day.intValue;
        if(num1==num2){
            view  =  self.weekLabelViewArray[3+interval];
            
            //        添加一个背景长条
            UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DAY_BAR_ITEM_W, MAIN_SCREEN_H)];
            [view.superview addSubview:tipView];
            [view removeFromSuperview];
            [tipView addSubview:view];
            if(@available(iOS 11.0,*)){
                tipView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E7EFFF" alpha:0.587] darkColor:[UIColor colorWithHexString:@"#010101" alpha:0.161]];
            }else{
                tipView.backgroundColor = [UIColor colorWithRed:232/255.0 green:240/255.0 blue:252/255.0 alpha:0.59];
            }
            tipView.layer.cornerRadius = 8;
            [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(view);
                make.top.equalTo(view);
                make.height.mas_equalTo(MAIN_SCREEN_H);
                make.width.mas_equalTo(MAIN_SCREEN_W*0.1245);
            }];
            
            
            if (@available(iOS 11.0, *)) {
                view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#294D83" alpha:1] darkColor:[UIColor colorWithHexString:@"#EBF2FA" alpha:1]];
            } else {
                view.backgroundColor = [UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1];
            }
            
            for (UILabel *label in view.subviews) {
                if (@available(iOS 11.0, *)) {
                    label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#332D47" alpha:1]];
                } else {
                    label.textColor = [UIColor whiteColor];
                }
                if(label.tag==2){
                    label.alpha = 0.64;
                }
            }
            
        }
    }
}

@end
