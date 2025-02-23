//
//  DLReminderSetTimeVC.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/10.
//  Copyright © 2020 Redrock. All rights reserved.
//最终编辑备忘时间的页面


#import "DLReminderSetTimeVC.h"
#import "DLReminderView.h"
#import "DLReminderView+Reset.h"
#import "DLWeeklSelectView.h"
#import "DLTimeSelectView.h"
#import "DLReminderModel.h"
#import "DLTimeSelectedButton.h"
#import "DLHistodyButton.h"
#import "TimeBtnSelectedBackView.h"
#import "NoticeWaySelectView.h"
#import "LocalNotiManager.h"

#define kRateX [UIScreen mainScreen].bounds.size.width/375   //以iPhoneX为基准
#define kRateY [UIScreen mainScreen].bounds.size.height/812  //以iPhoneX为基准

@interface DLReminderSetTimeVC ()<UITextFieldDelegate, WeekSelectDelegate,DLTimeSelectViewDelegate,TimeBtnSelectedBackViewDeleget,NoticeWaySelectViewDelegate>
@property (nonatomic, strong) UIPickerView *timePiker;
@property (nonatomic, strong) DLReminderView *reminderView;

/// 周选择view，懒加载
@property (nonatomic, strong) DLWeeklSelectView *weekselectView;

/// 时间选择view，懒加载
@property (nonatomic, strong) DLTimeSelectView *timeSelectView;

//@property (nonatomic, copy) NSArray *weekArray;

@property (nonatomic, strong)NoticeWaySelectView *notiWaySelecter;

///存储已选择的周@[@"第一周",@"第三周"...]
@property (nonatomic, strong) NSArray *weekSelectedArray;

/// 提醒方式的字符串.@"不提醒"、@"提前5分钟"......
@property (nonatomic, copy)NSString *notiStr;

/// 显示已经添加时间的按钮的背景view
@property (nonatomic,strong)TimeBtnSelectedBackView *backViewOfTimeSelectedBtn;

@property (nonatomic,strong)UIButton *ifNotiBtn;

@property (nonatomic,strong)NoteDataModel *modelNeedBeDelete;

/// 显示点击的是哪一周的空课，点击这个按钮后会弹出选择周按钮
@property (nonatomic,strong)UIButton *nowWeekBtn;
@end

@implementation DLReminderSetTimeVC

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.weekSelectedArray = [@[] mutableCopy];
    self.timeDictArray = [NSMutableArray array];
    [self addReminderView];
    [self addBackViewOfTimeSelectedBtn];
//    [self loadAddButton];
    
    UIButton *weekChooseBtn =  [self getBtnWithTitileStr:@"备忘周"];
    [self.reminderView addSubview:weekChooseBtn];
    self.nowWeekBtn = weekChooseBtn;
    [weekChooseBtn addTarget:self action:@selector(showWeekselectView) forControlEvents:UIControlEventTouchUpInside];

    [weekChooseBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reminderView).offset(MAIN_SCREEN_W*0.0534);
        make.top.equalTo(self.reminderView).offset(MAIN_SCREEN_H*0.3789);
    }];
//
    UIButton *ifNotiBtn = [self getBtnWithTitileStr:@"不提醒"];
    [self.reminderView addSubview:ifNotiBtn];
    self.ifNotiBtn = ifNotiBtn;

    [ifNotiBtn addTarget:self action:@selector(pushNotiWaySelecter) forControlEvents:UIControlEventTouchUpInside];
    
    [ifNotiBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reminderView).offset(MAIN_SCREEN_W*0.0534);
        make.top.equalTo(self.backViewOfTimeSelectedBtn.mas_bottom).offset(10);
    }];
    
    [self.reminderView.nextBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ifNotiBtn.mas_bottom).offset(10);
        make.centerX.equalTo(self.reminderView);
        make.width.mas_equalTo(66*kRateX);
        make.height.mas_equalTo(66*kRateX);
    }];
    
    self.notiStr = @"不提醒";
    
    if(self.remind!=nil){
        //self.remind非空，说明是点了某一空课处添加备忘，所以根据传来的空课信息初始化self
        [self initDataForAddNoteWithDict:self.remind];
    }
}

