//
//  FeedBackMainPageViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "FeedBackMainPageViewController.h"

#import "HintView.h"
#import "HistoricalFeedBackViewController.h"
#import "CommonQuestionCell.h"
#import "FeedBackVC.h"
#import "CommonQuestionDetailVC.h"
#import "NewQAHud.h"
#import "CommonQuestionData.h"

@interface FeedBackMainPageViewController ()<UITableViewDelegate,UITableViewDataSource>
///常见问题标题
@property (nonatomic,strong) UILabel *commonQuestionsLbl;
///table
@property (nonatomic,strong) UITableView *table;
///意见反馈入口按钮
@property (nonatomic,strong) UIButton *feedBackEntranceBtn;
///提示反馈qq群View
@property (nonatomic,strong) HintView *hintView;
///历史反馈入口按钮
@property (nonatomic,strong) UIButton *historyBtn;
///跳转添加QQ群按钮
@property (nonatomic,strong) UIButton *jumpBtn;
///常见问题数组
@property (nonatomic,strong) NSArray *CommonQuestionAry;
@end

@implementation FeedBackMainPageViewController
#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupBar];
    [self.view addSubview:self.commonQuestionsLbl];
    [self.view addSubview:self.table];
    [self.view addSubview:self.feedBackEntranceBtn];
    [self.view addSubview:self.hintView];
    [self.topBarView addSubview:self.historyBtn];
    [self.view addSubview:self.jumpBtn];
}
#pragma mark - setter
- (void)setCommonQuestionAry:(NSArray *)CommonQuestionAry{
    _CommonQuestionAry = CommonQuestionAry;
    [self.table reloadData];
}

#pragma mark - Table数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.CommonQuestionAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonQuestionData *data = self.CommonQuestionAry[indexPath.row];
    CommonQuestionCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"CommonQuestionCell" owner:nil options:nil]firstObject];
    cell.mainLabel.text = data.title;
    return cell;
}

#pragma mark - Table代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonQuestionDetailVC *cvc = [[CommonQuestionDetailVC alloc]initWithIndexPathRow:indexPath.row];
    [self.navigationController pushViewController:cvc animated:YES];
}
#pragma mark - getter
- (UILabel *)commonQuestionsLbl{
    if (!_commonQuestionsLbl) {
        _commonQuestionsLbl = [[UILabel alloc]initWithFrame:CGRectMake(0.042*SCREEN_WIDTH, Bar_H+27, 83, 28)];
        _commonQuestionsLbl.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        _commonQuestionsLbl.text = @"常见问题";
        _commonQuestionsLbl.font = [UIFont fontWithName:PingFangSCSemibold size:20];
    }
    return _commonQuestionsLbl;
}

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, Bar_H+65, SCREEN_WIDTH, 500)];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
        _table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _table;
}

- (UIButton *)feedBackEntranceBtn{
    if (!_feedBackEntranceBtn) {
        _feedBackEntranceBtn = [[UIButton alloc]init];
        _feedBackEntranceBtn.size = CGSizeMake(155, 39);
        _feedBackEntranceBtn.centerX = self.view.centerX;
        _feedBackEntranceBtn.y = 0.733*SCREEN_HEIGHT+Bar_H;
        [_feedBackEntranceBtn setImage:[UIImage imageNamed:@"Entrance"] forState:UIControlStateNormal];
        [_feedBackEntranceBtn addTarget:self action:@selector(entrance) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feedBackEntranceBtn;
}

- (HintView *)hintView{
    if (!_hintView) {
        _hintView = [[HintView alloc]init];
        _hintView.size = CGSizeMake(202, 15);
        _hintView.y = 0.82*SCREEN_HEIGHT+Bar_H;
        _hintView.centerX = self.view.centerX;
    }
    return _hintView;
}

- (UIButton *)historyBtn{
    if (!_historyBtn) {
        _historyBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.909*SCREEN_WIDTH, 15, 18, 19)];
        [_historyBtn setImage:[UIImage imageNamed:@"His"]forState:UIControlStateNormal];
        [_historyBtn addTarget:self action:@selector(history) forControlEvents:UIControlEventTouchUpInside];
    }
    return _historyBtn;
}

- (UIButton *)jumpBtn{
    if (!_jumpBtn) {
        _jumpBtn = [[UIButton alloc]initWithFrame:self.hintView.frame];
        _jumpBtn.backgroundColor = [UIColor clearColor];
        [_jumpBtn addTarget:self action:@selector(jumptoQQ) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jumpBtn;
}

#pragma mark - 私有方法
- (void)setupBar{
    self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    self.VCTitleStr = @"意见与反馈";
    self.topBarView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    self.splitLineColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E4E4E9" alpha:1] darkColor:[UIColor colorWithHexString:@"#2C2B2E" alpha:1]];
    self.titlePosition = TopBarViewTitlePositionLeft;
    self.titleFont = [UIFont fontWithName:PingFangSCSemibold size:21];
}

- (void)entrance{
    FeedBackVC *fvc = [[FeedBackVC alloc]init];
    fvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fvc animated:YES];
    
}

- (void)history{
    HistoricalFeedBackViewController *hvc = [[HistoricalFeedBackViewController alloc]init];
    hvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hvc animated:YES];
}

- (void)setupData{
    [CommonQuestionData CommonQuestionDataWithSuccess:^(NSArray * _Nonnull array) {
        self.CommonQuestionAry = array;
        
        } error:^{
            [NewQAHud showHudWith:@"网络异常" AddView:self.view];
        }];
}

#pragma mark - 跳转至qq
- (NSURL*)getQQQunUrl{
    NSString *qq_number = @"570919844";
    NSString* urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", qq_number, @"44a6e01f2dab126f87ecd2ec7b7e66ae259b30535fd0c2c25776271e8c0ac08f"];
    return [NSURL URLWithString:urlStr];
}

- (void)jumptoQQ{
    NSURL* url = [self getQQQunUrl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{
            
        } completionHandler:nil];
    }else{
        [NewQAHud showHudWith:@"打开URL失败" AddView:self.view];
    }
}
@end
