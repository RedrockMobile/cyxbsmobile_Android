//
//  BuyModel.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/9/5.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "BuyModel.h"

@implementation BuyModel

-(void)buyGoodsWithID:(NSString *)ID {
    HttpClient *client = [HttpClient defaultClient];
    NSDictionary *param = @{@"id":ID
    };
    [client requestWithPath:@"https://be-prod.redrock.team/magipoke-intergral/Integral/purchase" method:HttpRequestPost parameters:param prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self->_Block(responseObject[@"status"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure-exchange%@" ,error);
    }];
    
}

@end
