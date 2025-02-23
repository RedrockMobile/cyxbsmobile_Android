//
//  SportAttendanceHeadView.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/3.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SportAttendanceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SportAttendanceHeadView : UIView

///加载视图
- (void)loadViewWithDate:(SportAttendanceModel *)sAData Isholiday:(bool)holiday;

@end

NS_ASSUME_NONNULL_END
