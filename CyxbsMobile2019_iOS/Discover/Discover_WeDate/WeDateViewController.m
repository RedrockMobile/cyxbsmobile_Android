//
//  WeDateViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/7/30.
//  Copyright © 2020 Redrock. All rights reserved.
//这个类是没课约最开始的那个页面的控制器

#import "WeDateViewController.h"
#import "PeopleListTableViewCell.h"
#import "ChoosePeopleListView.h"
#import "ClassmatesList.h"
#import "WYCClassBookViewController.h"

#define URL @"https://cyxbsmobile.redrock.team/api/kebiao"
#define Color21_49_91_F0F0F2  [UIColor colorNamed:@"color21_49_91&#F0F0F2" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil]
@interface WeDateViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,PeopleListTableViewCellDelegateDelete,PeopleListTableViewCellDelegateAdd>
/**推出没课约的按钮*/
@property (nonatomic, strong)UIButton *backButton;
/**显示“没课约”3个字的label*/
@property (nonatomic, strong)UILabel *titleLabel;
/**搜索框*/
@property (nonatomic ,strong)UITextField *searchField;
/**显示已经被添加的人的tableView*/
@property (nonatomic ,strong)UITableView *peoleAddedList;
/**紫色的查询按钮*/
@property (nonatomic, strong)UIButton *enquiryBtn;
/**已添加的人的信息*/
@property (nonatomic, strong)NSMutableArray *infoDictArray;
@end

@implementation WeDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addBackButton];
    
    [self addTitleLabel];
    
    [self addSearchField];
    
    [self addPeoleAddedList];
    
    [self addEnquiryBtn];
    self.infoDictArray = [@[@{@"stuNum":@"2019211000",@"name":@"刘"},@{@"stuNum":@"2019211001",@"name":@"范"}] mutableCopy];
}
- (instancetype)initWithInfoDictArray:(NSMutableArray*)infoDictArray{
    self = [super init];
    if(self){
        self.infoDictArray = infoDictArray;
    }
    return self;
}

//MARK: - 初始化子控件的一些方法：
//添加返回按钮
- (void)addBackButton {
    UIButton *button = [[UIButton alloc]init];
    [self.view addSubview:button];
    self.backButton = button;
    [button setImage:[UIImage imageNamed:@"LQQBackButton"] forState:normal];
    [button setImage: [UIImage imageNamed:@"EmptyClassBackButton"] forState:UIControlStateHighlighted];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.top.equalTo(self.view).offset(53);
        make.width.equalTo(@7);
        make.height.equalTo(@14);
    }];
    [button addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
}

//添加显示没课约的那几个字的label
- (void)addTitleLabel {
    UILabel *label = [[UILabel alloc]init];
    self.titleLabel = label;
    self.titleLabel.text = @"没课约";
    label.font = [UIFont fontWithName:PingFangSCBold size:21];
    label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backButton).offset(14);
        make.centerY.equalTo(self.backButton);
    }];
}

//添加搜索框
- (void)addSearchField {
    
    UIView *backgroundView = [[UIView alloc] init];
    [self.view addSubview:backgroundView];
    
    backgroundView.layer.cornerRadius = MAIN_SCREEN_H*0.0271;
    backgroundView.backgroundColor = [UIColor colorWithRed:239/255.0 green:244/255.0 blue:253/255.0 alpha:1.0];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(MAIN_SCREEN_H*0.1441);
        make.left.equalTo(self.view).offset(MAIN_SCREEN_W*0.0427);
        make.bottom.equalTo(self.view).offset(-MAIN_SCREEN_H*0.8017);
        make.right.equalTo(self.view).offset(-MAIN_SCREEN_W*0.0427);
    }];
    
    
    
    UITextField *textField = [[UITextField alloc] init];
    [backgroundView addSubview:textField];
    self.searchField = textField;
    textField.backgroundColor = UIColor.clearColor;
    textField.placeholder = @"添加同学";
    textField.delegate = self;
    textField.font = [UIFont fontWithName:@".PingFang SC" size: 15];
    textField.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).offset(12);
        make.left.equalTo(backgroundView).offset(17);
        make.bottom.equalTo(backgroundView).offset(-11);
        make.right.equalTo(backgroundView).offset(-37);
    }];
    
}

/**添加显示已经被添加的人的tableView*/
- (void)addPeoleAddedList{
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.peoleAddedList = tableView;
    
    
    tableView.showsVerticalScrollIndicator = NO;
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    tableView.allowsSelection = NO;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.searchField.mas_bottom).offset(MAIN_SCREEN_H*0.03);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

//添加查询按钮
- (void)addEnquiryBtn {
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    self.enquiryBtn = btn;
    
    btn.layer.cornerRadius = MAIN_SCREEN_H*0.02465;
    btn.backgroundColor = [UIColor colorWithRed:73/255.0 green:66/255.0 blue:230/255.0 alpha:1.0];
    [btn setTitle:@"查询" forState:UIControlStateNormal];
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(MAIN_SCREEN_H*0.8805);
        make.left.equalTo(self.view).offset(MAIN_SCREEN_W*0.3413);
        make.bottom.equalTo(self.view).offset(-MAIN_SCREEN_H*0.0702);
        make.right.equalTo(self.view).offset(-MAIN_SCREEN_W*0.3387);
    }];
    
    [btn addTarget:self action:@selector(enquiry) forControlEvents:UIControlEventTouchUpInside];
}