#pragma mark - 点击事件
//点击下方的大勾勾按钮
//@{@"weekString":@"",  @"lessonString":@""}
- (void)didClickNextButton:(UIButton *)button{
    int mark=0;
    if(self.timeDictArray.count==0){
        mark+=1;
    }
    if(self.weekSelectedArray.count==0){
        mark+=2;
    }
//    self.notiStr默认为@“不提醒”，所以不可能为空，故这里不作判断
    NSArray *textArray  = @[@"",@"还没有选择具体时间",@"还没有选择备忘周",@"什么时间都还没选呢",];
    if(mark!=0){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setMode:(MBProgressHUDModeText)];
        hud.labelText = textArray[mark];
        [hud hide:YES afterDelay:1];
        return;
    }else{
        NoteDataModel *model = [[NoteDataModel alloc] initWithNoteDataDict:@{
            @"weeksStrArray":self.weekSelectedArray,
            @"timeStrDictArray":self.timeDictArray,
            @"notiBeforeTime":self.notiStr,
            @"noteTitleStr":self.noticeString,
            @"noteDetailStr":self.reminderView.textFiled.text,
            @"weekNameStr":self.nowWeekBtn.titleLabel.text,
        }];
        
        if(self.navigationController!=nil){
            //如果nav不是空，那么就是点击没课的空白处后进行添加备忘的，那么：
            [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LessonViewShouldAddNote" object:model];
        }else{
            //否则就是通过点击备忘详情弹窗的修改按钮后来到这个控制器的，那么：
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LessonViewShouldEditNote" object:@{@"new":model, @"old":self.modelNeedBeDelete}];
        }
    }
}

/// 显示@“备忘周”3字、@“不提醒“的那两个按钮从次获得
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
//    HistodayButtonLabelColor
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

- (void)back{
    if(self.navigationController!=nil){
        //如果nav不是空，那么就是点击没课的空白处后进行添加备忘的，那么：
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //否则就是通过点击备忘详情弹窗的修改按钮后来到这个控制器的，那么：
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

/// 弹出选择周的view
- (void)showWeekselectView{
    self.weekselectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, MAIN_SCREEN_H+360*kRateY);
    [self.reminderView addSubview: self.weekselectView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.weekselectView.frame = CGRectMake(0, -360*kRateY, SCREEN_WIDTH, MAIN_SCREEN_H+360*kRateY);
    }];
}

/// 弹出选择时间的view
- (void)showTimeSelectView{
    self.timeSelectView.frame = CGRectMake(0, 0, MAIN_SCREEN_W, 300*kRateY+MAIN_SCREEN_H);
    [self.reminderView addSubview:self.timeSelectView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.timeSelectView.frame = CGRectMake(0, -300*kRateY, SCREEN_WIDTH, 300*kRateY+MAIN_SCREEN_H);
    }];
}

/// 推出选择
- (void)pushNotiWaySelecter{
    [self.notiWaySelecter setFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H+0.4261*MAIN_SCREEN_H)];
    [self.view addSubview:self.notiWaySelecter];
    [UIView animateWithDuration:0.5 animations:^{
        self.notiWaySelecter.frame = CGRectMake(0, -0.4261*MAIN_SCREEN_H, MAIN_SCREEN_W, MAIN_SCREEN_H+0.4261*MAIN_SCREEN_H);
    }];
}

#pragma mark - delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/// 点击周选择view的确定按钮后调用的代理方法
/// @param stringArray 在WeekSelect里面选择的周的标题组成的数组
- (void)selectedTimeStringArray:(NSArray *)stringArray{
    self.weekSelectedArray = stringArray;
}

/// 点击时间选择view里的加号后调用的代理方法
/// @param dataDict picker所选择的数据，结构：@{@"weekString":@"",  @"lessonString":@""}
- (void)pickerDidSelectedWithDataDict:(NSDictionary *)dataDict{
    [self.backViewOfTimeSelectedBtn loadSelectedButtonsWithTimeDict:dataDict];
}

/// 选择提醒方式的view上的确定按钮点击后调用的代理方法
/// @param notiStr 提醒方式字符串
- (void)notiPickerDidSelectedWithString:(NSString *)notiStr{
    self.notiStr = notiStr;
    [self.ifNotiBtn setTitle:notiStr forState:UIControlStateNormal];
}
#pragma mark - 懒加载&加载

- (DLWeeklSelectView *)weekselectView{
    if (!_weekselectView) {
        _weekselectView = [[DLWeeklSelectView alloc] init];
        _weekselectView.delegate = self;
    }
    return _weekselectView;
}

- (DLTimeSelectView *)timeSelectView{
    if (!_timeSelectView) {
        _timeSelectView = [[DLTimeSelectView alloc] init];
        _timeSelectView.delegate = self;
    }
    return _timeSelectView;
}

