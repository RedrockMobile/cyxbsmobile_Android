//
//  StationScrollView.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/15.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationData.h"
#import "StationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface StationScrollView : UIScrollView

@property (nonatomic, strong) NSArray <StationView *> *stationsViewArray;
/// 设置数据
@property (nonatomic, strong) StationData *stationData;
@end

NS_ASSUME_NONNULL_END
