//
//  NextStationBtn.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NextStationBtn : UIButton

/// 线路Label
@property (nonatomic, strong) UILabel *lineLabel;
/// 双箭头切换标
@property (nonatomic, strong) UIImageView *imgView;
@end

NS_ASSUME_NONNULL_END
