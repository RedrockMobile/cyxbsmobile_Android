//
//  CQUPTMapContentView.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/8.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapContentView.h"
#import "CQUPTMapHotPlaceButton.h"
#import "CQUPTMapMyStarButton.h"
#import "CQUPTMapDataItem.h"
#import "CQUPTMapPlaceItem.h"
#import "CQUPTMapHotPlaceItem.h"
#import "CQUPTMapStarPlaceItem.h"
#import "CQUPTMapSearchView.h"
#import "CQUPTMapDetailView.h"
#import "CQUPTMapViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface CQUPTMapContentView () <UITextFieldDelegate, UIScrollViewDelegate, CALayerDelegate>

// 数据
@property (nonatomic, strong) CQUPTMapDataItem *mapDataItem;
@property (nonatomic, copy) NSArray<CQUPTMapHotPlaceItem *> *hotPlaceItemArray;
@property (nonatomic, strong) CQUPTMapStarPlaceItem *starPlace;

// 控件
@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIButton *backButton;
@property (nonatomic, weak) UIImageView *searchScopeImageView;
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIImageView *compassView;
@property (nonatomic, weak) UIButton *vrButton;

@property (nonatomic, weak) UIScrollView *hotScrollView;
@property (nonatomic, strong) NSMutableArray<CQUPTMapHotPlaceButton *> *hotButtonArray;

@property (nonatomic, weak) CQUPTMapMyStarButton *starButton;

@property (nonatomic, weak) CQUPTMapSearchView *beforeSearchView;

/// 选择地点后底部弹出的view
@property (nonatomic, weak) CQUPTMapDetailView *detailView;

@property (nonatomic, assign) CGFloat lastY;

@property (nonatomic, assign) CGFloat startScale;

@end


@implementation CQUPTMapContentView

