//
//  DetailsMainViewController.m
//  Details
//
//  Created by Edioth Jin on 2021/8/3.
//

#import "DetailsMainViewController.h"
// views
//#import "DetailsCustomizeNavigationBar.h"
#import "SegmentView.h"
#import "DetailsGoodsTableView.h"
#import "DetailsGoodsTableViewCell.h"
#import "DetailsTasksTableView.h"
#import "DetailsTaskTableViewCell.h"
// models
#import "DetailsTaskModel.h"
#import "DetailsgoodsModel.h"
// pod
#import <MJRefresh.h> // 用作下拉刷新和上拉加载更多
// controller
#import "PurchaseinfoViewController.h"

@interface DetailsMainViewController ()
<UITableViewDelegate, SegmentViewDelegate>

/// 分隔栏
@property (nonatomic, strong) SegmentView * segmentView;
/// 水平滑动背景
@property (nonatomic, strong) UIScrollView * horizontalScrollView;
/// 兑换记录
@property (nonatomic, strong) DetailsGoodsTableView * detailsGoodsTableView;
/// 兑换记录界面的下拉刷新
@property (nonatomic, strong) MJRefreshStateHeader * goodsRefreshHeader;
/// 获取记录
@property (nonatomic, strong) DetailsTasksTableView * detailsTasksTableView;
/// 获取记录界面的下拉刷新
@property (nonatomic, strong) MJRefreshStateHeader * tasksRefreshHeader;
/// 获取记录界面的上拉加载更多
@property (nonatomic, strong) MJRefreshAutoStateFooter * tasksLoadMoreFooter;

/// 缺省文字1
@property (nonatomic, strong) UILabel * goodsDefaultLabel;
/// 缺省图片1
@property (nonatomic, strong) UIImageView * goodsDefaultImgView;
/// 缺省文字2
@property (nonatomic, strong) UILabel * taskDefaultLabel;
/// 缺省图片2
@property (nonatomic, strong) UIImageView * taskDefaultImgView;

/// 任务
@property (nonatomic, copy) NSArray * tasksAry;
/// 兑换记录
@property (nonatomic, copy) NSArray * goodsAry;

@end

@implementation DetailsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)dealloc {
    // 移除KVO，否则会导致错误
    [self.horizontalScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - configure

- (void)configureView {
    self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:0.8]];
    self.VCTitleStr = @"邮票明细";
    self.titlePosition = TopBarViewTitlePositionLeft;
    self.splitLineColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:0.1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    self.titleFont = [UIFont fontWithName:PingFangSCSemibold size:22];
    
    CGSize size = self.view.frame.size;

    // segmentView
    [self.view addSubview:self.segmentView];
    self.segmentView.frame = CGRectMake(0, [self getTopBarViewHeight], size.width, 56);
    
    // horizontalScrollView
    [self.view addSubview:self.horizontalScrollView];
    self.horizontalScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.segmentView.frame), size.width, size.height - CGRectGetMaxY(self.segmentView.frame));
    self.horizontalScrollView.contentSize = CGSizeMake(self.horizontalScrollView.frame.size.width * 2, 0);
    self.horizontalScrollView.contentOffset = CGPointMake(0, 0);
    
    CGRect bounds = self.horizontalScrollView.bounds;
    // DetailsGoodsTableView
    [self.horizontalScrollView addSubview:self.detailsGoodsTableView];
    self.detailsGoodsTableView.frame = bounds;
    
    // DetailsTasksTableView
    [self.horizontalScrollView addSubview:self.detailsTasksTableView];
    bounds.origin.x += bounds.size.width;
    self.detailsTasksTableView.frame = bounds;
    
    // goods default label
    [self.detailsGoodsTableView addSubview:self.goodsDefaultLabel];
    [self.goodsDefaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.detailsGoodsTableView);
        make.centerY.mas_equalTo(self.view);
    }];

    [self.detailsGoodsTableView addSubview:self.goodsDefaultImgView];
    [self.goodsDefaultImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.goodsDefaultLabel.mas_top).offset(-16);
        make.centerX.mas_equalTo(self.goodsDefaultLabel);
    }];

//    self.goodsDefaultImgView.hidden = YES;
//    self.goodsDefaultLabel.hidden = YES;

    // task default label
    [self.detailsTasksTableView addSubview:self.taskDefaultLabel];
    [self.taskDefaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.detailsTasksTableView);
        make.centerY.mas_equalTo(self.view);
    }];
    [self.detailsTasksTableView addSubview:self.taskDefaultImgView];
    [self.taskDefaultImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.taskDefaultLabel);
        make.bottom.mas_equalTo(self.taskDefaultLabel.mas_top).offset(-16);
    }];

