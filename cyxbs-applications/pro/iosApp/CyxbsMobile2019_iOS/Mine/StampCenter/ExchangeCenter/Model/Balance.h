//
//  Balance.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/8/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///余额模型类
@interface Balance : NSObject

@property (nonatomic, copy) NSString *icon;///邮豆图标
@property (nonatomic, copy) NSString *balance;///余额

/// 网络请求的函数
/// @param success 请求成功后执行的block
/// @param failure 请求失败后执行的block
+ (void)getDataDictWithBalance:(NSString*)goodsid
                   Success:(void (^)(NSDictionary *dict))success
                  failure:(void (^)(void))failure;

@end

NS_ASSUME_NONNULL_END