- (instancetype)initWithFrame:(CGRect)frame andMapData:(CQUPTMapDataItem *)mapDataItem andHotPlaceItemArray:(nonnull NSArray<CQUPTMapHotPlaceItem *> *)hotPlaceItemArray
{
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
        } else {
            self.backgroundColor = [UIColor whiteColor];
        }
        self.mapDataItem = mapDataItem;
        self.hotPlaceItemArray = hotPlaceItemArray;
        self.pinsArray = [@[] mutableCopy];
        
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = self.backgroundColor;
        [self addSubview:topView];
        self.topView = topView;
        
        // 返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [backButton setImage:[UIImage imageNamed:@"我的返回"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        self.backButton = backButton;
        
        // 搜索栏
        UITextField *searchBar = [[UITextField alloc] init];
        searchBar.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 0)];
        searchBar.leftViewMode = UITextFieldViewModeAlways;
        searchBar.returnKeyType = UIReturnKeySearch;
        searchBar.font = [UIFont fontWithName:PingFangSCMedium size:14];
        searchBar.placeholder = [NSString stringWithFormat:@"大家都在搜：%@", mapDataItem.hotWord];
        searchBar.delegate = self;
        [self addSubview:searchBar];
        self.searchBar = searchBar;
        
        UIImageView *searchScopeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Map_Scope"]];
        [searchBar addSubview:searchScopeImageView];
        self.searchScopeImageView = searchScopeImageView;
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        if (@available(iOS 11.0, *)) {
            [cancelButton setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#234780" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF1" alpha:1]] forState:UIControlStateNormal];
        } else {
            [cancelButton setTitleColor:[UIColor colorWithHexString:@"788AAA"] forState:UIControlStateNormal];
        }
        cancelButton.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:16];
        [cancelButton addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        self.cancelButton = cancelButton;
        
        // 热词
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.hotScrollView = scrollView;
        
        self.hotButtonArray = [NSMutableArray array];
        for (CQUPTMapHotPlaceItem *hotPlace in hotPlaceItemArray) {
            CQUPTMapHotPlaceButton *hotButton = [[CQUPTMapHotPlaceButton alloc] initWithHotPlace:hotPlace];
            [hotButton.button addTarget:self action:@selector(hotButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self.hotScrollView addSubview:hotButton];
            [self.hotButtonArray addObject:hotButton];
        }
        
        // 收藏
        CQUPTMapMyStarButton *starButton = [[CQUPTMapMyStarButton alloc] init];
        starButton.backgroundColor = [UIColor clearColor];
        [starButton addTarget:self action:@selector(starButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:starButton];
        self.starButton = starButton;
        
        
        // 地图
        UIScrollView *mapScrollView = [[UIScrollView alloc] init];
        mapScrollView.showsVerticalScrollIndicator = NO;
        mapScrollView.showsHorizontalScrollIndicator = NO;
        mapScrollView.delegate = self;
        [self addSubview:mapScrollView];
        self.mapScrollView = mapScrollView;
        
        UIImageView *mapView = [[UIImageView alloc] init];
        mapView.image = [UIImage imageNamed:@"Map_map"];
        mapView.contentMode = UIViewContentModeScaleAspectFill;
        mapView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapped:)];
        [mapView addGestureRecognizer:tap];
        [self.mapScrollView addSubview:mapView];
        self.mapView = mapView;
        
        mapScrollView.contentSize = mapView.image.size;
        mapScrollView.maximumZoomScale = 6.0;
        mapScrollView.minimumZoomScale = 1.0;
        [mapScrollView scrollToBottom];
        
        UIImageView *compassView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Map_Compass"]];
        [self addSubview:compassView];
        self.compassView = compassView;
        
        UIButton *vrButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [vrButton setImage:[UIImage imageNamed:@"Map_VRMap"] forState:UIControlStateNormal];
        [vrButton addTarget:self action:@selector(vrButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:vrButton];
        self.vrButton = vrButton;
        
        // 深色模式
        if (@available(iOS 11.0, *)) {
            searchBar.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F0F4FD" alpha:1] darkColor:[UIColor colorWithHexString:@"#1F1F1F" alpha:1]];
            searchBar.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15305C" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
            searchBar.backgroundColor = [UIColor colorWithHexString:@"#F0F4FD"];
            searchBar.textColor = [UIColor colorWithHexString:@"#15305B"];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self);
        make.bottom.equalTo(self.hotScrollView);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(STATUSBARHEIGHT + 15);
        make.leading.equalTo(self).offset(15);
        make.height.equalTo(@19);
        make.width.equalTo(@9);
    }];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backButton.mas_trailing).offset(20);
        make.centerY.equalTo(self.backButton);
        make.trailing.equalTo(self.cancelButton.mas_leading).offset(-15);
        make.height.equalTo(@32);
    }];
    self.searchBar.layer.cornerRadius = 16;
    
    [self.searchScopeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.searchBar).offset(12);
        make.centerY.equalTo(self.searchBar);
        make.height.width.equalTo(@15);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_trailing);
        make.centerY.equalTo(self.searchBar);
    }];
    
    [self.starButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotScrollView);
        make.height.equalTo(@54);
        make.width.equalTo(@75);
        make.trailing.equalTo(self);
    }];
    
    for (int i = 0; i < self.hotButtonArray.count; i++) {
        if (i == 0) {
            [self.hotButtonArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.top.equalTo(self.hotScrollView);
                make.height.equalTo(@54);
                make.width.equalTo(@(self.hotButtonArray[i].buttonWidth + 28));
            }];
        } else if (i == self.hotButtonArray.count - 1) {
            [self.hotButtonArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.hotButtonArray[i - 1].mas_trailing);
                make.top.trailing.equalTo(self.hotScrollView);
                make.height.equalTo(@54);
                make.width.equalTo(@(self.hotButtonArray[i].buttonWidth + 28));
            }];
        } else {
            [self.hotButtonArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.hotButtonArray[i - 1].mas_trailing);
                make.top.equalTo(self.hotScrollView);
                make.height.equalTo(@54);
                make.width.equalTo(@(self.hotButtonArray[i].buttonWidth + 28));
            }];
        }
    }
    
    [self.hotScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self.starButton.mas_leading);
        make.top.equalTo(self.searchBar.mas_bottom).offset(6);
        make.height.equalTo(@54);
    }];
    
    [self.compassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotScrollView.mas_bottom).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.width.height.equalTo(@65);
    }];
    
    [self.vrButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.compassView);
        make.leading.equalTo(self).offset(15);
        make.width.height.equalTo(@36);
    }];
    
    [self.mapScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(self.hotScrollView.mas_bottom);
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(MAIN_SCREEN_W));
        make.height.equalTo(@(self.mapDataItem.mapHeight / self.mapDataItem.mapWidth * MAIN_SCREEN_W));
        make.top.leading.trailing.bottom.equalTo(self.mapScrollView);
    }];
}