- (NoticeWaySelectView *)notiWaySelecter{
    if(_notiWaySelecter==nil){
        _notiWaySelecter = [[NoticeWaySelectView alloc] init];
        _notiWaySelecter.delegate = self;
    }
    return _notiWaySelecter;
}
/// 加上背景
- (void)addReminderView{
    self.reminderView = [[DLReminderView alloc] init];
    self.reminderView.frame = self.view.frame;
    [self.view addSubview:self.reminderView];
//    [self.reminderView resetConstrains];
    self.reminderView.titleLab.text = _noticeString;
    self.reminderView.textFiled.delegate = self;
    self.reminderView.textFiled.text = _detailString;
    [self.reminderView.textFiled mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.reminderView).offset(MAIN_SCREEN_H*0.2916);
    }];
    [self.reminderView.nextBtn addTarget:self action:@selector(didClickNextButton:) forControlEvents:UIControlEventTouchUpInside];
    self.reminderView.nextBtn.tag = 1;
    [self.reminderView.backBtn addTarget: self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
}
/// 添加带叉的时间按钮的背景
- (void)addBackViewOfTimeSelectedBtn{
    self.backViewOfTimeSelectedBtn = [[TimeBtnSelectedBackView alloc] init];
    [self.reminderView addSubview:self.backViewOfTimeSelectedBtn];
    self.backViewOfTimeSelectedBtn.timeDateDelegate = self;
    [self.backViewOfTimeSelectedBtn.addBtn addTarget:self action:@selector(showTimeSelectView) forControlEvents:UIControlEventTouchUpInside];
    [self.backViewOfTimeSelectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reminderView);
        make.width.mas_equalTo(MAIN_SCREEN_W);
        make.top.equalTo(self.reminderView).offset(0.4515*MAIN_SCREEN_H);
//        make.bottom.equalTo(self.reminderView).offset(-MAIN_SCREEN_H*0.2);
    }];
}
//点击备忘详情弹窗的修改按钮后会调用这个方法，来配置一些已选择的数据参数
- (void)initDataForEditNoteWithMode:(NoteDataModel *)model{
    
    //为备忘周控件添加已选周
    [self.weekselectView setWeekBtnsSelectedWithIndexArray:model.weeksArray];
    
    //储存备忘标题的字符串
    self.noticeString = model.noteTitleStr;
    
    //储存备忘详情的字符串
    self.detailString = model.noteDetailStr;
    
    //中央的textfield
    self.reminderView.textFiled.text = model.noteDetailStr;
    
    [self.nowWeekBtn setTitle:model.weekNameStr forState:UIControlStateNormal];
    
    //中央的textfield上面的标题
    self.reminderView.titleLab.text = model.noteTitleStr;
    
    //储存@“不提醒”、@“提前5分钟”按钮上的文字的字符串
    self.notiStr = model.notiBeforeTime;
    
    //@“不提醒”、@“提前5分钟”按钮的标题加字
    [self.ifNotiBtn setTitle:model.notiBeforeTime forState:UIControlStateNormal];
    
    //记录已选择的备忘周的数组@[@"第一周",@"第三周"...]
    self.weekSelectedArray = model.weeksStrArray;
    
    //时间选择view、显示已选时间的view、self三者需要共享已选时间的数据，三者各自持有一份数据会导致
    //在数据同步上面花过多代码，故这里决定通过代理实现三者共用一份数据，但是对于数据的的修改操作都放在
    //self.backViewOfTimeSelectedBt里面，所以这里通过调用loadSelectedButtonsWithTimeDict
    //添加已选周的数据。
    //如果没完全了解结构，不要在self里修改self.timeDictArray来增删数据，否则可能会出错
    for (NSDictionary *dict in model.timeStrDictArray) {
        [self.backViewOfTimeSelectedBtn loadSelectedButtonsWithTimeDict:dict];
    }
    self.modelNeedBeDelete = model;
}

/// 根据传来的空课信息初始化self
/// @param dict 空课信息字典，结构@{
///    @"hash_day":0,
///   @"hash_lesson":2,
///    @"period":2,
///    @"week": @"3"、@“5”，第week周的空课，week=0代表整学期
/// };
- (void)initDataForAddNoteWithDict:(NSDictionary*)dict{
    
    //为选择备忘周的控件添加已选周
    [self.weekselectView setWeekBtnsSelectedWithIndexArray:@[dict[@"week"]]];
    NSArray *transfer = @[@"整学期", @"第一周", @"第二周", @"第三周", @"第四周", @"第五周", @"第六周", @"第七周", @"第八周", @"第九周", @"第十周", @"第十一周", @"第十二周", @"第十三周", @"第十四周", @"第十五周", @"第十六周", @"第十七周", @"第十八周", @"第十九周", @"第二十周", @"第二十一周",@"第二十二周",@"第二十三周",@"第二十四周",@"第二十五周"];
    
    //记录已选择的备忘周的数组@[@"第一周",@"第三周"...]
    self.weekSelectedArray = @[transfer[[dict[@"week"] intValue]]];
    //把选择周的按钮的字变成那个空课的所在周
    [self.nowWeekBtn setTitle:transfer[[dict[@"week"] intValue]] forState:UIControlStateNormal];
    
    NSArray *WT = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSArray *LT = @[@"一二节课",@"三四节课",@"五六节课",@"七八节课",@"九十节课",@"十一十二节课"];
    
    [self.backViewOfTimeSelectedBtn loadSelectedButtonsWithTimeDict:@{
        @"weekString":WT[[dict[@"hash_day"] intValue]],
        @"lessonString":LT[[dict[@"hash_lesson"] intValue]]
    }];
}
//@{@"weekString":@"",  @"lessonString":@""}
@end
