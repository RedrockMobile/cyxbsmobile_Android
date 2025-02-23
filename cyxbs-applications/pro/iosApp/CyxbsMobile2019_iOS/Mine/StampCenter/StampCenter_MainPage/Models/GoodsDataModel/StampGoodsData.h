//
//  StampGoodsData.h
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/15.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///商品数据
@interface StampGoodsData : NSObject

///商品id
@property (nonatomic,assign) int id;

///标题
@property (nonatomic,copy) NSString *title;

///图片url
@property (nonatomic,copy) NSString *url;

///数量
@property (nonatomic,assign) int amount;

///价格
@property (nonatomic,assign) int price;

///类型
@property (nonatomic,assign) int type;

///字典转模型
+ (instancetype)GoodsDataWithDict:(NSDictionary *)dict;

///异步获取数据
+ (void)GoodsDataWithSuccess:(void(^)(NSArray *array))success error:(void(^)(void))error;

@end

NS_ASSUME_NONNULL_END
