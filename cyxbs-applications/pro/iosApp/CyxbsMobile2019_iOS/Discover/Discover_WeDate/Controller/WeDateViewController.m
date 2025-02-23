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

@interface WeDateViewController () <
    UITextFieldDelegate,
    UITableViewDelegate,
    UITableViewDataSource,
    PeopleListTableViewCellDelegateDelete,
    PeopleListTableViewCellDelegateAdd
>
/**推出没课约的按钮*/
@property (nonatomic, strong) UIButton *backButton;
/**显示“没课约”3个字的label*/
@property (nonatomic, strong) UILabel *titleLabel;
/**搜索框*/
@property (nonatomic ,strong) UITextField *searchField;
/**显示已经被添加的人的tableView*/
@property (nonatomic ,strong) UITableView *peoleAddedList;
/**紫色的查询按钮*/
@property (nonatomic, strong) UIButton *enquiryBtn;
/**已添加的人的信息*/ 
@property (nonatomic, strong) NSMutableArray *infoDictArray;
@end

@implementation WeDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
    } else {
        self.view.backgroundColor = UIColor.whiteColor;
    }
    [self addBackButton];
    
    [self addTitleLabel];
    
    [self addSearchField];
    
    [self addPeoleAddedList];
    
    [self addEnquiryBtn];
    /**调试用，可以在最开始就已经添加了两个人
     self.infoDictArray = [@[@{@"stuNum":@"2019211000",@"name":@"刘"},@{@"stuNum":@"2019211001",@"name":@"范"}] mutableCopy];
    */
}
- (instancetype)initWithInfoDictArray:(NSMutableArray*)infoDictArray{
    self = [super init];
    if(self){
        self.infoDictArray = infoDictArray.mutableCopy;
    }
    return self;
}

//MARK: - 初始化子控件的一些方法：
//添加返回按钮
- (void)addBackButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:button];
    self.backButton = button;
    [button setImage:[UIImage imageNamed:@"空教室返回"] forState:UIControlStateNormal];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.centerY.equalTo(self.view.mas_top).offset(22+getStatusBarHeight_Double);
        make.width.equalTo(@7);
        make.height.equalTo(@14);
    }];
    [button addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
}

//添加显示没课约的那几个字的label
- (void)addTitleLabel {
    UILabel *label = [[UILabel alloc]init];
    self.titleLabel = label;
    [self.view addSubview:label];
    
    self.titleLabel.text = @"没课约";
    label.font = [UIFont fontWithName:PingFangSCSemibold size:21];
    //蓝白
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    };
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
    if (@available(iOS 11.0, *)) {
        backgroundView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E8F1FC" alpha:0.77] darkColor:[UIColor colorWithHexString:@"#2C2C2C" alpha:0.72]];
    } else {
        backgroundView.backgroundColor = [UIColor colorWithHexString:@"#E8F1FC"];
    }
    
    
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
    [textField setReturnKeyType:(UIReturnKeySearch)];
    textField.delegate = self;
    textField.font = [UIFont fontWithName:PingFangSC size: 15];
    
    if (@available(iOS 11.0, *)) {
        textField.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        textField.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    
    if (@available(iOS 11.0, *)) {
        textField.tintColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        textField.tintColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    textField.backgroundColor = UIColor.clearColor;
    [self addKeyBoardToolBarforTextField:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).offset(12);
        make.left.equalTo(backgroundView).offset(17);
        make.bottom.equalTo(backgroundView).offset(-11);
        make.right.equalTo(backgroundView).offset(-37);
    }];
    
}

/// 为UITextField自定义键盘上的toolBar
/// @param textField 需要自定义toolBar的UITextField
- (void)addKeyBoardToolBarforTextField:(UITextField*)textField{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, 44)];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(MAIN_SCREEN_W-60, 0, 50, 44)];
    [toolBar addSubview:btn];
    [btn setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(doneClicked) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    [toolBar addSubview:placeHolderLabel];
    placeHolderLabel.text = textField.placeholder;
    placeHolderLabel.font = [UIFont systemFontOfSize:13];
    placeHolderLabel.alpha = 0.8;
    placeHolderLabel.textColor = [UIColor systemGrayColor];
    [placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(toolBar);
        make.top.equalTo(toolBar);
        make.bottom.equalTo(toolBar);
    }];
    
    textField.inputAccessoryView = toolBar;
}

//点击键盘右上角的完成按钮后调用
- (void)doneClicked{
    [self.view endEditing:YES];
    [self search];
}

/**添加显示已经被添加的人的tableView*/
- (void)addPeoleAddedList{
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.peoleAddedList = tableView;
    
    
//    tableView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
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
    if (@available(iOS 11.0, *)) {
        btn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#453DD9" alpha:1] darkColor:[UIColor colorWithHexString:@"#495CF5" alpha:1]];
    } else {
        btn.backgroundColor = [UIColor colorWithRed:0.271 green:0.242 blue:0.850 alpha:1];
    }
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
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setMode:(MBProgressHUDModeText)];
    hud.labelText = @"加载中...";
    
    
    ClassmatesList *list = [[ClassmatesList alloc] initWithPeopleType:(PeopleTypeStudent)];
    
    [list getPeopleListWithName:self.searchField.text success:^(ClassmatesList * _Nonnull classmatesList) {
        if(classmatesList.classmatesArray.count==0){
            
            hud.labelText = @"搜索无结果";
            [hud hide:YES afterDelay:1];
            return;
        }
        [hud hide:YES afterDelay:0.1];
        ChoosePeopleListView *listView = [[ChoosePeopleListView alloc] initWithInfoDictArray:classmatesList.infoDicts];
        listView.frame = [UIScreen mainScreen].bounds;
        listView.delegate = self;
        [self.view addSubview:listView];
        [listView showPeopleListView];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
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
    }else{
//        hud.labelText = @"加载中";
        WYCClassBookViewController *vc = [[WYCClassBookViewController alloc] initWithType:ScheduleTypeWeDate andInfo:self.infoDictArray];
        [self presentViewController:vc animated:YES completion:nil];
        /*
        WYCClassAndRemindDataModel *model = [[WYCClassAndRemindDataModel alloc] init];
        model.delegate = self;
        [model getClassBookArrayFromNetWithInfoDictArr:self.infoDictArray];
        [hud hide:YES afterDelay:0.3];
         */
    }
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
        return;
    }else{
        //检验是否重复添加的标志
        int mark = 0;
        for (NSDictionary *dict in self.infoDictArray) {
            if([dict[@"stuNum"] isEqualToString:infoDict[@"stuNum"]]){
                mark = 1;
                MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [hud setMode:(MBProgressHUDModeText)];
                hud.labelText = @"请勿重复添加";
                [hud hide:YES afterDelay:1];
                break;
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
