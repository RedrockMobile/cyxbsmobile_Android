//
//  questionModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/29.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "questionModel.h"


@implementation questionModel

- (void)loadQuestionList {
    
    [HttpTool.shareTool
     request:Mine_GET_questionList_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        self->_Block(object);
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetWorkToGetQuestionList" object:nil userInfo:nil];
    }];
    
//    HttpClient *client = [HttpClient defaultClient];
//    [client requestWithPath:Mine_GET_questionList_API method:HttpRequestGet parameters:nil prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        self->_Block(responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetWorkToGetQuestionList" object:nil userInfo:nil];
//    }];
}


@end

