//
//  WeDateViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/7/30.
//  Copyright © 2020 Redrock. All rights reserved.
//这个类是没课约最开始的那个页面的控制器

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeDateViewController : UIViewController
/**只能用这个方法初始化这个类，因为内部需要使用这个infoDictArray数组*/
- (instancetype)initWithInfoDictArray:(NSMutableArray*)infoDictArray;
@end

NS_ASSUME_NONNULL_END
