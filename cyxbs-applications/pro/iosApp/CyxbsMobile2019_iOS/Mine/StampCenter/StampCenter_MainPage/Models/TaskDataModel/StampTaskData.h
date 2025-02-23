//
//  StampTaskData.h
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/15.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

///任务数据
@interface StampTaskData : NSObject

///标题
@property (nonatomic,copy) NSString *title;

///最大进度
@property (nonatomic,assign) int max_progress;

///已完成的进度
@property (nonatomic,assign) int current_progress;

///描述
@property (nonatomic,copy) NSString *Description;

///类型
@property (nonatomic,copy) NSString *type;

///获得的邮票
@property (nonatomic,assign) int gain_stamp;

///字典转模型
+ (instancetype)TaskDataWithDict:(NSDictionary *)dict;

///异步获取数据
+ (void)TaskDataWithSuccess:(void(^)(NSArray *array))success error:(void(^)(void))error;

@end

NS_ASSUME_NONNULL_END
