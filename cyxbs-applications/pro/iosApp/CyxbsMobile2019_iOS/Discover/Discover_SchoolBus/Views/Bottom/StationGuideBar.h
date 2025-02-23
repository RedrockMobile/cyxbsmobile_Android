//
//  StationGuideBar.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/15.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextStationBtn.h"

NS_ASSUME_NONNULL_BEGIN

@interface StationGuideBar : UIScrollView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *runtimeLabel;
@property (nonatomic, strong) UIButton *sendtypeBtn;
@property (nonatomic, strong) UIButton *runtypeBtn;
@property (nonatomic, strong) NextStationBtn *lineBtn;
@property (nonatomic, copy) NSArray *lineDataArray;
@property (nonatomic, copy) NSArray *stationDataArray;

@end

NS_ASSUME_NONNULL_END
