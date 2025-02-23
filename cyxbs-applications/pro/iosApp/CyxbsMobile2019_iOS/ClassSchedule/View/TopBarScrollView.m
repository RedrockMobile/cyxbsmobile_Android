//
//  TopBarScrollView.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/7/31.
//  Copyright © 2020 Redrock. All rights reserved.
//顶部周信息条，@“回到本周”、@“二周”、选择周的条的bar

#import "TopBarScrollView.h"

@interface TopBarScrollView()<UIScrollViewDelegate>
/// 选择去某一周的条
@property (nonatomic,strong)UIScrollView *weekChooseBar;

/// 显示本周是哪一周的条
@property (nonatomic,strong)UIView *nowWeekBar;

/// 储存@“整学期”，@“十六周”等字符串的数组
@property (nonatomic,strong)NSArray <NSString*> *weekTextArray;

/// 左箭头按钮
@property (nonatomic,strong)UIButton *leftArrowBtn;

/// 在本周时的左箭头按钮
@property (nonatomic,strong)UIButton *nowWeekLeftArrowBtn;

/// 右箭头按钮
@property (nonatomic,strong)UIButton *rightArrowBtn;

/// 选择周的bar里面的按钮
@property (nonatomic,strong)NSMutableArray <UIButton*> *weekChooseBtnArray;

/// 显示当前课表是第几周课表的label，@“十九周”、@“一周”、@“整学期”
@property (nonatomic,strong)UILabel *weekLabel;

/// 当课表是本周的课表时，显示@"（本周）"的label
@property (nonatomic,strong)UILabel *nowWeekLabel;

/// 回到本周的那个按钮
@property (nonatomic,strong)UIButton *backCurrentWeekBtn;

/// weekChooseBar、nowWeekBar的背景view
@property(nonatomic,strong)UIView *backView;
@end

@implementation TopBarScrollView
//MARK:-重写的方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        self.frame = frame;
        
        [self setContentSize:(CGSizeMake(2*MAIN_SCREEN_W, 0))];
        
        //禁止滑动
        self.scrollEnabled = NO;
        
        //添加weekChooseBar、nowWeekBar的背景view
        [self addBackView];
        //初始化weekTextArray
        /**
        self.weekTextArray = @[@"整学期",@"一周",@"二周",@"三周",@"四周",@"五周",@"六周",@"七周",@"八周",@"九周",@"十周",@"十一周",@"十二周",@"十三周",@"十四周",@"十五周",@"十六周",@"十七周",@"十八周",@"十九周",@"二十周",@"二十一周",@"二十二周",@"二十三周",@"二十四周",@"二十五周"];
        */
        self.weekTextArray = @[@"整学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"十一周",@"十二周",@"十三周",@"十四周",@"十五周",@"十六周",@"十七周",@"十八周",@"十九周",@"二十周",@"二十一周",@"二十二周",@"二十三周",@"二十四周",@"二十五周"];
        
        //初始化weekChooseBtnArray
        self.weekChooseBtnArray = [NSMutableArray arrayWithCapacity:self.weekTextArray.count];
        // _correctIndex初始化为 @(0) 避免第一次触发 KVO 时，发生错误。
        _correctIndex = @(0);
        //对correctIndex进行kvo，改变correctIndex就可以自动进行一系列操作
        [self addObserver:self forKeyPath:@"correctIndex" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:@"TopBarScrollView.correctIndex"];

        //添加周选择条和左箭头按钮，周选择条在self的左侧
        [self addWeekChooseBarAndLeftArrowBtn];
        
        //添加当前周信息的条（回到本周按钮就在这个条上面）,条在self的右侧
        [self addNowWeekBar];
        
        //让TopBar最开始显示的是nowWeekBar
        self.contentOffset = CGPointMake(MAIN_SCREEN_W, 0);
    }
    return self;
}

//调整weekChooseBar的滚动范围
- (void)layoutSubviews{
    UIView *lastBtn = [self.weekChooseBtnArray lastObject];
    //根据最后一个周选择按钮调整weekChooseBar的滚动范围
    [self.weekChooseBar setContentSize:CGSizeMake(lastBtn.frame.origin.x+lastBtn.frame.size.width, 0)];
}

