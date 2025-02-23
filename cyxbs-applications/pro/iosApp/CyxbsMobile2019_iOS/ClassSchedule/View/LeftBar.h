//
//  LeftBar.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/17.
//  Copyright © 2020 Redrock. All rights reserved.
//左侧的第几节课的条

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeftBar : UIView

@end

NS_ASSUME_NONNULL_END

//用法：
//1.init方法会默认给它设置fram为CGRectMake(0, 0, MONTH_ITEM_W, 12*H_H+11*dis)
//LeftBar *leftBar = [[LeftBar alloc] init];

//2.
//[scrollView addSubview:leftBar];

//3.设置frame
//leftBar.frame = CGRectMake(0,0, MONTH_ITEM_W, leftBar.frame.size.height);

