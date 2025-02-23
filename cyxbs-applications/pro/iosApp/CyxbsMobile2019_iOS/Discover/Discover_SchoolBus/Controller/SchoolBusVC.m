//
//  SchoolBusVC.m
//  CyxbsMobile2019_iOS
//
//  Created by Clutch Powers on 2022/4/7.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SchoolBusVC.h"
#import "SchoolBusMapView.h"
#import "SchoolBusBottomView.h"
#import "SchoolBusMapSideBar.h"
#import "StationData.h"
#import "BusGuideViewController.h"
#import "StationsCollectionViewCell.h"
#import "StationGuideBar.h"
#import "StationMAPointAnnotation.h"
#import "CircleMAPointAnnotation.h"

@interface SchoolBusVC () <
    SchoolBusMapViewDelegate,
    SchoolBusBottomViewDelegate,
    CLLocationManagerDelegate
>

/// 授权定位
@property (nonatomic, strong) CLLocationManager *locationManager;
///地图View
@property (nonatomic, strong) SchoolBusMapView *schoolBusMapView;
///底部View
@property (nonatomic, strong) SchoolBusBottomView *schoolBusBottomView;
/// 比例尺调节定位侧边栏
@property (nonatomic, strong) SchoolBusMapSideBar *schoolBusSideBar;
/// 所有数据
@property (nonatomic, copy) NSArray *stationArray;
/// 所有站的标记点
@property (nonatomic, copy) NSArray *allStationPointArray;
/// 站点信息bar
@property (nonatomic, strong) StationGuideBar *stationGuideBar;
/// 最下面站点ScrollView
@property (nonatomic, strong) StationScrollView *stationScrollView;
/// 被选中路牌的线路数组
@property (nonatomic, copy) NSArray *selectedlinesArray;
/// 被选中路牌站点在线路中的位置数组
@property (nonatomic, copy) NSArray *selectedstationArray;
/// 被选中站点属于几条线路
@property (nonatomic, assign) int selectedIndex;
/// 被选中校车 站点
@property (nonatomic, copy) NSString *selectedName;
/// 被选中校车 站点经纬度
@property (nonatomic, assign) CLLocationCoordinate2D selectedCoordinate;
/// 被选中是校车
@property (nonatomic, assign) BOOL isBus;

@end

@implementation SchoolBusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetLocationPermissionVerifcationWithController];
    [self setupStationData];
    [self.view addSubview:self.schoolBusMapView];
    [self.schoolBusMapView addSubview: self.schoolBusSideBar];
    [self.schoolBusMapView addSubview:self.schoolBusBottomView];
    [self.view addSubview:self.stationGuideBar];
    [self.view addSubview:self.stationScrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    
    _stationScrollView.stationData = self.stationArray[0];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.schoolBusMapView.timer invalidate];
    self.schoolBusMapView.timer = nil;
}

#pragma mark - SchoolBusMapViewDelegate
- (void)schoolBusMapView:(SchoolBusMapView *)view didSelectedLinesWithAnnotationView:(MAAnnotationView *)annotationView {
    NSString *titleName = annotationView.annotation.title;
    NSString *subtitleName = annotationView.annotation.subtitle;
    if ([titleName containsString:@"BusID"]) { //点击的是车辆
        _isBus = YES;
        _selectedName = subtitleName;
        _selectedCoordinate = annotationView.annotation.coordinate;
        if ([subtitleName containsString:@"1"]) {
            [self.schoolBusBottomView busButtonControllerWithBtnTag: 1];
        }
        else if ([subtitleName containsString:@"2"]) {
            [self.schoolBusBottomView busButtonControllerWithBtnTag: 2];
        }
        else if ([subtitleName containsString:@"3"]) {
            [self.schoolBusBottomView busButtonControllerWithBtnTag: 3];
        }
        else if ([subtitleName containsString:@"4"]) {
            [self.schoolBusBottomView busButtonControllerWithBtnTag: 4];
        }
    }else { // 点击的是站点
        _selectedName = titleName;
        NSMutableArray *MuLineArray = NSMutableArray.array;
        NSMutableArray *MuStationArray = NSMutableArray.array;
        for (int i = 0; i < self.stationArray.count; i++) {
            StationData *data = self.stationArray[i];
            for (int j = 0; j < data.stations.count; j++) {
                if (data.stations[j][@"name"] == titleName) {
                    NSLog(@"%d", data.line_id);
                    [MuLineArray addObject: @(data.line_id+1)];
                    [MuStationArray addObject: @(j)];
                }
            }
        }
        _selectedlinesArray = MuLineArray;
        _selectedstationArray = MuStationArray;
        [self showSelectedLinesWithselectedlinesArray:MuLineArray];
    }
}

