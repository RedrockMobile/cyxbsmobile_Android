//
//  ScoreViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/2/12.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ScoreViewController.h"
#import "SCChart.h"
#import "UserInfoView.h"
#import "ScoreTwoTitleView.h"
#import "ABScoreView.h"
#import "DetailScorePerYearCell.h"
#import "IdsBinding.h"
#import "GPA.h"
#import "GPAItem.h"
#import "IDSController.h"

@interface ScoreViewController ()<SCChartDataSource, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak)UserInfoView *userInfoView;
@property (nonatomic, weak)UIScrollView *contentView;
@property (nonatomic, weak)UIView *twoTitleView;//学风成绩平均绩点
@property (nonatomic, weak)SCChart *chartView;
@property (nonatomic, weak)ABScoreView *ABScoreView;//AB学分
@property (nonatomic, weak)UIView *termBackView;
@property (nonatomic, weak)UILabel *termLabel;//"学期成绩"
@property (nonatomic, weak)UITableView *tableView;//每学年的成绩
@property (nonatomic, strong) IdsBinding * idsBindingModel;//ids绑定
@property (nonatomic, strong) MBProgressHUD *loadHud;
@property (nonatomic,assign)float tableViewCurrentHeight;//tableView的当前高度

@property (nonatomic)GPA *gpaModel;
@property (nonatomic)GPAItem *gpaItem;
@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(idsBindingSuccess) name:@"IdsBinding_Success" object:nil];
    [self addContentView];//scrollView
    [self addUserInfoView];
    [self tryIDSBinding];
    self.tableViewCurrentHeight = [DetailScorePerYearCell plainHeight];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(expandSubjectScoreTableView:) name:@"expandSubjectScoreTableView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contractSubjectScoreTableView:) name:@"contractSubjectScoreTableView" object:nil];
}

-(void)tryIDSBinding {
    NSString *idsPasswd = [NSUserDefaults.standardUserDefaults objectForKey:@"idsPasswd"];
    if ([UserItem defaultItem].idsBindingSuccess) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"IdsBinding_Success" object:nil];
        return;
    }
    if ([NSUserDefaults.standardUserDefaults objectForKey:@"idsAccount"] && idsPasswd) {
        IdsBinding *binding = [[IdsBinding alloc]initWithIdsNum:[NSUserDefaults.standardUserDefaults objectForKey:@"idsAccount"] isPassword:idsPasswd];
        [binding fetchData];
    }else {
        [self addIdsBindingView];//提示用户绑定统一认证码的title;
    }
}

-(void)addIdsBindingView {
    UIViewController *vc = [self.router controllerForRouterPath:@"IDSController"];
    vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}

-(void)expandSubjectScoreTableView:(NSNotification *)notification {
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
        NSNumber *cellHeightIncrease = notification.userInfo[@"cellHeight"];
        self.tableViewCurrentHeight += cellHeightIncrease.floatValue;
//    self.tableViewCurrentHeight += 20;
    [self.tableView setHeight:self.tableViewCurrentHeight];
        self.contentView.contentSize = CGSizeMake(0,self.tableView.height + self.tableView.frame.origin.y+20);
}

-(void)contractSubjectScoreTableView:(NSNotification *)notification {
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
     NSNumber *cellHeightReduce = notification.userInfo[@"cellHeight"];
    self.tableViewCurrentHeight -= cellHeightReduce.floatValue;
//    self.tableViewCurrentHeight -= 20;
    [self.tableView setHeight:self.tableViewCurrentHeight];

    self.contentView.contentSize = CGSizeMake(0,self.tableView.height + self.tableView.frame.origin.y+20);
}

-(void)requestGPASucceed {
//    [self.tableView reloadData];
    //GPA请求成功后进行对象归档
    self.gpaItem = self.gpaModel.gpaItem;
    self.ABScoreView.AScore.text = self.gpaItem.termGrades.a_credit.stringValue;
    self.ABScoreView.BScore.text = self.gpaItem.termGrades.b_credit.stringValue;
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"gpaItemObject.archiver"];
    if([NSKeyedArchiver archiveRootObject:self.gpaModel.gpaItem toFile:filePath]) {
        NSLog(@"归档成功,路径%@",filePath);
    }
    NSLog(@"a = %@, b = %@",self.gpaItem.termGrades.a_credit,self.gpaItem.termGrades.b_credit);

    [self.tableView removeFromSuperview];
    [self addTableView];
    self.contentView.contentSize = CGSizeMake(0,self.tableView.height + self.tableView.frame.origin.y+20);

