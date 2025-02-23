//
//  DetailsgoodsModel.h
//  Details
//
//  Created by Edioth Jin on 2021/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsGoodsModel : NSObject

@property (nonatomic, copy) NSString * goods_name;
@property (nonatomic, assign) NSInteger goods_price;
@property (nonatomic, assign) long date;
@property (nonatomic, assign) BOOL is_received;
@property (nonatomic, copy) NSString * order_id;

/// 网络请求
/// @param success 成功之后执行的block
/// @param failure 失败之后,返回字符串
+ (void)getDataArySuccess:(void (^)(NSArray * array))success
                  failure:(void (^)(void))failure;

@end

NS_ASSUME_NONNULL_END
