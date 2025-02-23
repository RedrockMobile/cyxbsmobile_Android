//
//  ChooseStudentListViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/29.
//  Copyright © 2020 Redrock. All rights reserved.
//点击键盘上的搜索按钮后跳转的那个选择人的界面就是这个类

#import "ChooseStudentListViewController.h"
#import "PeopleListCellTableViewCell.h"
#import "WYCClassBookViewController.h"
#import "MXObjCBackButton.h"
//#import "WYCClassAndRemindDataModel.h"

@interface ChooseStudentListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ClassmatesList *classmatesList;

@property (nonatomic, weak)UITableView *tableView;
/**返回按钮*/
@property (nonatomic, weak)MXObjCBackButton *backButton;
/**显示“同学课表”四个字的label*/
@property (nonatomic, weak)UILabel *titleLabel;
@end

@implementation ChooseStudentListViewController
- (instancetype)initWithClassmatesList:(ClassmatesList *)classmatesList {
    if (self = [super init]) {
        self.classmatesList = classmatesList;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.classmatesList);
    //添加tableView
    [self addTableView];
    //添加返回按钮
    [self addBackButton];
    //添加显示同学课表四个字的label
    [self addTitleLabel];
    
    if (@available(iOS 11.0, *)) {
        self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
}

//MARK: - 初始化子控件的方法：
//添加tableView
- (void)addTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 87, self.view.width, self.view.height - 87) style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[PeopleListCellTableViewCell class] forCellReuseIdentifier:@"PeopleListCell"];
    [self.view addSubview:tableView];
}

//添加返回按钮
- (void)addBackButton {
    MXObjCBackButton *button = [[MXObjCBackButton alloc] initWithIsAutoHotspotExpand:YES];
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

//添加显示“同学课表”四个字的label
- (void)addTitleLabel {
    UILabel *label = [[UILabel alloc]init];
    self.titleLabel = label;
    if(self.peopleType==PeopleTypeStudent){
        label.text = @"同学课表";
    }else{
        label.text = @"老师课表";
    }
    label.font = [UIFont fontWithName:PingFangSCSemibold size:21];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backButton).offset(14);
        make.centerY.equalTo(self.backButton);
    }];
}


//MARK: - 需要实现的代理方法：
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PeopleListCellTableViewCell *cell = [[PeopleListCellTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PeopleListCell"];
    cell.textLabel.text = self.classmatesList.classmatesArray[indexPath.row].name;
    cell.detailTextLabel.text = self.classmatesList.classmatesArray[indexPath.row].major;
    cell.stuNumLabel.text = self.classmatesList.classmatesArray[indexPath.row].stuNum;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classmatesList.classmatesArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    ClassmateItem *item = self.classmatesList.classmatesArray[indexPath.row];
    
    WYCClassBookViewController *vc = [[WYCClassBookViewController alloc] init];
    
    WYCClassAndRemindDataModel *model = [[WYCClassAndRemindDataModel alloc]init];
    
    vc.schedulType = ScheduleTypeClassmate;
    
    model.delegate = vc;
    
    vc.model = model;
    
    if(self.peopleType==PeopleTypeStudent){
        [model getClassBookArrayFromNet:item.stuNum];
    }else{
        [model getTeaClassBookArrayFromNet:@{
            @"teaName":item.name,
            @"tea":item.teaNum
        }];
    }
    [self presentViewController:vc animated:YES completion:nil];
     */
    ClassmateItem *item = self.classmatesList.classmatesArray[indexPath.row];
    id info;
    ScheduleType type;
    if(self.peopleType==PeopleTypeStudent){
        info = item.stuNum;
        type = ScheduleTypeClassmate;
    }else{
        info = @{
            @"teaName":item.name,
            @"tea":item.teaNum
        };
        type = ScheduleTypeTeacher;
    }
    
    WYCClassBookViewController *vc = [[WYCClassBookViewController alloc] initWithType:type andInfo:info];
    [self presentViewController:vc animated:YES completion:nil];
}


//MARK: - 点击某按钮后调用的方法：
//点击返回按钮后调用的方法
- (void)popController {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
