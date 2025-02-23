//
//  BusGuideViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/10.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "BusGuideViewController.h"
#import "StationsGuideTableViewCell.h"
#import "StationData.h"
#import "StationGuideView.h"

@interface BusGuideViewController ()
/// <#Description#>
@property (nonatomic, copy) NSArray *stationsArray;
/// BusGuide
@property (nonatomic, strong) UITableView *busGuideTableView;
@property (nonatomic, strong) UIScrollView *busGuideScrollView;
@end

@implementation BusGuideViewController

- (instancetype)initWithstationsArray:(NSArray *)stationsArray {
    self = [super init];
    if (self) {
        self.stationsArray = stationsArray;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    [self.view addSubview:self.busGuideScrollView];
    [self addstationGuideViews];
    self.VCTitleStr = @"校车指南";
    self.titlePosition = TopBarViewTitlePositionLeft;
    self.splitLineHidden = YES;
    self.titleFont = [UIFont fontWithName:PingFangSCSemibold size:22];
    self.titleColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:1]];
    self.topBarView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
}

#pragma mark - Getter

- (UIScrollView *)busGuideScrollView {
    if (!_busGuideScrollView) {
        CGFloat y = self.topBarView.bottom;
        _busGuideScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-y)];
        _busGuideScrollView.top = self.topBarView.bottom;
        _busGuideTableView.bottom = self.view.bottom;
        _busGuideScrollView.contentSize = CGSizeMake(kScreenWidth, 264 * self.stationsArray.count);
    }
    return _busGuideScrollView;
}
- (void)addstationGuideViews {
    for (NSUInteger i = 0; i < self.stationsArray.count; i++) {
        StationGuideView *view = [[StationGuideView alloc]initWithFrame:CGRectMake(0, 272 * i, kScreenWidth, 256) AndStationsData:self.stationsArray[i]];
        view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
        UIView *intervalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
        intervalView.top = view.bottom;
        intervalView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:0.9] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
        [self.busGuideScrollView addSubview:view];
        [self.busGuideScrollView addSubview:intervalView];
    }
}
@end
