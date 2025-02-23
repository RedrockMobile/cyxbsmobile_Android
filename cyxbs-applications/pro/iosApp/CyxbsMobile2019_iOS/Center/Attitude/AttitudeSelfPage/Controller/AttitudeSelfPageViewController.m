//
//  AttitudeSelfPageViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/19.
//  Copyright © 2023 Redrock. All rights reserved.
//

// VC
#import "AttitudeSelfPageViewController.h"
#import "PublishViewController.h"
// Model
#import "AttitudeSelfPageDataModel.h"
#import "AttitudeSelfPageDataItem.h"
// View
#import "AttitudeSelfPageDefaultView.h"

@interface AttitudeSelfPageViewController ()
/// 缺省页
@property (nonatomic, strong) AttitudeSelfPageDefaultView *defaultView;

@end

@implementation AttitudeSelfPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.VCTitleStr = @"个人中心";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [self.topBarButton setImage:[UIImage imageNamed:@"Attitude_SelfPageTopBarButton"] forState:UIControlStateNormal];
    [self getRequestData];
    
}

// 点击按钮事件重写
- (void)clickPublishBtn {
    PublishViewController *publishVC = [[PublishViewController alloc] init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

// 获得自己发布的内容
- (void)getRequestData {
    AttitudeSelfPageDataModel *model = [[AttitudeSelfPageDataModel alloc] init];
    [model requestAttitudeDataWithOffset:0 Limit:20 Success:^(NSArray * _Nonnull array) {
        self.dataArray = array;
        [self.tableView reloadData];
        if (self.dataArray.count == 0) {
            [self.view addSubview:self.defaultView];
        }
    } Failure:^(NSError * _Nonnull error) {
        [self.view addSubview:self.defaultView];
        NSLog(@"加载自己发布内容失败");
    }];
}

// 缺省页
- (AttitudeSelfPageDefaultView *)defaultView {
    if (!_defaultView) {
        CGFloat y = self.topBarView.bottom;
        _defaultView = [[AttitudeSelfPageDefaultView alloc] initWithDefaultPage];
        _defaultView.frame = CGRectMake(0, y, kScreenWidth, kScreenHeight - y);
    }
    return _defaultView;
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