//MARK:- 添加子控件的方法
/// 添加weekChooseBar、nowWeekBar的背景view
- (void)addBackView{
    UIView *view = [[UIView alloc] init];
    self.backView = view;
    [self addSubview:view];
    view.frame =CGRectMake(0, 0, 2*MAIN_SCREEN_W,40);
}

///添加周选择条和左箭头按钮，周选择条在self的左侧
- (void)addWeekChooseBarAndLeftArrowBtn{
    UIButton *btn = [[UIButton alloc] init];
    [self.backView addSubview:btn];
    self.leftArrowBtn = btn;
    
    [btn addTarget:self action:@selector(leftArrowBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"左箭头"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    
    //约束
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(self.backView);
        make.left.equalTo(self.backView).offset(MAIN_SCREEN_W-20);
    }];
    
    UIScrollView *weekChooseBar = [[UIScrollView alloc] init];
    [self.backView addSubview:weekChooseBar];
    self.weekChooseBar = weekChooseBar;
    [weekChooseBar setContentSize:(CGSizeMake(1731, 0))];
    weekChooseBar.showsHorizontalScrollIndicator = NO;
    
    //添加周选择条里面全部的的某周的按钮
    [self addWeekChooseBtns];
    
    //添加约束
    [weekChooseBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView);
        make.top.equalTo(self.backView);
        make.bottom.equalTo(self.backView);
        make.right.equalTo(btn.mas_left);
    }];
}

/// 添加周选择条里面全部的的某周的按钮
- (void)addWeekChooseBtns{
    UIButton *firstBtn = [self getWeekChooseBtnWithTag:0];
    [self.weekChooseBar addSubview:firstBtn];
    //给第一个按钮加约束，@“整学期”按钮
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.weekChooseBar).offset(0.0427*MAIN_SCREEN_W);
        make.centerY.equalTo(self.weekChooseBar);
    }];
    //lastBtn的意义是上一个添加约束的按钮，后面添加约束的按钮将以它作为一部分参照
    UIButton *lastBtn = firstBtn;
    //上一个添加约束的按钮和btn的间距
    float distance = MAIN_SCREEN_W*0.064;
    for (int i=1; i<self.weekTextArray.count; i++) {
        UIButton *btn = [self getWeekChooseBtnWithTag:i];
        [self.weekChooseBar addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastBtn.mas_right).offset(distance);
            make.centerY.equalTo(self.weekChooseBar);
        }];
        //更新lastBtn为btn
        lastBtn = btn;
    }
}

//按钮的标题是self.weekTextArray[tag]@“整学期”、@“第一周”
//并且把btn加入self.weekChooseBtnArray
/// 创建一个周选择条里面的按钮，设置按钮tag为tag，
- (UIButton*)getWeekChooseBtnWithTag:(int)tag{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:self.weekTextArray[tag] forState:UIControlStateNormal];
    btn.tag = tag;
    self.weekChooseBtnArray[tag] = btn;
    if(@available(iOS 11.0, *)){
        [btn setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]] forState:UIControlStateNormal];
    }else{
        [btn setTitleColor:[UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1] forState:UIControlStateNormal];
    }
    btn.titleLabel.font =  [UIFont fontWithName:PingFangSCRegular size: 15];
    btn.alpha = 0.81;
    [btn addTarget:self action:@selector(weekChooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

///添加当前周信息的条（回到本周按钮就在这个条上面）,条在self的右侧
- (void)addNowWeekBar{
    UIView *nowWeekBar = [[UIScrollView alloc] init];
    self.nowWeekBar = nowWeekBar;
    [self.backView addSubview:nowWeekBar];
    
    //添加显示本周、第七周的那个label
    [self addWeekLabel];
    
    //添加当课表是本周的课表时，显示@"（本周）"的label
    [self addNowWeekLabel];
    
    //添加右箭头按钮
    [self addRightArrowBtn];
    
    //添加回到本周按钮
    [self addBackCurrentWeekBtn];
    
    //添加约束
    [nowWeekBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView);
        make.top.equalTo(self.backView);
        make.bottom.equalTo(self.backView);
        make.width.mas_equalTo(MAIN_SCREEN_W);
    }];
}