//MARK: - 点击某按钮后调用的方法:
//点击键盘上的search键时调用
- (void)search{
    if([self.searchField.text isEqualToString:@""]){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setMode:(MBProgressHUDModeText)];
        hud.labelText = @"输入为空";
        [hud hide:YES afterDelay:1];
        return;
    }
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setMode:(MBProgressHUDModeText)];
    hud.labelText = @"加载中...";
    [hud hide:YES afterDelay:1];
    
    ClassmatesList *list = [[ClassmatesList alloc] initWithPeopleType:(PeopleTypeStudent)];
    
    [list getPeopleListWithName:self.searchField.text success:^(ClassmatesList * _Nonnull classmatesList) {
        
        ChoosePeopleListView *listView = [[ChoosePeopleListView alloc] initWithInfoDictArray:classmatesList.infoDicts];
        listView.frame = [UIScreen mainScreen].bounds;
        listView.delegate = self;
        [self.view addSubview:listView];
        [listView showPeopleListView];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setMode:(MBProgressHUDModeText)];
        hud.labelText = @"加载失败";
        [hud hide:YES afterDelay:1];
    }];
}
//点击退出按钮后调用
- (void)popController {
    [self.navigationController popViewControllerAnimated:YES];
}

//点击紫色的那个查询后调用

- (void)enquiry{
    if(self.infoDictArray.count==0){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setMode:(MBProgressHUDModeText)];
        hud.labelText = @"没有添加同学";
        [hud hide:YES afterDelay:1];
        return;
    }
    
    HttpClient *client = [HttpClient defaultClient];
    __block NSMutableArray *array = [NSMutableArray array];

    dispatch_group_t group = dispatch_group_create();
    for (NSDictionary *infoDict in self.infoDictArray) {
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            [client requestWithPath:kebiaoAPI method:HttpRequestPost parameters:@{@"stuNum":infoDict[@"stuNum"]} prepareExecute:^{

            } progress:^(NSProgress *progress) {

            } success:^(NSURLSessionDataTask *task, id responseObject) {

                for (NSDictionary *dict in [responseObject objectForKey:@"data"]) {
                    [array addObject:dict];
                }
                
                dispatch_semaphore_signal(semaphore);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_semaphore_signal(semaphore);
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
     });
    }
    
    //完成group的任务后执行block里的内容
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        WYCClassBookViewController *vc;
        WYCClassAndRemindDataModel *model = [[WYCClassAndRemindDataModel alloc] init];
        model.weekArray = [@[array]mutableCopy];
        [model parsingClassBookData:array];
        [model setValue:@"YES" forKey:@"remindDataLoadFinish"];
        [model setValue:@"YES" forKey:@"classDataLoadFinish"];
        vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WYCClassBookViewController"];
        [vc initStuNum:@"x" andIdNum:@"x"];
        [vc initWYCClassAndRemindDataModel:model];
        
        //present这种刷新UI的操作得放主线程，不然会报错
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:vc animated:YES completion:nil];
        });
     });
}

//MARK: - 需要实现的代理方法：
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoDictArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *infoDict = self.infoDictArray[indexPath.row];
    
    PeopleListTableViewCell *cell = [[PeopleListTableViewCell alloc] initWithInfoDict:infoDict andRightBtnType:(PeopleListTableViewCellRightBtnTypeDelete)];
    cell.delegateDelete = self;
    return cell;
}

//代理方法，点击cell的addBtn时调用，参数infoDict里面是对应那行的数据@{@"name":@"张树洞",@"stuNum":@"20"}
- (void)PeopleListTableViewCellAddBtnClickInfoDict:(NSDictionary *)infoDict{
    if(self.infoDictArray.count>5){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setMode:(MBProgressHUDModeText)];
        hud.labelText = @"最多添加六个";
        [hud hide:YES afterDelay:1];
    
    }else{
        int mark = 0;
        for (NSDictionary *dict in self.infoDictArray) {
            if([dict[@"stuNum"] isEqualToString:infoDict[@"stuNum"]]){
                mark = 1;
                MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [hud setMode:(MBProgressHUDModeText)];
                hud.labelText = @"请勿重复添加";
                [hud hide:YES afterDelay:1];
            }
        }
        
        if(mark==0){
            [self.infoDictArray addObject:infoDict];
            [self.peoleAddedList reloadData];
        }
    }
}

//代理方法，点击cell的deleteBtn时调用，参数infoDict里面是对应那行的数据@{@"name":@"张树洞",@"stuNum":@"20"}
- (void)PeopleListTableViewCellDeleteBtnClickInfoDict:(NSDictionary *)infoDict{
    for (NSDictionary *dict in self.infoDictArray) {
        if([dict[@"stuNum"] isEqualToString:infoDict[@"stuNum"]]){
            [self.infoDictArray removeObject:dict];
            [self.peoleAddedList reloadData];
            break;
        }
    }
}

//textField的代理方法，实现点击键盘上的search按钮就搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField==self.searchField){
        [self search];
    }
    return YES;
}
@end