- (void)back {
    if ([self.delegate respondsToSelector:@selector(backButtonClicked)]) {
        [self.delegate backButtonClicked];
    }
}


# pragma mark - TextField代理
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.beforeSearchView) {
        return;
    }
    
    CGFloat beforeSearchViewY = CGRectGetMaxY(self.searchBar.frame);
    
    CQUPTMapSearchView *beforeSearchView = [[CQUPTMapSearchView alloc] initWithFrame:CGRectMake(0, beforeSearchViewY + 100, MAIN_SCREEN_W, MAIN_SCREEN_H - beforeSearchViewY)];
    beforeSearchView.alpha = 0;
    [self addSubview:beforeSearchView];
    self.beforeSearchView = beforeSearchView;
    
    [self.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_trailing).offset(-45);
    }];
    
    [self.backButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(-9);
    }];
    
    [UIView animateWithDuration:0.32 animations:^{
        
        beforeSearchView.layer.affineTransform = CGAffineTransformTranslate(beforeSearchView.layer.affineTransform, 0, -100);
        beforeSearchView.alpha = 1;
        
        [self layoutIfNeeded];
        
    } completion:nil];

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    textField.text = @"";
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length == 0 && range.length == textField.text.length) {
        [UIView animateWithDuration:0.3 animations:^{
            self.beforeSearchView.resultTableView.alpha = 0;
            self.beforeSearchView.historyTableView.alpha = 1;
        }];
    }
    
    if ([string isEqualToString:@"\n"]) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = self.mapDataItem.hotWord;
        }
        if ([self.delegate respondsToSelector:@selector(searchPlaceWithString:)]) {
            [self.delegate searchPlaceWithString:textField.text];
        }
    }
    
    return YES;
}

- (void)searchPlaceSuccess:(NSArray<CQUPTMapSearchItem *> *)placeIDArray {
    if (placeIDArray.count == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.labelText = @"未能搜到此地点";
        [hud setMode:(MBProgressHUDModeText)];
        [hud hide:YES afterDelay:1.5];
        
        return;
    }
    
    [self.beforeSearchView searchPlaceSuccess:placeIDArray];
}


# pragma mark - ScrollView代理
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.mapView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    for (UIImageView *pin in self.pinsArray) {
        
        pin.layer.affineTransform = CGAffineTransformMakeScale(self.startScale / scrollView.zoomScale, self.startScale / scrollView.zoomScale);
    }
}


#pragma mark - TableView代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


# pragma mark - 手势
- (void)mapTapped:(UITapGestureRecognizer *)sender {
    CGPoint tapPoint = [sender locationInView:sender.view];
    
    for (CQUPTMapPlaceItem *place in self.mapDataItem.placeList) {
        for (CQUPTMapPlaceRect *rect in place.buildingList) {
            if ([rect isIncludePercentagePoint:tapPoint] || [place.tagRect isIncludePercentagePoint:tapPoint]) {
                [self selectedAPlace:place];
                // 请求详情数据
                if ([self.delegate respondsToSelector:@selector(requestPlaceDataWithPlaceID:)]) {
                    [self.delegate requestPlaceDataWithPlaceID:place.placeId];
                }
                
                return;
            }
        }
    }
}