//添加显示本周、第七周的那个label
- (void)addWeekLabel{
    //    nowWeekBar.backgroundColor = UIColor.redColor;
    //显示本周、第七周、整学期的那个label
    UILabel *weekLabel = [[UILabel alloc] init];
    [self.nowWeekBar addSubview: weekLabel];
    self.weekLabel = weekLabel;
    
    weekLabel.text = @"整学期";
    if (@available(iOS 11.0, *)) {
        weekLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        weekLabel.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    weekLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    [weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nowWeekBar).offset(MAIN_SCREEN_W*0.0427);
        make.centerY.equalTo(self.nowWeekBar);
    }];
}

///添加当课表是本周的课表时，显示@"（本周）"的label
- (void)addNowWeekLabel{
    UILabel *nowWeekLabel = [[UILabel alloc] init];
    [self.nowWeekBar addSubview: nowWeekLabel];
    self.nowWeekLabel = nowWeekLabel;
    
    nowWeekLabel.text = @" (本周) ";
    nowWeekLabel.font = [UIFont fontWithName:PingFangSCRegular size: 15];
    if (@available(iOS 11.0, *)) {
        nowWeekLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        nowWeekLabel.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    nowWeekLabel.frame = CGRectMake(MAIN_SCREEN_W*0.2627, 0.009*MAIN_SCREEN_H, 0.12*MAIN_SCREEN_W, 0.0259*MAIN_SCREEN_H);
    
    [nowWeekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.weekLabel.mas_right);
        make.bottom.equalTo(self.weekLabel);
    }];
    
}

/// 添加右箭头按钮
- (void)addRightArrowBtn{
    UIButton *btn = [[UIButton alloc] init];
    [self.nowWeekBar addSubview:btn];
    self.rightArrowBtn = btn;
    
    [btn addTarget:self action:@selector(rightArrowBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"右箭头"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:(UIEdgeInsetsMake(0, 5, 0, 6))];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.left.equalTo(self.nowWeekLabel.mas_right).offset(-5);
        make.centerY.equalTo(self.weekLabel).offset(2.5);
    }];
}