//    self.taskDefaultLabel.hidden = YES;
//    self.taskDefaultImgView.hidden = YES;
    
    // 一个向上滑的动画
    CGFloat animationTime = 0.4f;
    self.horizontalScrollView.layer.affineTransform = CGAffineTransformMakeTranslation(0, size.height - [self getTopBarViewHeight]);
    [UIView animateWithDuration:animationTime animations:^{
        self.horizontalScrollView.layer.affineTransform = CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];
    // 动画执行完毕再刷新数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 得到数据
        [self.detailsGoodsTableView.mj_header beginRefreshing];
        [self.detailsTasksTableView.mj_header beginRefreshing];
    });
    
    [self.view bringSubviewToFront:self.topBarView];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    CGPoint offset = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
    NSInteger currentIndex = (NSInteger)offset.x / self.horizontalScrollView.frame.size.width + 0.5;
    if (self.segmentView.selectedIndex == currentIndex) {
        return;
    }
    self.segmentView.selectedIndex = currentIndex;
}

#pragma mark - delegate
//MARK:SegmentViewDelegate
- (void)segmentView:(SegmentView *)segmentView alertWithIndex:(NSInteger)index {
    [UIView animateWithDuration:0.5 animations:^{
        self.horizontalScrollView.contentOffset = CGPointMake(self.view.frame.size.width * index, 0);
    }];
}

//MARK:table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView isEqual:self.detailsTasksTableView]) {
        return;
    }
    DetailsGoodsModel * model = self.goodsAry[indexPath.row];
    PurchaseinfoViewController * VC = [[PurchaseinfoViewController alloc] initWithgoodsName:model.goods_name orderID:model.order_id date:model.date  price:model.goods_price received:model.is_received];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.detailsGoodsTableView]) {
        DetailsGoodsTableViewCell * goodsCell = (DetailsGoodsTableViewCell *)cell;
        goodsCell.cellModel = self.goodsAry[indexPath.row];
    }
    else if ([tableView isEqual:self.detailsTasksTableView]) {
        DetailsTaskTableViewCell * taskCell = (DetailsTaskTableViewCell *)cell;
        taskCell.cellModel = self.tasksAry[indexPath.row];
    }
}

#pragma mark - MJRefresh

- (void)refreshGoods {
    // 兑换记录的数据
    [DetailsGoodsModel getDataArySuccess:^(NSArray * _Nonnull array) {
        self.goodsAry = array;
        self.detailsGoodsTableView.dataAry = self.goodsAry;
        if (array.count == 0) {
            self.goodsDefaultLabel.text = @"还没有兑换记录哦";
            self.goodsDefaultImgView.image = [UIImage imageNamed:@"details_goods_defaults"];
            self.goodsDefaultLabel.hidden = NO;
            self.goodsDefaultImgView.hidden = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showalertLbl" object:nil];
        } else {
            self.goodsDefaultLabel.hidden = YES;
            self.goodsDefaultImgView.hidden = YES;
        }
        [self.goodsRefreshHeader endRefreshing];
    } failure:^(void) {
        self.goodsDefaultLabel.text = @"最遥远的距离不是天各一方，而是断网了 TAT";
        self.goodsDefaultImgView.image = [UIImage imageNamed:@"details_network_failure"];
        self.goodsDefaultLabel.hidden = NO;
        self.goodsDefaultImgView.hidden = NO;
        [self.goodsRefreshHeader endRefreshing];
    }];
}

- (void)refreshTasks {
    // 获取记录的数据
    [DetailsTaskModel getDataAryWithPage:1 Size:30 Success:^(NSArray * _Nonnull array) {
        self.tasksAry = array;
        self.detailsTasksTableView.dataAry = self.tasksAry;
        if (array.count == 0) {
            self.taskDefaultLabel.text = @"还没有获取记录，快去做任务吧";
            self.taskDefaultImgView.image = [UIImage imageNamed:@"details_task_defaults"];
            self.taskDefaultLabel.hidden = NO;
            self.taskDefaultImgView.hidden = NO;
            self.tasksLoadMoreFooter.userInteractionEnabled = NO;
        } else {
            self.taskDefaultLabel.hidden = YES;
            self.taskDefaultImgView.hidden = YES;
        }
        [self.tasksRefreshHeader endRefreshing];
    } failure:^(void) {
        self.taskDefaultLabel.text = @"最遥远的距离不是天各一方，而是断网了 TAT";
        self.taskDefaultImgView.image = [UIImage imageNamed:@"details_network_failure"];
        self.taskDefaultLabel.hidden = NO;
        self.taskDefaultImgView.hidden = NO;
        [self.tasksRefreshHeader endRefreshing];
    }];
}

- (void)loadMoreTasks {
    [DetailsTaskModel getDataAryWithPage:self.tasksAry.count / 30 + 1 Size:30 Success:^(NSArray * _Nonnull array) {
        NSMutableArray * mAry = [self.tasksAry mutableCopy];
        [mAry addObjectsFromArray:array];
        self.tasksAry = [mAry copy];
        self.detailsTasksTableView.dataAry = self.tasksAry;
        if (array.count < 30) {
            self.tasksLoadMoreFooter.userInteractionEnabled = NO;
        }
        [self.tasksLoadMoreFooter endRefreshing];
    } failure:^{
            
        [self.tasksLoadMoreFooter endRefreshing];
    }];
}

#pragma mark - getter