//    [self.tableView reloadInputViews];
    [self.chartView removeFromSuperview];
    [self addChartView];
}

-(void)idsBindingSuccess {
//    [self.idsBindgView removeFromSuperview];
    NSLog(@"解档");
    NSLog(@"a = %@, b = %@",self.gpaItem.termGrades.a_credit,self.gpaItem.termGrades.b_credit);
    self.gpaItem = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"gpaItemObject.archiver"]];
    self.contentView.contentSize = CGSizeMake(0,self.tableView.height + self.tableView.frame.origin.y+20);

//    NSLog(@"%@,%@",self.gpaItem.termGrades.a_credit,self.gpaItem.termGrades.b_credit);

    [self.loadHud hide:YES];
    [self addTwoTitleView];
    [self addChartView];
    [self addABScoreView];//AB学分
    [self addTermScoreView];//“学期成绩”
    [self addTableView];
      
    [self requestGPA];
      // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGPASucceed) name:@"GPASucceed" object:nil];
}

- (void)addContentView {
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    self.contentView = scrollView;
    [scrollView setBounces:NO];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(0, 0);
    if (@available(iOS 11.0, *)) {
        scrollView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:0.1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:0.5]];
    }
    [self.view addSubview:scrollView];
}

- (void)addUserInfoView {
    UserInfoView *userInfoView  = [[UserInfoView alloc]initWithFrame:CGRectMake(0, 0, self.view.width,86)];
    self.userInfoView = userInfoView;
    [self.contentView addSubview:userInfoView];
}

- (void)addTwoTitleView {
    ScoreTwoTitleView *view = [[ScoreTwoTitleView alloc]initWithFrame:CGRectMake(0, self.userInfoView.origin.y + self.userInfoView.height + 2, self.view.width, 128)];
    self.twoTitleView = view;
//    view.backgroundColor = UIColor.greenColor;
    [self.contentView addSubview:view];
}

- (void)addChartView {
    SCChart *chartView = [[SCChart alloc]initwithSCChartDataFrame:CGRectMake(0, self.twoTitleView.origin.y + self.twoTitleView.height + 2, self.view.width, 180) withSource:self withStyle:SCChartLineStyle];
    
    if (@available(iOS 11.0, *)) {
        chartView.backgroundColor = self.view.backgroundColor;
//        chartView.backgroundColor = [UIColor redColor];
//        chartView.tintColor = [UIColor clearColor];
//        chartView.tintColor
        
    } else {
        // Fallback on earlier versions
    }
    [chartView showInView:self.contentView];
    self.chartView = chartView;
}

- (void)addABScoreView {
    ABScoreView *view = [[ABScoreView alloc]initWithFrame:CGRectMake(0, self.chartView.origin.y + self.chartView.size.height, self.view.width, 90)];
    self.ABScoreView = view;
    self.ABScoreView.AScore.text = self.gpaItem.termGrades.a_credit.stringValue;
    self.ABScoreView.BScore.text = self.gpaItem.termGrades.b_credit.stringValue;
    [self.contentView addSubview:view];
}

- (void)addTermScoreView {
    UIView *termBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.ABScoreView.origin.y + self.ABScoreView.height + 2, self.view.width, 53)];
    self.termBackView = termBackView;
    if (@available(iOS 11.0, *)) {
        termBackView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    [self.contentView addSubview:termBackView];
    UILabel *termLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 27, 200, 26)];
    termLabel.font = [UIFont fontWithName:PingFangSCSemibold size:18];
    if (@available(iOS 11.0, *)) {
        termLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    termLabel.text = @"学期成绩";
    self.termLabel = termLabel;
    [self.termBackView addSubview:termLabel];
}

-(void)requestGPA {
    self.gpaModel = [[GPA alloc]init];
    [self.gpaModel fetchData];
}

- (void)addTableView {
    int plainCellHeight = 143;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.termBackView.origin.y + self.termBackView.size.height, self.view.width,plainCellHeight * self.gpaItem.termGrades.termGrades.count+25) style:UITableViewStylePlain];
    self.tableView = tableView;
    self.tableViewCurrentHeight = tableView.height;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [self.contentView addSubview:tableView];
}

//MARK: - 折线图代理

