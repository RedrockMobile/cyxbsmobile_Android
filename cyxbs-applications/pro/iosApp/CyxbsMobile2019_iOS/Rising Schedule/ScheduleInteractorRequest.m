//
//  ScheduleInteractorRequest.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/23.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleInteractorRequest.h"

#pragma mark - ScheduleInteractorRequest

@implementation ScheduleInteractorRequest

#pragma mark - Method

+ (void)request:(NSDictionary
                 <ScheduleModelRequestType,NSArray
                 <NSString *> *> *)requestDictionary
        success:(void (^)(ScheduleCombineModel *))success
        failure:(void (^)(NSError * _Nonnull))failure {
        
    [requestDictionary enumerateKeysAndObjectsUsingBlock:^(ScheduleModelRequestType _Nonnull key, NSArray<NSString *> * _Nonnull obj, BOOL * __unused stop) {
        
        for (NSString *num in obj) {
            
            [HttpTool.shareTool
             request:API_forScheduleModelRequestType(key)
             type:HttpToolRequestTypePost
             serializer:HttpToolRequestSerializerHTTP
             bodyParameters:@{
                KeyInParameterForScheduleModelRequestType(key) : num.copy,
            }
             progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable object) {
                
                NSArray *lessonAry = [object objectForKey:@"data"];
                
                BOOL check = (!object || !lessonAry || lessonAry.count == 0);
                if (check) {
                    NSAssert(check, @"\n🔴%s data : %@", __func__, lessonAry);
                    return;
                }
                
                NSString *stuNum = object[@"stuNum"];
                NSInteger nowWeek = [object[@"nowWeek"] longValue];
                
                ScheduleCombineModel *model =
                [ScheduleCombineModel
                 combineWithSno:stuNum
                 type:([key isEqualToString:ScheduleModelRequestCustom] ?
                       ScheduleCombineCustom :
                       ScheduleCombineSystem)];
                
                model.nowWeek = nowWeek;
                
                for (NSDictionary *courceDictionary in lessonAry) {
                    
                    ScheduleCourse *course = [[ScheduleCourse alloc] initWithDictionary:courceDictionary];
                    course.sno = stuNum.copy;
                    if ([key isEqualToString:ScheduleModelRequestCustom]) {
                        course.type = @"事务";
                    }
                    
                    [model.courseAry addObject:course];
                }
                
                
                if (success) {
                    success(model);
                }
            }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
    }];
}

- (void)requestCustomSuccess:(void (^)(void))success
                     failure:(void (^)(NSError * _Nonnull))failure {
    return
    [self.class request:@{ScheduleModelRequestCustom : @[@"Rising"]} success:^(ScheduleCombineModel * _Nonnull combineModel) {
        self->_customCombineModel = combineModel;
        if (success) {
            success();
        }
    } failure:failure];
}

- (void)appendCustom:(ScheduleCourse *)course
             success:(void (^)(void))success
             failure:(void (^)(NSError *error))failure {
    
}

- (void)editCustom:(ScheduleCourse *)course
           success:(void (^)(void))success
           failure:(void (^)(NSError * _Nonnull))failure {
    
}

- (void)deleteCustom:(ScheduleCourse *)course
             success:(void (^)(void))success
             failure:(void (^)(NSError * _Nonnull))failure {
    
}

@end
