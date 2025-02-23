//
//  AttitudeMainPageVC.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/7.
//  Copyright © 2023 Redrock. All rights reserved.
//

// 鉴权：判断id -> 发布
// 加载更多内容
// cell点击 ->投票

// VC
#import "AttitudeMainPageVC.h"
#import "ExpressDetailPageVC.h"
#import "PublishViewController.h"
#import "AttitudeSelfPageViewController.h"
// Model
/// 主页数据
#import "AttitudeMainModel.h"
#import "AttitudeMainPageItem.h"
/// 详情数据
#import "ExpressDetailModel.h"
#import "ExpressPickGetItem.h"
/// 鉴权
#import "AttitudeSelfPageModel.h"
#import "AttitudeSelfPageItem.h"
// View
#import "AttitudeHomeCell.h"
#import "AttitudeMainDefaultView.h"
#import "AttitudeNetWrong.h"

@interface AttitudeMainPageVC () <
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) AttitudeMainModel *attitudeModel;
@property (nonatomic, strong) AttitudeMainPageItem *modelItem;
@property (nonatomic, strong) AttitudeMainDefaultView *defaultView;
@property (nonatomic, strong) AttitudeNetWrong *netWrongView;
@property (nonatomic, assign) BOOL isPermission;

@end

@implementation AttitudeMainPageVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getRequestData];
    [self getPermission];// 鉴权
    
    [self setBarView];
//    [self addTopBarButton];
    self.isTopBarButtonHidden = NO;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
}
// 表态Bar
- (void)setBarView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.VCTitleStr = @"表态区";
    self.titleColor = [UIColor colorWithHexString:@"#15315B"];
    [self.backBtn setImage:[UIImage imageNamed:@"Publish_backBtn"] forState:UIControlStateNormal];
    self.splitLineHidden = YES;
    self.titlePosition = TopBarViewTitlePositionLeft;
    self.topBarView.backgroundColor = [UIColor whiteColor];
    self.titleFont = [UIFont fontWithName:PingFangSCMedium size:22];
    
}
// BarButton
- (void)addTopBarButton {
    // MARK: 鉴权：如果没有权限则隐藏
    if (self.isPermission == 0) {
        self.isTopBarButtonHidden = YES;
        NSLog(@"--------------哈哈哈哈哈%d",self.isPermission);
    }
    self.topBarButton.hidden = self.isTopBarButtonHidden;
    [self.topBarView addSubview:self.topBarButton];
    [self.topBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBarView);
        make.right.equalTo(self.topBarView).mas_offset(-16);
        make.height.equalTo(@18);
        make.width.equalTo(@18);
    }];

}
// 点击事件
- (void)clickPublishBtn {
    NSLog(@"点击按钮进入个人中心");
    AttitudeSelfPageViewController *selfPage = [[AttitudeSelfPageViewController alloc] init];
    [self.navigationController pushViewController:selfPage animated:YES];
}
// 请求数据
- (void)getRequestData {
    [self.attitudeModel requestAttitudeDataWithOffset:0 Limit:30 Success:^(NSArray * _Nonnull array) {
            self.dataArray = array;
            [self.tableView reloadData];
            // 缺省页
            if (self.dataArray.count == 0) {
                [self.view addSubview:self.defaultView];
            }
            NSLog(@"%lu",array.count);
            NSLog(@"ddddd");
        } Failure:^(NSError * _Nonnull error) {
            // 没有网络的页面
            [self.tableView removeFromSuperview];
            [self.view addSubview:self.netWrongView];
            NSLog(@"failure");
        }];
}

// 加载更多数据
- (void)loadMoreData {
    
}
// MARK: 请求鉴权
- (void)getPermission {
    self.isPermission = 0;
    AttitudeSelfPageModel *model = [[AttitudeSelfPageModel alloc] init];
    [model requestAttitudePermissionWithSuccess:^(NSArray * _Nonnull array) {
        AttitudeSelfPageItem *item = [[AttitudeSelfPageItem alloc] init];
        item = array[0];
        self.isPermission = [item.isPerm boolValue];
        [self addTopBarButton];
    } Failure:^(NSError * _Nonnull error) {
        NSLog(@"failure🍂🍂🍂🍂🍂🍂🍂🍂🍂🍂v");
    }];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    AttitudeHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[AttitudeHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
    self.modelItem = self.dataArray[indexPath.row];
    cell.title.text = self.modelItem.title;
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// 点击cell跳进投票
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 传入当前id
    AttitudeMainPageItem *item = self.dataArray[indexPath.row];
    NSNumber *theId = item.theId;
    NSLog(@"%@",item.theId);
    ExpressDetailPageVC *detailPage = [[ExpressDetailPageVC alloc] initWithTheId:theId];
    [self.navigationController pushViewController:detailPage animated:YES];
    NSLog(@"页面跳转");
}

- (AttitudeMainModel *)attitudeModel {
    if (!_attitudeModel) {
        _attitudeModel = [[AttitudeMainModel alloc] init];
    }
    return _attitudeModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat y = self.topBarView.bottom;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kScreenHeight - y) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed:0.949 green:0.953 blue:0.973 alpha:1];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        /*
        _tableView.backgroundColor = [UIColor whiteColor];
        //设置阴影
        _tableView.layer.shadowOpacity = 0.33f;
        _tableView.layer.shadowColor = [UIColor dm_colorWithLightColor: [UIColor colorWithHexString:@"#AEB6D3" alpha:0.16] darkColor: [UIColor colorWithHexString:@"#AEB6D3" alpha:0.16]].CGColor;
        _tableView.layer.shadowOffset = CGSizeMake(0, -5);
         */
    }
    return _tableView;
}

// 缺省页
- (AttitudeMainDefaultView *)defaultView {
    CGFloat y = self.topBarView.bottom;
    if (!_defaultView) {
        _defaultView = [[AttitudeMainDefaultView alloc] initWithDefaultPage];
        _defaultView.frame = CGRectMake(0, y, kScreenWidth, kScreenHeight - y);
    }
    return _defaultView;
}

// 网络错误页面
- (AttitudeNetWrong *)netWrongView {
    CGFloat y = self.topBarView.bottom;
    if (!_netWrongView) {
        _netWrongView = [[AttitudeNetWrong alloc] initWithNetWrong];
        _netWrongView.frame = CGRectMake(0, y, kScreenWidth, kScreenHeight - y);
    }
    return _netWrongView;
}

- (UIButton *)topBarButton {
    if (!_topBarButton) {
        _topBarButton = [[UIButton alloc] init];
        [_topBarButton setImage:[UIImage imageNamed:@"Express_mainPublish"] forState:UIControlStateNormal];
        [_topBarButton addTarget:self action:@selector(clickPublishBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topBarButton;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
