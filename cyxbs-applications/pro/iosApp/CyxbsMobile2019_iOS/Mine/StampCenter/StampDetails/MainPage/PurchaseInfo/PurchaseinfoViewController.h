//
//  PurchaseinfoViewController.h
//  Details
//
//  Created by Edioth Jin on 2021/8/9.
//

#import "TopBarBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 点击了一条兑换记录，跳转到这个控制器
 * 使用 initWithgoodsName:orderID:date:moment:price:received: 方法初始化自动展示购买信息的数据
 */
@interface PurchaseinfoViewController : TopBarBasicViewController

/// 初始化方法，不使用这个方法无法展示信息
/// @param goodsName 商品名称
/// @param orderID 订单编号
/// @param date 购买日期（时间戳）
/// @param price 商品价格
/// @param isReceived 是否被用户领取
- (instancetype)initWithgoodsName:(NSString *)goodsName
                              orderID:(NSString *)orderID
                                 date:(long)date
                                price:(NSInteger)price
                             received:(BOOL)isReceived;

@end

NS_ASSUME_NONNULL_END
