//
//  CommonQuestionData.h
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/9/3.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonQuestionData : NSObject
///标题
@property (nonatomic,copy) NSString *title;
///内容
@property (nonatomic,copy) NSString *content;

///字典转模型
+ (instancetype)CommonQuestionDataWithDict:(NSDictionary *)dict;

///异步获取数据
+ (void)CommonQuestionDataWithSuccess:(void(^)(NSArray *array))success error:(void(^)(void))error;

@end

NS_ASSUME_NONNULL_END
