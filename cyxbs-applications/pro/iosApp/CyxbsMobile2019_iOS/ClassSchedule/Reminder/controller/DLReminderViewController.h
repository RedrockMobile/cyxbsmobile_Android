//
//  DLReminderViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/9.
//  Copyright © 2020 Redrock. All rights reserved.
//添加备忘的初始界面

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLReminderViewController : UIViewController

/// 空课信息字典，init后由外界赋值
@property (nonatomic, copy)NSDictionary *remind;
@end

NS_ASSUME_NONNULL_END