- (SegmentView *)segmentView {
    if (_segmentView == nil) {
        _segmentView = [[SegmentView alloc] initWithFrame:(CGRectZero)];
        _segmentView.titles = @[@"兑换记录", @"获取记录"];
        _segmentView.delegate = self;
    }
    return _segmentView;
}

- (UIScrollView *)horizontalScrollView {
    if (_horizontalScrollView == nil) {
        _horizontalScrollView = [[UIScrollView alloc] initWithFrame:(CGRectZero)];
        _horizontalScrollView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.9] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:0.8]];
        _horizontalScrollView.showsHorizontalScrollIndicator = NO;
        _horizontalScrollView.pagingEnabled = YES;
        _horizontalScrollView.layer.cornerRadius = 20;
        [_horizontalScrollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:nil];
    }
    return _horizontalScrollView;
}

- (DetailsGoodsTableView *)detailsGoodsTableView {
    if (_detailsGoodsTableView == nil) {
        _detailsGoodsTableView = [[DetailsGoodsTableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
        _detailsGoodsTableView.delegate = self;
        _detailsGoodsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailsGoodsTableView.mj_header = self.goodsRefreshHeader;
    }
    return _detailsGoodsTableView;
}

- (MJRefreshStateHeader *)goodsRefreshHeader {
    if (_goodsRefreshHeader == nil) {
        _goodsRefreshHeader = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshGoods)];
        [_goodsRefreshHeader setTitle:@"松开手刷新兑换记录" forState:MJRefreshStatePulling];
        [_goodsRefreshHeader setTitle:@"" forState:MJRefreshStateIdle];
        [_goodsRefreshHeader setTitle:@"" forState:MJRefreshStateWillRefresh];
        [_goodsRefreshHeader setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
        _goodsRefreshHeader.lastUpdatedTimeLabel.hidden = YES;
        _goodsRefreshHeader.automaticallyChangeAlpha = YES;
    }
    return _goodsRefreshHeader;
}

- (DetailsTasksTableView *)detailsTasksTableView {
    if (_detailsTasksTableView == nil) {
        _detailsTasksTableView = [[DetailsTasksTableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
        _detailsTasksTableView.delegate = self;
        _detailsTasksTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailsTasksTableView.mj_footer = self.tasksLoadMoreFooter;
        _detailsTasksTableView.mj_header = self.tasksRefreshHeader;
    }
    return _detailsTasksTableView;
}

- (MJRefreshStateHeader *)tasksRefreshHeader {
    if (_tasksRefreshHeader == nil) {
        _tasksRefreshHeader = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTasks)];
        [_tasksRefreshHeader setTitle:@"松开手刷新获取记录" forState:MJRefreshStatePulling];
        [_tasksRefreshHeader setTitle:@"" forState:MJRefreshStateIdle];
        [_tasksRefreshHeader setTitle:@"" forState:MJRefreshStateWillRefresh];
        [_tasksRefreshHeader setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
        _tasksRefreshHeader.lastUpdatedTimeLabel.hidden = YES;
        _tasksRefreshHeader.automaticallyChangeAlpha = YES;
    }
    return _tasksRefreshHeader;
}

- (MJRefreshAutoStateFooter *)tasksLoadMoreFooter {
    if (_tasksLoadMoreFooter == nil) {
        _tasksLoadMoreFooter = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTasks)];
        [_tasksLoadMoreFooter setTitle:@"松开手获取更多记录" forState:MJRefreshStatePulling];
        [_tasksLoadMoreFooter setTitle:@"" forState:MJRefreshStateIdle];
        [_tasksLoadMoreFooter setTitle:@"" forState:MJRefreshStateWillRefresh];
        [_tasksLoadMoreFooter setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
        _tasksLoadMoreFooter.automaticallyChangeAlpha = YES;
    }
    return _tasksLoadMoreFooter;
}

- (UILabel *)goodsDefaultLabel {
    if (_goodsDefaultLabel == nil) {
        _goodsDefaultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodsDefaultLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
        _goodsDefaultLabel.font = [UIFont fontWithName:PingFangSCMedium size:12];
        [_goodsDefaultLabel sizeToFit];
    }
    return _goodsDefaultLabel;
}

- (UIImageView *)goodsDefaultImgView {
    if (_goodsDefaultImgView == nil) {
        _goodsDefaultImgView = [[UIImageView alloc] init];
        [_goodsDefaultImgView sizeToFit];
    }
    return _goodsDefaultImgView;
}

- (UILabel *)taskDefaultLabel {
    if (_taskDefaultLabel == nil) {
        _taskDefaultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _taskDefaultLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
        _taskDefaultLabel.text = @"还没有获取记录，快去做任务吧";
        _taskDefaultLabel.font = [UIFont fontWithName:PingFangSCMedium size:12];
        [_taskDefaultLabel sizeToFit];
    }
    return _taskDefaultLabel;
}

- (UIImageView *)taskDefaultImgView {
    if (_taskDefaultImgView == nil) {
        _taskDefaultImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"details_task_defaults"]];
        [_taskDefaultImgView sizeToFit];
    }
    return _taskDefaultImgView;
}

@end