- (void)placeDetailDataRequestSuccess:(CQUPTMapPlaceDetailItem *)placeDetailItem {
    [self.detailView loadDataWithPlaceDetailItem:placeDetailItem];
}


/// 点击了地图上某个地点后。上面那个方法判断成功后调用的。
- (void)selectedAPlace:(CQUPTMapPlaceItem *)placeItem {
    [self addPinsOnMapWithPlaceArray:@[placeItem]];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.detailView.alpha = 0;
        self.detailView.layer.affineTransform = CGAffineTransformScale(self.detailView.layer.affineTransform, 0.2, 0.2);
    }];
    
    CQUPTMapDetailView *detailView = [[CQUPTMapDetailView alloc] initWithPlaceItem:placeItem];
    [self addSubview:detailView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(transitionViewDragged:)];
    [detailView addGestureRecognizer:pan];
    
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.leading.width.equalTo(self);
        make.height.equalTo(@(MAIN_SCREEN_H));      // 让detailView足够高，不然上滑会滑过头
    }];
    
    [self layoutIfNeeded];
    
    CQUPTMapDetailView *lastDetailView = self.detailView;
    self.detailView = detailView;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        detailView.layer.affineTransform = CGAffineTransformTranslate(detailView.layer.affineTransform, 0, -112);
    } completion:^(BOOL finished) {
        [lastDetailView removeFromSuperview];
        [self layoutIfNeeded];
    }];
}

- (void)addPinsOnMapWithPlaceArray:(NSArray <CQUPTMapPlaceItem *> *)placeArray {
    [self removeAllPinsOnMap];
    
    for (CQUPTMapPlaceItem *placeItem in placeArray) {
        UIImageView *pinImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Map_Pin"]];
        [self.mapView addSubview:pinImageView];
        [self.pinsArray addObject:pinImageView];
        
        [self layoutIfNeeded];
        [pinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mapView).offset(placeItem.centerX * self.mapView.width / self.mapScrollView.zoomScale - 12.5 / self.mapScrollView.zoomScale);
            make.top.equalTo(self.mapView).offset(placeItem.centerY * self.mapView.height / self.mapScrollView.zoomScale - 18 / self.mapScrollView.zoomScale);
            make.width.equalTo(@(25 / self.mapScrollView.zoomScale));
            make.height.equalTo(@(36 / self.mapScrollView.zoomScale));
        }];
        [self layoutIfNeeded];
        pinImageView.layer.anchorPoint = CGPointMake(0.5, 1);
        self.startScale = self.mapScrollView.zoomScale;
        
        pinImageView.layer.affineTransform = CGAffineTransformMakeScale(0, 0);
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:10 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            pinImageView.layer.affineTransform = CGAffineTransformMakeScale(1, 1);
        } completion:nil];
    }
}

- (void)removeAllPinsOnMap {
    for (UIImageView *pin in self.pinsArray) {
        [pin removeFromSuperview];
    }
    [self.pinsArray removeAllObjects];
}