- (void)showSelectedLinesWithselectedlinesArray:(NSArray *)array {
    if ((!array) && !(array.count > 0)) { return; }
    [self.schoolBusBottomView busButtonControllerWithBtnTag:[array[0] intValue]];
    _selectedIndex = 1;
    int index = [_selectedstationArray[0] intValue];
    self.stationScrollView.stationsViewArray[index].frontImageView.alpha = 1;
    switch ([array[0] intValue]) {
        case 1:
            self.stationScrollView.stationsViewArray[index].stationBtn.textColor = [UIColor colorWithHexString:@"FF45B9" alpha:1];
            break;
        case 2:
            self.stationScrollView.stationsViewArray[index].stationBtn.textColor = [UIColor colorWithHexString:@"#FF8015" alpha:1];
            break;
        case 3:
            self.stationScrollView.stationsViewArray[index].stationBtn.textColor = [UIColor colorWithHexString:@"#06A3FC" alpha:1];
            break;
        case 4:
            self.stationScrollView.stationsViewArray[index].stationBtn.textColor = [UIColor colorWithHexString:@"#18D19A" alpha:1];
            break;
        default:
            break;
    }
    self.stationGuideBar.titleLabel.text = _selectedName;
    self.stationGuideBar.runtimeLabel.alpha = 0;
    self.stationGuideBar.runtypeBtn.alpha = 0;
    self.stationGuideBar.sendtypeBtn.alpha = 0;
    self.stationGuideBar.lineBtn.lineLabel.text = [NSString stringWithFormat:@"%d号线", [array[0] intValue]];
    [self.stationGuideBar.lineBtn setTitle:@"" forState:UIControlStateNormal];
    self.stationGuideBar.lineBtn.alpha = 1;
    if (_selectedlinesArray.count > 1 ) {
        self.stationGuideBar.lineBtn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2921D1" alpha:1] darkColor:[UIColor colorWithHexString:@"#2921D1" alpha:1]];
        self.stationGuideBar.lineBtn.lineLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:1]];
        self.stationGuideBar.lineBtn.imgView.image = [UIImage imageNamed:@"WhiteChangeArrow"];
        self.stationGuideBar.lineBtn.userInteractionEnabled = YES;
        [self.stationGuideBar.lineBtn addTarget:self action:@selector(nextLine) forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.stationGuideBar.lineBtn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E8F0FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#C3D4EE" alpha:0.1]];
        self.stationGuideBar.lineBtn.lineLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F0" alpha:1]];
        self.stationGuideBar.lineBtn.imgView.image = [UIImage imageNamed:@"BlackChangeArrow"];
        self.stationGuideBar.lineBtn.userInteractionEnabled = NO;
    }
    
}

#pragma mark - Getter
- (SchoolBusMapView *)schoolBusMapView{
    if (!_schoolBusMapView) {
        SchoolBusMapView *schoolBusMapView = [[SchoolBusMapView alloc] initWithFrame:self.view.frame];
        schoolBusMapView.delegate = self;
        _schoolBusMapView = schoolBusMapView;
    }
    return _schoolBusMapView;
}

- (SchoolBusBottomView *)schoolBusBottomView{
    if (!_schoolBusBottomView) {
        _schoolBusBottomView = [[SchoolBusBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-96, SCREEN_WIDTH, 336)];
        _schoolBusBottomView.delegate = self;
    }
    return _schoolBusBottomView;
}

- (SchoolBusMapSideBar *)schoolBusSideBar {
    if (!_schoolBusSideBar) {
        _schoolBusSideBar = [[SchoolBusMapSideBar alloc]initWithFrame:CGRectMake(0, 0, 70, 280)];
        _schoolBusSideBar.bottom = self.schoolBusBottomView.top - 18;
        _schoolBusSideBar.right = self.schoolBusMapView.SuperRight - 16;
        [_schoolBusSideBar.zoomScaleBtn addTarget:self action:@selector(zoomUpScacle) forControlEvents:UIControlEventTouchUpInside];
        [_schoolBusSideBar.narrowScaleBtn addTarget:self action:@selector(zoomOutScacle) forControlEvents:UIControlEventTouchUpInside];
        [_schoolBusSideBar.orientationBtn addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchUpInside];
    }
    return _schoolBusSideBar;
}

- (StationGuideBar *)stationGuideBar {
    if (!_stationGuideBar) {
        _stationGuideBar = [[StationGuideBar alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 63)];
    }
    return _stationGuideBar;
}

- (StationScrollView *)stationScrollView {
    if (!_stationScrollView) {
        _stationScrollView = [[StationScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 163)];
        _stationScrollView.top = self.stationGuideBar.bottom;
    }
    return _stationScrollView;
}

