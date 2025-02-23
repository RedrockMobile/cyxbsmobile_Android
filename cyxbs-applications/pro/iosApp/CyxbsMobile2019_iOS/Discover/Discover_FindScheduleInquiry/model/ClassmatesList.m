//
//  ClassmatesList.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/9/27.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ClassmatesList.h"
@interface ClassmatesList ()
@property (nonatomic,assign)PeopleType peopleType;
@end
@implementation ClassmatesList

- (instancetype)initWithPeopleType:(PeopleType)peoType{
    self = [super init];
    if (self) {
        self.peopleType = peoType;
    }
    return self;
}

- (void)getListWithName:(NSString *)name success:(void (^)(ClassmatesList * _Nonnull))succeededCallBack failure:(nonnull void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failedCallBack {
    
    NSDictionary *parameters = @{@"stu": name};
    
    [HttpTool.shareTool
     request:ClassSchedule_GET_searchPeople_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:parameters
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSDictionary *classmateInfo in object[@"data"]) {
            ClassmateItem *classmate = [ClassmateItem classmateWithDictionary:classmateInfo];
            [tmpArray addObject:classmate];
        }
        self.classmatesArray = tmpArray;
        succeededCallBack(self);
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedCallBack(task, error);
    }];
}

- (void)getTeaListWithName:(NSString *)name success:(void (^)(ClassmatesList *classmatesList))succeededCallBack failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failedCallBack{

    [HttpTool.shareTool
     form:ClassSchedule_POST_searchTeacher_API
     type:HttpToolRequestTypePost
     parameters:nil
     bodyConstructing:^(id<AFMultipartFormData>  _Nonnull body) {
        
        NSData *data = [name dataUsingEncoding:NSUTF8StringEncoding];
        [body appendPartWithFormData:data name:@"teaName"];
        
    }
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSDictionary *classmateInfo in object[@"data"]) {
            ClassmateItem *classmate = [ClassmateItem teaItemWithDictionary:classmateInfo];
            [tmpArray addObject:classmate];
        }
        self.classmatesArray = tmpArray;
        if (succeededCallBack) {
            succeededCallBack(self);
        }
        
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedCallBack) {
            failedCallBack(task,error);
        }
    }];
}

- (void)getPeopleListWithName:(NSString*)name success:(void (^)(ClassmatesList *classmatesList))succeededCallBack failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failedCallBack{
//    NSDictionary *paramDict;
    if(self.peopleType==PeopleTypeStudent){
        [self getListWithName:name success:succeededCallBack failure:failedCallBack];
    }else{
        [self getTeaListWithName:name success:succeededCallBack failure:failedCallBack];
    }
}
- (NSArray<NSDictionary *> *)infoDicts{
    if(_infoDicts==nil){
        NSMutableArray *array = [NSMutableArray array];
        for (ClassmateItem *item in self.classmatesArray) {
            NSDictionary *infoDict = @{
                @"name":item.name,
                @"stuNum":item.stuNum
            };
            [array addObject:infoDict];
        }
        _infoDicts = [array copy];
    }
    return _infoDicts;
}
@end