/// 添加@“回到本周”按钮
- (void)addBackCurrentWeekBtn{
    UIButton *backBtn = [[UIButton alloc] init];
    [self.nowWeekBar addSubview:backBtn];
    self.backCurrentWeekBtn = backBtn;
    
    [backBtn setTitle:@"回到本周" forState:(UIControlStateNormal)];
    [backBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    if (@available(iOS 11.0, *)) {
        [backBtn setBackgroundColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#453DD9" alpha:1] darkColor:[UIColor colorWithHexString:@"#495CF5" alpha:1]]];
    } else {
        [backBtn setBackgroundColor:[UIColor colorWithRed:69/255.0 green:62/255.0 blue:217/255.0 alpha:1]];
    }
    backBtn.titleLabel.font = [UIFont fontWithName:PingFangSCRegular size: 13];
    backBtn.layer.cornerRadius = MAIN_SCREEN_W*0.045;
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nowWeekBar).offset(MAIN_SCREEN_W*0.728);
        make.centerY.equalTo(self.nowWeekBar);
        make.width.mas_equalTo(0.2293*MAIN_SCREEN_W);
        make.height.mas_equalTo(0.0853*MAIN_SCREEN_W);
    }];
    

    [backBtn addTarget:self action:@selector(backCurrentWeekBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}


//MARK:-点击某按钮后调用的方法：
/// 回到本周按钮点击后调用，回到本周
- (void)backCurrentWeekBtnClicked{
    if(self.dateModel.nowWeek.intValue>25){
        self.correctIndex = [NSNumber numberWithInt:0];
    }else{
        self.correctIndex = self.dateModel.nowWeek;
    }
    [self.weekChooseDelegate gotoWeekAtIndex:self.correctIndex];
}

/// 左箭头按钮点击后调用，改变self的setContentOffset来显示nowWeekBar
- (void)leftArrowBtnClicked{
    [UIView animateWithDuration:0.5 animations:^{
        [self setContentOffset:(CGPointMake(MAIN_SCREEN_W, 0))];
    }];
}

/// 右箭头按钮点击后调用，改变self的setContentOffset来显示weekChooseBar
- (void)rightArrowBtnClicked{
    [UIView animateWithDuration:0.5 animations:^{
        [self setContentOffset:(CGPointMake(0, 0))];
    }];
}

//周选择条的按钮点击后调用，tag=0代表是点击了整学期按钮，tag=2代表是第二周
/// 用tag给correctIndex赋值
- (void)weekChooseBtnClick:(UIButton*)btn{
    //改变correctIndex，随后KVO会根据correctIndex的改变完成一系列相关操作
    self.correctIndex = [NSNumber numberWithLong:btn.tag];
    //调用代理方法，告诉代理点击了哪一周的按钮，0代表整学期，17代表第十七周
    [self.weekChooseDelegate gotoWeekAtIndex:self.correctIndex];
}


//MARK:-其他方法
/// KVO
/**通过修改correctIndex自动完成以下操作：
//1.该下标对应的周view移动到中央，如果是边缘的按钮那就不会移到中央
//2.对应周的按钮字体变大，原先下标所在的按钮字体复原
//3.让代理(课表)也把课表位置移动到现在的位置
//4.自动判断是否显示“回到本周”按钮
//改变nowWeekBar的周信息
//改变correctIndex，KVO会根据correctIndex的改变完成一系列相关操作,0代表在整学期页
*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    

    if ([change[@"new"] isKindOfClass:[NSNull class]]) {
        return;
    }
    if ([change[@"old"] isKindOfClass:[NSNull class]]) {
        return;
    }
        
        
        if (context == @"TopBarScrollView.correctIndex") {
            
            if([change[@"new"]isEqual:change[@"old"]]){
                return;
            }
            
        //----------------------------改变新旧按钮的字体----------------------------
            //更改旧按钮的的字体
            NSNumber *oldIndex = change[@"old"];
            UIButton *oldBtn = self.weekChooseBtnArray[oldIndex.intValue];
            oldBtn.titleLabel.font =  [UIFont fontWithName:PingFangSCRegular size: 15];
            oldBtn.alpha = 0.81;
            
            //要先改旧按钮，因为如果是第一次调用，那么change[@"old"]就是nil，
            //会导致oldBtn==newBtn，所以先改新按钮会导致新按钮的修改被旧按钮的修改覆盖
            
            //更改新按钮的的字体
            NSNumber *newIndex = change[@"new"];
            UIButton *newBtn = self.weekChooseBtnArray[newIndex.intValue];
            newBtn.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size: 18];
            newBtn.alpha = 1;
        //------------------------------------------------------------------------------
           
            
            
        //------------------------让新按钮移到周选择条的中央---------------------------
            //动画时长
            float duration = abs(newIndex.intValue-oldIndex.intValue)*0.3;
            if(duration>0.6)duration=0.6;
            
            //weekChooseBar的contentOffset的x会用contentOffsetX赋值
            float contentOffsetX = newBtn.center.x-0.5*MAIN_SCREEN_W;
            //下面的两个判断是为了避免第一个按钮和最后一个按钮被移到中间，导致条出现空白处
            if(contentOffsetX < 0) contentOffsetX = 0;
            if(contentOffsetX > self.weekChooseBar.contentSize.width-self.weekChooseBar.frame.size.width){
                contentOffsetX = self.weekChooseBar.contentSize.width-self.weekChooseBar.frame.size.width;
            }
            
            [UIView animateWithDuration:duration animations:^{
                [self.weekChooseBar setContentOffset:CGPointMake(contentOffsetX, 0)];
            }];
        //------------------------------------------------------------------------------
            
            
            //改变nowWeekBar上面显示当前周数的label的字为新按钮的标题
            self.weekLabel.text = newBtn.titleLabel.text;
            
            //根据新下标判断当前显示的课表是不是本周的课表，
            //如果是，那么nowWeekLabel的标题为@" (本周) "，且隐藏回到本周按钮
            //如果不是那标题就为@" "，且显示回到本周按钮
            if(newIndex.intValue==self.dateModel.nowWeek.intValue){
                self.nowWeekLabel.text = @" (本周) ";
                [UIView animateWithDuration:0.5 animations:^{
                    self.backCurrentWeekBtn.alpha = 0;
                }];
            }else{
                [UIView animateWithDuration:0.5 animations:^{
                    self.backCurrentWeekBtn.alpha = 1;
                }];
                self.nowWeekLabel.text = @" ";
            }
            
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    
}

///移除KVO
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"correctIndex"];
}

@end