#pragma mark - Method
/// 定位授权
- (void)GetLocationPermissionVerifcationWithController{
    BOOL enable = [CLLocationManager locationServicesEnabled];
    NSInteger state = [CLLocationManager authorizationStatus];
    
    if (!enable || 2 > state) {// 尚未授权位置权限
        if (8 <= [[UIDevice currentDevice].systemVersion floatValue]) {
            NSLog(@"系统位置权限授权弹窗");
            // 系统位置权限授权弹窗
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
//            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
}
/// 获取数据
- (void)setupStationData {
    [StationData StationWithSuccess:^(NSArray * _Nonnull array) {
        self.stationArray = array;
        NSMutableArray *mArray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            StationData *data = array[i];
            for (int j = 0; j < data.stations.count; j++) {
                StationMAPointAnnotation *pointAnnotation = [[StationMAPointAnnotation alloc]init];
                pointAnnotation.title = data.stations[j][@"name"];
                pointAnnotation.subtitle = data.line_name;
                pointAnnotation.ID = 0;
                pointAnnotation.coordinate = CLLocationCoordinate2DMake([data.stations[j][@"lat"] doubleValue], [data.stations[j][@"lng"] doubleValue]);
                [mArray addObject: pointAnnotation];
            }
        }
        
        self->_allStationPointArray = mArray;
        [self.schoolBusMapView removeOldAnnotationsAndaddNew: mArray.copy];
        
    } Failure:^(NSError * _Nonnull error) {
        
    }];
}
/// 按钮点击时
/// @param view schoolBusView
/// @param index BtnIndex
/// @param isSelected isSelected
- (void)schoolBusView:(SchoolBusBottomView *)view didSelectedBtnWithIndex:(NSUInteger) index AndisSelected:(BOOL) isSelected {
    [self displayLines:index AndisSelected:isSelected];
    //第五个按钮不调用 第五个按钮index是0会数组越界
    if (index > 0) {
        self.stationScrollView.stationData = self.stationArray[index-1];
    }
    if (isSelected == NO && index > 0) {
        NSMutableArray *mutAry = NSMutableArray.array;
        StationData *data = _stationArray[index-1];
        //设置stationbar数据
        [self setStationGuideBarwithData:data];
        if (_selectedName != nil && _isBus) {
            CircleMAPointAnnotation *circlepointAnnotation = [[CircleMAPointAnnotation alloc]init];
            circlepointAnnotation.title = _selectedName;
            circlepointAnnotation.subtitle = data.line_name;
            circlepointAnnotation.coordinate = CLLocationCoordinate2DMake(_selectedCoordinate.latitude, _selectedCoordinate.longitude);
            [mutAry addObject: circlepointAnnotation];
        }
        for (int j = 0; j < data.stations.count; j++) {
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
            pointAnnotation.title = data.stations[j][@"name"];
            pointAnnotation.subtitle = data.line_name;
            pointAnnotation.coordinate = CLLocationCoordinate2DMake([data.stations[j][@"lat"] doubleValue], [data.stations[j][@"lng"] doubleValue]);
            
            if (_selectedName == data.stations[j][@"name"]) {
                CircleMAPointAnnotation *circlepointAnnotation = [[CircleMAPointAnnotation alloc]init];
                circlepointAnnotation.title = data.stations[j][@"name"];
                circlepointAnnotation.subtitle = data.line_name;
                circlepointAnnotation.coordinate = CLLocationCoordinate2DMake([data.stations[j][@"lat"] doubleValue], [data.stations[j][@"lng"] doubleValue]);
                [mutAry addObject: circlepointAnnotation];
            }
            
            [mutAry addObject: pointAnnotation];
        }
        [self.schoolBusMapView removeOldAnnotationsAndaddNew: mutAry.copy];
//        _selectedName = nil;
    }else{
        [self.schoolBusMapView removeOldAnnotationsAndaddNew: _allStationPointArray];
        _selectedName = nil;
    }
    _isBus = NO;
}
/// 设置stationbar数据
/// @param data data
- (void)setStationGuideBarwithData:(StationData *)data {
    self.stationGuideBar.lineBtn.alpha = 0;
    self.stationGuideBar.titleLabel.text = data.line_name;
    self.stationGuideBar.runtimeLabel.alpha = 1;
    if (data.run_time != nil) {
        self.stationGuideBar.runtimeLabel.text = [@"运行时间:" stringByAppendingString:data.run_time];
    } else {
        self.stationGuideBar.runtimeLabel.text = @"运行时间:获取失败";
    }
    self.stationGuideBar.runtypeBtn.alpha = 1;
    [self.stationGuideBar.runtypeBtn setTitle:data.run_type forState:UIControlStateNormal];
    self.stationGuideBar.sendtypeBtn.alpha = 1;
    [self.stationGuideBar.sendtypeBtn setTitle:data.send_type forState:UIControlStateNormal];
}
/// 返回
- (void)backBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}
/// 展示BusGuide
/// @param index button.tag
/// @param isSelected 是否被选中
- (void)displayLines:(NSInteger )index AndisSelected:(BOOL)isSelected{
    if (index > 0 && isSelected == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            self->_schoolBusMapView.mapView.transform = CGAffineTransformMakeTranslation(0, -159);
            self->_schoolBusBottomView.transform = CGAffineTransformMakeTranslation(0, -239);
            self->_stationGuideBar.transform = CGAffineTransformMakeTranslation(0, -239);
            self->_schoolBusSideBar.transform = CGAffineTransformMakeTranslation(0, -239);
            self->_stationScrollView.transform = CGAffineTransformMakeTranslation(0, -239);
        }];
    }
    else if (index == 0){
        [UIView animateWithDuration:0.3 animations:^{
            self->_schoolBusMapView.mapView.transform = CGAffineTransformIdentity;
            self->_schoolBusBottomView.transform = CGAffineTransformIdentity;
            self->_stationGuideBar.transform = CGAffineTransformIdentity;
            self->_schoolBusSideBar.transform = CGAffineTransformIdentity;
            self->_stationScrollView.transform = CGAffineTransformIdentity;
        }];
        BusGuideViewController *busGuideVC = [[BusGuideViewController alloc]initWithstationsArray:self.stationArray];
        [self.navigationController pushViewController:busGuideVC animated: YES];
    }
    else if(isSelected == YES){
        [UIView animateWithDuration:0.3 animations:^{
            self->_schoolBusMapView.mapView.transform = CGAffineTransformIdentity;
            self->_schoolBusBottomView.transform = CGAffineTransformIdentity;
            self->_stationGuideBar.transform = CGAffineTransformIdentity;
            self->_schoolBusSideBar.transform = CGAffineTransformIdentity;
            self->_stationScrollView.transform = CGAffineTransformIdentity;
        }];
    }
    
}
/// 放大
- (void)zoomUpScacle {
    self.schoolBusMapView.mapView.zoomLevel += 1;
}
/// 缩小
- (void)zoomOutScacle {
    self.schoolBusMapView.mapView.zoomLevel -= 1;
}
/// 定位
- (void)location {
    self.schoolBusMapView.mapView.centerCoordinate = CLLocationCoordinate2DMake(self.schoolBusMapView.mapView.userLocation.coordinate.latitude, self.schoolBusMapView.mapView.userLocation.coordinate.longitude);
}
/// 下一个站点
- (void)nextLine {
    _selectedIndex = _selectedIndex  % _selectedlinesArray.count;
    [self.schoolBusBottomView busButtonControllerWithBtnTag:[_selectedlinesArray[_selectedIndex] intValue]];
    self.stationGuideBar.lineBtn.alpha = 1;
    self.stationGuideBar.titleLabel.text = _selectedName;
    self.stationGuideBar.runtimeLabel.alpha = 0;
    self.stationGuideBar.runtypeBtn.alpha = 0;
    self.stationGuideBar.sendtypeBtn.alpha = 0;
    self.stationGuideBar.lineBtn.lineLabel.text = [NSString stringWithFormat:@"%@号线", _selectedlinesArray[_selectedIndex]];
    self.stationGuideBar.lineBtn.lineLabel.textColor = UIColor.whiteColor;
    [self.stationGuideBar.lineBtn setTitle:@"" forState:UIControlStateNormal];
    int index = [_selectedstationArray[_selectedIndex] intValue];
    self.stationScrollView.stationsViewArray[index].frontImageView.alpha = 1;
    switch ([_selectedlinesArray[_selectedIndex] intValue]) {
        case 1:
            self.stationScrollView.stationsViewArray[index].stationBtn.textColor = [UIColor colorWithHexString:@"FF45B9" alpha:1];
            break;
        case 2:
            self.stationScrollView.stationsViewArray[index].stationBtn.textColor = [UIColor colorWithHexString:@"#FF8015" alpha:1];
            break;
        case 3:
            self.stationScrollView.stationsViewArray[index].stationBtn.textColor = [UIColor colorWithHexString:@"#06A3FC" alpha:1];
            break;
        case 4:
            self.stationScrollView.stationsViewArray[index].stationBtn.textColor = [UIColor colorWithHexString:@"#18D19A" alpha:1];
            break;
        default:
            break;
    }
        _selectedIndex += 1;
}

@end
