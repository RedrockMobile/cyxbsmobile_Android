//
//  CQUPTMapViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/8.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapViewController.h"
#import "CQUPTMapPresenter.h"
#import "CQUPTMapViewProtocol.h"
#import "CQUPTMapDataItem.h"
#import "CQUPTMapPlaceItem.h"
#import "CQUPTMapHotPlaceItem.h"
#import "CQUPTMapProgressView.h"
#import "CQUPTVRMapController.h"
#import <SDImageCache.h>
#import "UserDefaultTool.h"

@interface CQUPTMapViewController () <CQUPTMapViewProtocol, CQUPTMapContentViewDelegate>

@property (nonatomic, weak) CQUPTMapProgressView *progressView;
@property (nonatomic, weak) MBProgressHUD *hud;
@property (nonatomic, strong) CQUPTMapPresenter *presenter;
@property (nonatomic, copy) NSString *initialPlaceID;

@end

@implementation CQUPTMapViewController

- (instancetype)initWithInitialPlace:(NSString *)placeID {
    if (self = [super init]) {
        self.initialPlaceID = placeID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"地图加载中，请耐心等待哦～";
    self.hud = hud;
    
    self.presenter = [[CQUPTMapPresenter alloc] init];
    [self.presenter attachView:self];
    
    [self.presenter requestMapData];
    
    if (@available(iOS 11.0, *)) {
        self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)dealloc {
    [self.presenter detachView];
}


#pragma mark - Presenter 回调
- (void)mapDataRequestSuccessWithMapData:(CQUPTMapDataItem *)mapData hotPlace:(nonnull NSArray<CQUPTMapHotPlaceItem *> *)hotPlaceArray {
    
    [mapData archiveItem];
    
    self.view.backgroundColor = [UIColor colorWithHexString:mapData.mapColor];
    
    CQUPTMapContentView *contentView = [[CQUPTMapContentView alloc] initWithFrame:self.view.bounds andMapData:mapData andHotPlaceItemArray:hotPlaceArray];
    contentView.backgroundColor = [UIColor colorWithHexString:mapData.mapColor];
    contentView.delegate = self;
    contentView.alpha = 0;
    
    NSURL *mapURL = [NSURL URLWithString:mapData.mapURL];
    
    [contentView.mapView sd_setImageWithURL:mapURL placeholderImage:nil options:SDWebImageScaleDownLargeImages progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.progressView && ![[SDImageCache sharedImageCache] diskImageDataExistsWithKey:mapData.mapURL]) {
                CQUPTMapProgressView *progress = [[CQUPTMapProgressView alloc] initWithFrame:self.view.bounds title:@"下载地图" describe:@"仅在地图更新时需要下载地图哦"];
                [self.view addSubview:progress];
                self.progressView = progress;
            }
            self.progressView.progresView.progress = (float)receivedSize / (float)expectedSize;
            self.progressView.percentLabel.text = [NSString stringWithFormat:@"%2.0f%%", fabs(round((float)receivedSize / (float)expectedSize * 100))];
        });
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

        [self.progressView removeFromSuperview];
        
        [self.view addSubview:contentView];
        self.contentView = contentView;
        
        [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
            contentView.alpha = 1;
        } completion:nil];
        
        contentView.mapView.contentMode = UIViewContentModeScaleAspectFill;

        self.contentView.mapScrollView.contentSize = image.size;
        [self.contentView.mapScrollView scrollToBottom];
        
        if (self.initialPlaceID) {
            for (CQUPTMapPlaceItem *placeItem in mapData.placeList) {
                if ([placeItem.placeId isEqualToString:self.initialPlaceID]) {
                    [self.contentView selectedAPlace:placeItem];
                    [self requestPlaceDataWithPlaceID:self.initialPlaceID];
                    return;
                }
            }
        }
    }];
    
    [self.hud hide:YES];
    
}

- (void)starPlaceRequestSuccessWithStarPlace:(CQUPTMapStarPlaceItem *)starPlace {
    [self.contentView starPlaceListRequestSuccess:starPlace];
}

- (void)searchPlaceSuccess:(NSArray<CQUPTMapSearchItem *> *)placeIDArray {
    [self.contentView searchPlaceSuccess:placeIDArray];
}

- (void)placeDetailDataRequestSuccess:(CQUPTMapPlaceDetailItem *)placeDetailItem {
    [self.contentView placeDetailDataRequestSuccess:placeDetailItem];
}


#pragma mark - ContentView代理
- (void)backButtonClicked {
    if (self.isPresent) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)requestStarData {
    [self.presenter requestStarData];
}

- (void)searchPlaceWithString:(NSString *)string {
    NSMutableArray *history = [[UserDefaultTool valueWithKey:Discover_cquptMapHistoryKey_String] mutableCopy];
    if (!history) {
        history = [NSMutableArray array];
    }
    
    if (![history containsObject:string]) {
        [history insertObject:string atIndex:0];
    }
    
    [UserDefaultTool saveValue:history forKey:Discover_cquptMapHistoryKey_String];
    
    [self.presenter searchPlaceWithString:string];
}

- (void)requestPlaceDataWithPlaceID:(NSString *)placeID {
    [self.presenter requestPlaceDataWithPlaceID:placeID];
}

- (void)vrButtonTapped {
    CQUPTVRMapController *vrMap = [[CQUPTVRMapController alloc] init];
    [self.navigationController pushViewController:vrMap animated:YES];
}

@end