- (NSArray *)getXTitles:(int)num {
    NSMutableArray *xTitles = [NSMutableArray array];
    xTitles = [@[
        @"大一上", @"大一下", @"大二上", @"大二下", @"大三上", @"大三下", @"大四上", @"大四下"
    ] mutableCopy];
    
    return xTitles;
}

//横坐标标题数组
- (NSArray *)SCChart_xLableArray:(SCChart *)chart {
    return [self getXTitles:7];
}

- (NSArray *)SCChart_yValueArray:(SCChart *)chart {
    if ([self getChartArray] != nil) {
        return @[[self getChartArray]];
        NSLog(@"%@", [self getChartArray]);
    }
    NSMutableArray *ary = [NSMutableArray array];
    ary = [@[@0] mutableCopy];//备用数据
    return @[ary];
}

- (NSArray *)SCChart_ColorArray:(SCChart *)chart {
    if (@available(iOS 11.0, *)) {
        return @[[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2921D1" alpha:1] darkColor:[UIColor colorWithHexString:@"#736CFF" alpha:1]]];
    } else {
        // Fallback on earlier versions
        return @[[UIColor colorWithHexString:@"#2921D1"]];
    }
}

- (BOOL)SCChart:(SCChart *)chart ShowMaxMinAtIndex:(NSInteger)index {
    return YES;
}

- (BOOL)SCChart:(SCChart *)chart ShowHorizonLineAtIndex:(NSInteger)index {
    return YES;
}

-(NSArray*)getChartArray {
    NSMutableArray *arr = [NSMutableArray array];
    for (TermGrade *t in self.gpaItem.termGrades.termGrades) {
        double gpaNumber = t.gpa.doubleValue;
//            NSString *gpa = gpaNumber.stringValue;
            [arr addObject:@(gpaNumber)];
    }
    NSLog(@"%@",self.gpaItem.termGrades.termGrades);
    NSArray *array = arr;
    return array;
}


//MARK: - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.gpaItem.termGrades.termGrades.count) {
        return self.gpaItem.termGrades.termGrades.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailScorePerYearCell *cell = [[DetailScorePerYearCell alloc]init];
    if(self.gpaItem.termGrades.termGrades[indexPath.row].term) {
        cell.timeLabel.text = [self getTermTitleWithString:self.gpaItem.termGrades.termGrades[indexPath.row].term];
    }
    if(self.gpaItem.termGrades.termGrades[indexPath.row].gpa) {
        cell.averangePointLabel.text = [NSString stringWithFormat:@"%.2f",self.gpaItem.termGrades.termGrades[indexPath.row].gpa.floatValue];
        
    }
    if(self.gpaItem.termGrades.termGrades[indexPath.row].grade) {
        NSString *averangeScore = [NSString stringWithFormat:@"%.2f",self.gpaItem.termGrades.termGrades[indexPath.row].grade.floatValue];
        
        cell.averangeScoreLabel.text = averangeScore;
    }
    if (self.gpaItem.termGrades.termGrades[indexPath.row].rank) {
        cell.averangeRankLabel.text = [NSString stringWithFormat:@"%.2f",self.gpaItem.termGrades.termGrades[indexPath.row].rank.floatValue];
    }
    if(self.gpaItem.termGrades.termGrades[indexPath.row].singegradesArr) {
        cell.singleGradesArray =self.gpaItem.termGrades.termGrades[indexPath.row].singegradesArr;
        cell.openingHeight = cell.subjectCellHeight*cell.singleGradesArray.count+[cell.class plainHeight];

    }
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailScorePerYearCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if(cell.tableViewIsOpen) {
        return cell.openingHeight;
    }
    return DetailScorePerYearCell.plainHeight;
}

-(NSString*)getTermTitleWithString:(NSString*)string {
    NSNumber *startYear = [string substringToIndex:4].numberValue;
    NSNumber *endYear = [NSNumber numberWithInt:startYear.intValue+1];
    if([[string substringFromIndex:4] isEqual:@"1"]) {
        return [NSString stringWithFormat:@"%@-%@第一学期",startYear,endYear];
    }else {
        return [NSString stringWithFormat:@"%@-%@第二学期",startYear,endYear];
    }
}

#pragma mark - lan加载
- (GPAItem *)gpaItem{
    if (!_gpaItem) {
        _gpaItem = [[GPAItem alloc] init];
    }
    return _gpaItem;
}

@end
