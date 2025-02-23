//
//  AttitudeMainPageVC.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/7.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "TopBarBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttitudeMainPageVC : TopBarBasicViewController
@property (nonatomic, assign) BOOL isTopBarButtonHidden;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *topBarButton;
/// 获取数据
- (void)getRequestData;
/// 点击按钮方法
- (void)clickPublishBtn;
@end

NS_ASSUME_NONNULL_END