- (void)transitionViewDragged:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self];
    
    CGFloat topY;
    if (((CQUPTMapViewController *)(self.viewController)).isPresent) {
        topY = 141;
    } else {
        topY = 181;
    }
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        self.lastY = sender.view.mj_y;
        
        if (sender.view.frame.origin.y < STATUSBARHEIGHT + topY && translation.y < 0) { // 到顶后继续上拉要减速
            translation.y = translation.y / (MAIN_SCREEN_H / sender.view.mj_y);
        }
                
        sender.view.center = CGPointMake(sender.view.center.x, sender.view.center.y + translation.y);
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
        // 超出范围后回弹
        if (sender.view.frame.origin.y < STATUSBARHEIGHT + topY) {       // 弹回到顶
            [UIView animateWithDuration:0.2 animations:^{
                sender.view.frame = CGRectMake(0, STATUSBARHEIGHT + topY, sender.view.width, sender.view.height);
            }];
            return;
        } else if (sender.view.frame.origin.y > self.height - 112) {  // 弹回到底
            [UIView animateWithDuration:0.1 animations:^{
                sender.view.frame = CGRectMake(0, MAIN_SCREEN_H, sender.view.width, sender.view.height);
            } completion:^(BOOL finished) {
                [self removeAllPinsOnMap];
                [self.detailView removeFromSuperview];
                self.detailView = nil;
            }];
            return;
        }
        
        // 速度和距离判断，如果速度或距离大于某个值，完全弹出或归位
        if (sender.view.mj_y - self.lastY < 0) {        // 往上拉
            if ((MAIN_SCREEN_H - 112) - sender.view.mj_y > 100 || sender.view.mj_y - self.lastY < -10) {    // 移动距离 > 50 或者速度足够快
                [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    sender.view.frame = CGRectMake(0, STATUSBARHEIGHT + topY, sender.view.width, sender.view.height);
                } completion:nil];
            } else {        // 移动距离太小，弹回到底
                [UIView animateWithDuration:0.2 animations:^{
                    sender.view.frame = CGRectMake(0, self.height - 112, sender.view.width, sender.view.height);
                }];
            }
        } else {                        // 往下拉
            if ((STATUSBARHEIGHT + topY) - sender.view.mj_y < -100 || sender.view.mj_y - self.lastY > 10) {    // 移动距离 > 50 或者速度足够快
                [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    sender.view.frame = CGRectMake(0, self.height - 112, sender.view.width, sender.view.height);
                } completion:nil];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    sender.view.frame = CGRectMake(0, STATUSBARHEIGHT + topY, sender.view.width, sender.view.height);
                }];
            }
        }
    }
    
    [sender setTranslation:CGPointZero inView:self];
}


#pragma mark - Button

- (void)starButtonClicked {
    
    // 先请求数据
    if ([self.delegate respondsToSelector:@selector(requestStarData)]) {
        [self.delegate requestStarData];
    }

}

- (void)starPlaceListRequestSuccess:(CQUPTMapStarPlaceItem *)starPlace {
    self.starPlace = starPlace;
    [starPlace archiveItem];
    
    if (starPlace.starPlaceArray.count == 0) {
        MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:self animated:YES];
        [hud setMode:(MBProgressHUDModeText)];
        hud.labelText = @"暂无收藏";
        [hud hide:YES afterDelay:1.2];
    }
    
    [self addPinsOnMapWithPlaceArray:[CQUPTMapStarPlaceItem starPlaceDetail]];
}


- (void)cancelSearch {
    [self endEditing:YES];
    
    [self.cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_trailing);
        make.centerY.equalTo(self.searchBar);
    }];
    
    [self.backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(STATUSBARHEIGHT + 15);
        make.leading.equalTo(self).offset(15);
        make.height.equalTo(@19);
        make.width.equalTo(@9);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGFloat beforeSearchViewY = CGRectGetMaxY(self.searchBar.frame);
        self.beforeSearchView.frame = CGRectMake(0, beforeSearchViewY + 100, MAIN_SCREEN_W, MAIN_SCREEN_H - beforeSearchViewY);
        self.beforeSearchView.alpha = 0;
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self.beforeSearchView removeFromSuperview];
    }];
}

- (void)hotButtonTapped:(UIButton *)sender {
    NSMutableArray *tmpArray = [@[] mutableCopy];
    
    for (NSString *placeID in ((CQUPTMapHotPlaceButton *)(sender.superview)).hotPlaceItem.placeIDArray) {
        for (CQUPTMapPlaceItem *place in self.mapDataItem.placeList) {
            if ([placeID isEqualToString:place.placeId]) {
                [tmpArray addObject:place];
            }
        }
    }
    
    [self addPinsOnMapWithPlaceArray:tmpArray];
}

- (void)vrButtonTapped {
    if ([self.delegate respondsToSelector:@selector(vrButtonTapped)]) {
        [self.delegate vrButtonTapped];
    }
}

@end
