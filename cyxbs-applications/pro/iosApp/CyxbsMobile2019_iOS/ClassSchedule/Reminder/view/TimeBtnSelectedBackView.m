//
//  TimeBtnSelectedBackView.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/20.
//  Copyright © 2020 Redrock. All rights reserved.
//显示已选择的时间的view，里面有一个加号，@“第一周 第三四节课” @“整学期 第七八节课”

#import "TimeBtnSelectedBackView.h"
#import "DLTimeSelectedButton.h"

@interface TimeBtnSelectedBackView()<DLTimeSelectedButtonDelegate>

/// 显示@“时间选择”的第一个按钮
@property(nonatomic,strong)UIButton *timeSelctbtn;

/// 放按钮的数组
@property(nonatomic,strong)NSMutableArray *timebuttonArray;


@end

@implementation TimeBtnSelectedBackView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backView = [[UIView alloc] init];
        [self addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.width.mas_equalTo(MAIN_SCREEN_W);
        }];
        UIButton *btn = [self getBtnWithTitileStr:@"时间选择"];
        [self.backView addSubview:btn];
        self.timeSelctbtn = btn;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView).offset(MAIN_SCREEN_W*0.0534);
            make.top.equalTo(self.backView);
        }];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.timeSelctbtn);
        }];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.timeSelctbtn);
        }];
        [self loadAddButton];
    }
    return self;
}

/// 添加显示@“时间选择”的第一个按钮
- (void)AddTimeSelctbtn{
    UIButton *btn = [[UIButton alloc] init];
    [self.backView addSubview:btn];
    self.timeSelctbtn = btn;
    [btn setTitle:@"时间选择" forState:UIControlStateNormal];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(MAIN_SCREEN_W*0.0534);
        make.width.mas_equalTo(MAIN_SCREEN_W*0.2267);
        make.height.mas_equalTo(MAIN_SCREEN_W*0.104);
        make.top.equalTo(self.backView);
    }];
}

- (UIButton*)getBtnWithTitileStr:(NSString*)titleStr{
    UIButton *weekChooseBtn = [[UIButton alloc] init];
    
    [weekChooseBtn setTitle:titleStr forState:UIControlStateNormal];
    weekChooseBtn.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:15];
    
    [weekChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(MAIN_SCREEN_W*0.104);

    }];
    
    [weekChooseBtn.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weekChooseBtn).offset(0.03429*MAIN_SCREEN_W);
        make.right.equalTo(weekChooseBtn).offset(-0.03429*MAIN_SCREEN_W);
    }];
    if (@available(iOS 11.0, *)) {
        [weekChooseBtn setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF1" alpha:1]] forState:UIControlStateNormal];
    } else {
        [weekChooseBtn setTitleColor:[UIColor colorWithHexString:@"F0F0F2"] forState:UIControlStateNormal];
    }
    if (@available(iOS 11.0, *)) {
        weekChooseBtn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F7" alpha:1] darkColor:[UIColor colorWithHexString:@"#5E5E5E" alpha:1]];
    } else {
         weekChooseBtn.backgroundColor = [UIColor colorWithHexString:@"#5E5E5E"];
    }
    weekChooseBtn.layer.cornerRadius = 20;
    
    return weekChooseBtn;
}


