//
//  WeekChooseViewController.h
//  Demo
//
//  Created by 李展 on 2016/11/26.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveDelegate.h"
@interface WeekChooseViewController : BaseViewController
@property (nonatomic, weak) id <SaveDelegate>delegate;
- (instancetype)initWithTimeArray:(NSArray *)weekArray;
@end
