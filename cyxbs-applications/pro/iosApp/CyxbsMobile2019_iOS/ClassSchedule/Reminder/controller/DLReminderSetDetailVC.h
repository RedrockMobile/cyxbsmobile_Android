//
//  DLReminderSetDetailVC.h
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/10.
//  Copyright © 2020 Redrock. All rights reserved.
//添加具体内容页

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLReminderSetDetailVC : UIViewController
@property (nonatomic, strong) NSString *noticeString;
/// 空课信息字典，init后由DLReminderViewController赋值
@property (nonatomic, copy)NSDictionary *remind;
@end

NS_ASSUME_NONNULL_END
