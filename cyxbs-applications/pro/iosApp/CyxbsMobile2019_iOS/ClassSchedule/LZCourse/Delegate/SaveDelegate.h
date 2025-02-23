//
//  SaveDelegate.h
//  Demo
//
//  Created by 李展 on 2016/11/27.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SaveDelegate <NSObject>
- (void)saveWeeks:(NSArray *)weekArray;
- (void)saveTimes:(NSArray *)timeArray;
//- (void)saveAndPostRemind:(NSDictionary *)remindDic;
@end
