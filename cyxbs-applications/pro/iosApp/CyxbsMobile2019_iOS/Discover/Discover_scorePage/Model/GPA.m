//
//  GPA.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/10.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "GPA.h"
@implementation GPA
- (void)fetchData {
    NSLog(@"请求GPA");
    
    [HttpTool.shareTool
     request:Discover_GET_GPA_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerJSON
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        if ([object[@"status"] intValue] == 10000) {
            //请求成功
//            NSLog(@"%@",responseObject);
            GPAItem *item = [[GPAItem alloc]initWithDictionary:object];
            self.gpaItem = item;
            NSLog(@"GPA请求成功");//发送消息更新tableView
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GPASucceed" object:nil];
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:Discover_GET_GPA_API parameters:nil error:nil];
//    req.timeoutInterval= [[NSUserDefaults.standardUserDefaults valueForKey:@"timeoutInterval"] longValue];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [req setValue:@"*/*" forHTTPHeaderField:@"Accept"];
//    [req setValue:[NSString stringWithFormat:@"Bearer %@",[UserItem defaultItem].token] forHTTPHeaderField:@"Authorization"];
//    [[manager dataTaskWithRequest:req uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
//        if ([responseObject[@"status"] intValue] == 10000) {
//            //请求成功
////            NSLog(@"%@",responseObject);
//            GPAItem *item = [[GPAItem alloc]initWithDictionary:responseObject];
//            self.gpaItem = item;
//            NSLog(@"GPA请求成功");//发送消息更新tableView
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"GPASucceed" object:nil];
//    } else {
//        NSLog(@"GPA请求失败Error: %@, %@, %@", error, response, responseObject);
//        //请求失败
//        
//    } }] resume];
}
@end
