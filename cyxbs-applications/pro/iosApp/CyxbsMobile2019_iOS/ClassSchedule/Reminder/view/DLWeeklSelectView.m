//
//  DLWeeklSelectView.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/10.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DLWeeklSelectView.h"
#import "DLWeekButton.h"

#define kRateX [UIScreen mainScreen].bounds.size.width/375   //以iPhoneX为基准
#define kRateY [UIScreen mainScreen].bounds.size.height/812  //以iPhoneX为基准

@interface DLWeeklSelectView ()
/// 周选择view
@property (nonatomic, strong)UIView *backViewOfWeeKBtns;

/// 周选择按钮的标题数据来源
@property (nonatomic, strong)NSArray *weekArray;

///储存已经选择的周的字符串
@property (nonatomic, strong)NSMutableArray <NSString*> *weekSelectedTextxs;

@property (nonatomic, strong)NSMutableArray <DLWeekButton*>*weekBtnArray;
@end

@implementation DLWeeklSelectView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addBackViewOfWeeKBtns];
        [self initConfirmButton];
        self.weekArray = @[@"整学期", @"第一周", @"第二周", @"第三周", @"第四周", @"第五周", @"第六周", @"第七周", @"第八周", @"第九周", @"第十周", @"第十一周", @"第十二周", @"第十三周", @"第十四周", @"第十五周", @"第十六周", @"第十七周", @"第十八周", @"第十九周", @"第二十周", @"第二十一周",@"第二十二周",@"第二十三周",@"第二十四周",@"第二十五周"];
        self.weekSelectedTextxs = [NSMutableArray array];
        self.weekBtnArray = [NSMutableArray array];
        [self initWeekButtons];
    }
    return self;
}

- (void)addBackViewOfWeeKBtns{
    self.backViewOfWeeKBtns = [[UIView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_H, MAIN_SCREEN_W, 360*kRateY+30)];
    [self addSubview:self.backViewOfWeeKBtns];
    
    if (@available(iOS 11.0, *)) {
        self.backViewOfWeeKBtns.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    } else {
         self.backViewOfWeeKBtns.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        // Fallback on earlier versions
    }
    
//    self.backViewOfWeeKBtns.layer.shadowColor = [UIColor colorWithRed:83/255.0 green:105/255.0 blue:188/255.0 alpha:0.8].CGColor;
    
    self.backViewOfWeeKBtns.layer.shadowOffset = CGSizeMake(0,2.5);
    self.backViewOfWeeKBtns.layer.shadowRadius = 15;
    self.backViewOfWeeKBtns.layer.shadowOpacity = 0.3;
    self.backViewOfWeeKBtns.layer.cornerRadius = 16;
    //添加一个点击手势：下移360*kRateY，再从父控件移除
    [self addGesture];
    
    //给backViewOfWeeKBtns加一个空手势以免疫在self上的下移手势
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {}];
    [self.backViewOfWeeKBtns addGestureRecognizer:tgr];
}

- (void) initConfirmButton{
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
    self.confirmBtn.layer.cornerRadius = 16*kRateX;
    self.confirmBtn.layer.masksToBounds = YES;
    [self.confirmBtn.titleLabel setTextColor: [UIColor whiteColor]];
    self.confirmBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size:18];
    self.confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.confirmBtn.titleLabel.frame = self.confirmBtn.frame;
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).mas_offset(-15*kRateY);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(120*kRateX);
        make.height.mas_equalTo(40*kRateY);
    }];
    
}


- (void)initWeekButtons{
    CGFloat hasOccupiedWidth = 16 * kRateX;
    NSInteger j = 0;
    NSInteger count = self.weekArray.count;
    for (NSInteger i = 0; i < count; i++) {
        CGSize size = [self.weekArray[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:PingFangSCRegular size:12]}];
        if (hasOccupiedWidth + size.width + 40*kRateX > SCREEN_WIDTH - 16*kRateX) {
            j++;
            hasOccupiedWidth = 16*kRateX;
        }
        DLWeekButton *button = [[DLWeekButton alloc] init];
        [self.weekBtnArray addObject:button];
        [button setTitle:self.weekArray[i] forState:UIControlStateNormal];
        [button setTitle:self.weekArray[i] forState:UIControlStateSelected];
        [button setTitle:self.weekArray[i] forState:UIControlStateSelected|UIControlStateHighlighted];
        //整学期按钮tag==0
        button.tag = i;
        [button addTarget:self action:@selector(didClickWeekButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.backViewOfWeeKBtns addSubview: button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backViewOfWeeKBtns).mas_offset(22*kRateY + j*40*kRateY);
            make.left.equalTo(self.backViewOfWeeKBtns).mas_offset(hasOccupiedWidth + 10*kRateX);
            make.width.mas_equalTo(size.width + 24*kRateX);
            make.height.mas_equalTo(30*kRateX);
        }];
        hasOccupiedWidth += size.width + 34*kRateX;
    }
}

/// 点击了某一周所代表的按钮后调用
/// @param button 被点击的按钮
- (void)didClickWeekButton:(DLWeekButton *)button{
    button.selected = !button.selected;
    button.isChangeColor = !button.isChangeColor;
    if (button.selected==YES) {
        [self.weekSelectedTextxs addObject:button.titleLabel.text];
        if(button.tag==0){//如果选择了整学期
            int count = (int)self.weekBtnArray.count;
            DLWeekButton *ortherBtn;//除了整学期以外的按钮
            for (int i=1; i<count; i++) {
                ortherBtn = self.weekBtnArray[i];
                ortherBtn.selected = NO;
                ortherBtn.isChangeColor = NO;
                [self.weekSelectedTextxs removeObject:ortherBtn.titleLabel.text];
            }
        }else{
            //对整学期按钮进行操作
            self.weekBtnArray[0].isChangeColor = NO;
            self.weekBtnArray[0].selected = NO;
            [self.weekSelectedTextxs removeObject:self.weekBtnArray[0].titleLabel.text];
        }
    }else{
        [self.weekSelectedTextxs removeObject:button.titleLabel.text];
    }
}

- (void)addGesture{
    UITapGestureRecognizer *TGR = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        
        [UIView animateWithDuration:0.3 animations:^{
            [self setFrame:CGRectMake(0, 0, MAIN_SCREEN_W, 360*kRateY+MAIN_SCREEN_H)];
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
    [self addGestureRecognizer:TGR];
}

/// 确定按钮点击后调用
- (void)confirmBtnClicked{
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAIN_SCREEN_H+360*kRateY)];
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    //调用代理方法，传入已经选择的周string
    [self.delegate selectedTimeStringArray:self.weekSelectedTextxs];
}

- (void)setWeekBtnsSelectedWithIndexArray:(NSArray*)indexArray{
    for (NSNumber *num in indexArray) {
        [self didClickWeekButton:self.weekBtnArray[num.intValue]];
    }
}
@end
