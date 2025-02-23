//
//  DetailsTaskModel.h
//  Details
//
//  Created by Edioth Jin on 2021/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsTaskModel : NSObject

@property (nonatomic, copy) NSString * task_name;
@property (nonatomic, assign) NSInteger task_income;
@property (nonatomic, assign) long date;

/// 网络请求的函数
/// @param page 请求的页数
/// @param size 每一次请求返回数据的个数
/// @param success 请求成功后执行的block
/// @param failure 请求失败后执行的block
+ (void)getDataAryWithPage:(NSInteger)page
                      Size:(NSInteger)size
                   Success:(void (^)(NSArray * array))success
                  failure:(void (^)(void))failure;

@end

NS_ASSUME_NONNULL_END
