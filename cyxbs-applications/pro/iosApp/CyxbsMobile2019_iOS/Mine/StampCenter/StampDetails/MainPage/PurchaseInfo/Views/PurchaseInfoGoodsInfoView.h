//
//  PurchaseInfogoodsInfoView.h
//  Details
//
//  Created by Edioth Jin on 2021/8/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 商品信息的自定义 View
 * 展示商品的详细信息，购买商品的信息
 * 通过 setgoodsName:goodsPrice:tradingTime:received: 方法初始化数据
 */
@interface PurchaseInfoGoodsInfoView : UIView

/// 名称
@property (nonatomic, copy, readonly) NSString * goodsName;
/// 价格
@property (nonatomic, assign, readonly) NSInteger goodsPrice;
/// 交易时间
@property (nonatomic, assign, readonly) long tradingTime;
/// 是否领取
@property (nonatomic, assign, readonly) BOOL received;

/// 设置这个 View 的信息
/// @param goodsName 商品名称
/// @param goodsPrice 商品价格
/// @param tradingTime 商品购买时间
/// @param isReceived 商品是否被领取
- (void)setgoodsName:(NSString *)goodsName
          goodsPrice:(NSInteger)goodsPrice
             tradingTime:(long)tradingTime
                received:(BOOL)isReceived;

@end

NS_ASSUME_NONNULL_END
