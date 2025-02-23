//
//  BottomView.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/8/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Balance;
///底部View
@interface BottomView : UIView

///余额模型
@property (nonatomic, strong) Balance *balance;

///邮豆图标框
@property (nonatomic, strong) UIImageView *iconView;
///余额label
@property (nonatomic, strong) UILabel *balanceLabel;
///兑换按钮
@property (nonatomic, strong) UIButton *exchangeBtn;
///价格Label
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic,copy) NSString *goodsID;

- (instancetype)initWithFrame:(CGRect)frame AndID:(NSString *)ID;

@end

NS_ASSUME_NONNULL_END
