//
//  Goods.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/8/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///货物模型类
@interface Goods : NSObject

@property (nonatomic, copy) NSString *urls;  ///商品图片
@property (nonatomic, copy) NSString *title; ///商品名字
@property (nonatomic, copy) NSString *life;  ///有效期


/// 网络请求的函数
/// @param goodsid 商品id
/// @param success 请求成功后执行的block
/// @param failure 请求失败后执行的block
+ (void)getDataDictWithId:(NSString*)goodsid
                   Success:(void (^)(NSDictionary *dict))success
                  failure:(void (^)(void))failure;

@end

NS_ASSUME_NONNULL_END
