//
//  PurchaseInfoOrderIDView.h
//  Details
//
//  Created by Edioth Jin on 2021/8/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 订单编号及其后面的图片
 * 初始化之后再传入数据，数据自动布局
 */
@interface PurchaseInfoOrderIDView : UIView

@property (nonatomic, copy, readonly) NSString * orderID;
@property (nonatomic, assign, getter=isReceived, readonly) BOOL received;

/// 设置数据的方法
/// @param orderID 订单编号
/// @param isReceived 是否被领取，决定了后面的图片是否有颜色
- (void)setOrderID:(NSString *)orderID
          received:(BOOL)isReceived;

@end

NS_ASSUME_NONNULL_END