//@{@"weekString":@"",  @"lessonString":@""}
- (void)reloadSelectedButtonsWithTimeStringArray:(NSArray*)timeDictArray{
    for (UIButton *btn in self.timebuttonArray) {
        [btn removeFromSuperview];
    }
    
    self.timebuttonArray = [@[] mutableCopy];
    
    self.timeDateDelegate.timeDictArray = [timeDictArray mutableCopy];
    
    float row = 0.0; //行
    float line = 0.0; //列
    NSInteger count = timeDictArray.count;
    UIView *leftBtn;
    //根据代码的运行来看，timeDictArray.count==0只发生在删除最后一个时间按钮后，
    //也就是说只有在那种情况下，button才会为nil，下面一处更新addBtn约束处会做一个判断避免用了nil
    DLTimeSelectedButton *button;
    for (NSInteger i = 0; i < count; i++) {
        row = i/2;  //行
        line = i%2;  //列
        
        button  = [[DLTimeSelectedButton alloc] init];
        NSDictionary *timeDict = timeDictArray[i];
        NSString *timeStr = [NSString stringWithFormat:@"%@   %@",timeDict[@"weekString"],timeDict[@"lessonString"]];
        
        [button setTitle:timeStr forState:UIControlStateNormal];
        button.tag = i;
        [self.backView addSubview: button];
        if(line==0){
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.backView).offset(row*0.1573*MAIN_SCREEN_W);
                make.left.equalTo(self.backView).offset(MAIN_SCREEN_W*0.0534);
                make.height.mas_equalTo(MAIN_SCREEN_W*0.104);
            }];
        }else{
            leftBtn = [self.timebuttonArray lastObject];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.backView).offset(row*0.1573*MAIN_SCREEN_W);
                make.left.equalTo(leftBtn.mas_right).offset(MAIN_SCREEN_W*0.0534);
                make.height.mas_equalTo(MAIN_SCREEN_W*0.104);
            }];
        }
        
        [button.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button).offset(0.0427*MAIN_SCREEN_W);
            make.right.equalTo(button).offset(-0.0427*MAIN_SCREEN_W);
        }];
        
        button.delegate = self;
        [self.timebuttonArray addObject:button];
    }
    //根据最后一个按钮所在的row更新self的高度
    [self upDateWithRow:row andFloat:0.104];
    
    MASViewAttribute *anchor;//addBtn更新约束的参照
    
    if(count==0){
        //如果没有时间按钮了，那么约束参照就是self.timeSelctbtn.mas_right
        anchor = self.timeSelctbtn.mas_right;
    }else if(line==0){
                //如果最后一个按钮是在第一列，那么约束参照就是button.mas_right
                anchor = button.mas_right;
        }else{
            //如果最后一个按钮是在第二列，那么约束参照就是self.mas_left，
            anchor = self.backView.mas_left;
            //并且把self的高度调高一些，因为self.addBtn的底部和self的底部是equal的
            [self upDateWithRow:row andFloat:0.21];
        }
    
    //为什么是用reamke，而不是update？因为用update后发现时间按钮会被扭曲压缩，
    [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(anchor).offset(0.0427*MAIN_SCREEN_W);
        make.bottom.equalTo(self.backView).offset(-5);
        make.height.mas_equalTo(MAIN_SCREEN_W*0.0693);
        make.width.mas_equalTo(MAIN_SCREEN_W*0.0693);
    }];
}

/// 根据最后一个按钮的row和特定的倍数来修改self的heght、contentSize、contentOffset、self.backView.height
/// @param row reloadSelectedButtonsWithTimeStringArray:里面的row
/// @param num 0.21或者0.104
- (void)upDateWithRow:(int)row andFloat:(float)num{
    //更新backView高度
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((row*0.1573+num)*MAIN_SCREEN_W);
    }];
    if(row<3){//self高度最多四行那么多
        //row<3就让self的高度随着backView一起变高，并且self.contentOffset设为0,0就可以
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((row*0.1573+num)*MAIN_SCREEN_W);
        }];
        self.contentOffset = CGPointZero;
    }else{
        //row>=3，四行及以上，那么：
        self.contentOffset = CGPointMake(0, (num+(row-3)*0.1573)*MAIN_SCREEN_W);
    }
    //更新可滚动范围
    self.contentSize = CGSizeMake(0, row*0.1573*MAIN_SCREEN_W+MAIN_SCREEN_W*num);
}

- (void)deleteButtonWithBtn:(DLTimeSelectedButton*)btn{
    [btn removeFromSuperview];
    NSInteger tag = btn.tag;
    NSDictionary *deleteDict = self.timeDateDelegate.timeDictArray[tag];
    [self.timeDateDelegate.timeDictArray removeObject: deleteDict];
    [self reloadSelectedButtonsWithTimeStringArray:self.timeDateDelegate.timeDictArray];
    if(self.timeDateDelegate.timeDictArray.count==0){
        self.timeSelctbtn.hidden = NO;
    }
}

/// 添加一个时间按钮的方法，供外界调用
/// @param timeDict 时间字典结构：@{@"weekString":@"",  @"lessonString":@""}
- (void)loadSelectedButtonsWithTimeDict:(NSDictionary*)timeDict{
    [self.timeDateDelegate.timeDictArray addObject:timeDict];
    [self reloadSelectedButtonsWithTimeStringArray:self.timeDateDelegate.timeDictArray];
    self.timeSelctbtn.hidden = YES;
}
//添加加号按钮
- (void)loadAddButton{
    UIButton *btn = [[UIButton alloc] init];
    self.addBtn = btn;
    [btn setBackgroundImage:[UIImage imageNamed:@"timeAddImage"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [self.backView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView).offset(-6.85);
        make.left.equalTo(self.timeSelctbtn.mas_right).offset(0.0427*MAIN_SCREEN_W);
        make.height.mas_equalTo(MAIN_SCREEN_W*0.0693);
        make.width.mas_equalTo(MAIN_SCREEN_W*0.0693);
    }];
}
@end
