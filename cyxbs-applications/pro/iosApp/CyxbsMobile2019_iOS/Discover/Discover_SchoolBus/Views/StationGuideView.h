//
//  StationGuideView.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/13.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationData.h"
#import "StationScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface StationGuideView : UIView

- (instancetype)initWithFrame:(CGRect)frame AndStationsData:(StationData *)data;

@end

NS_ASSUME_NONNULL_END
