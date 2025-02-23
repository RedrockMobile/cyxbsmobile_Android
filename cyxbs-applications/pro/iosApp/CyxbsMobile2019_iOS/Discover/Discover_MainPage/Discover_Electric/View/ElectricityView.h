//
//  ElectricityView.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/4/19.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ElectricityView : UIView

/// 电费查询部分
@property (nonatomic, strong) UILabel *electricFeeTitle;//”电费查询“
@property (nonatomic, strong) UILabel *electricFeeTime;//抄表时间
@property (nonatomic, strong) UILabel *electricFeeMoney;//电费
@property (nonatomic, strong) UILabel *electricConsumption;//用电量
@property (nonatomic, strong) UILabel *electricFeeYuan;//“元”
@property (nonatomic, strong) UILabel *electricFeeDu;//“度”
@property (nonatomic, strong) UILabel *electricFeeHintLeft;//“费用/本月”
@property (nonatomic, strong) UILabel *electricFeeHintRight;//“使用度数/本月”
@property (nonatomic, strong) UILabel *hintLabel;//“还未绑定账号哦～”

/// 当有数据的时候调用这个方法更新为有预览的视图
- (void)refreshViewIfNeeded;

@end

NS_ASSUME_NONNULL_END
