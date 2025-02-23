//
//  ClassDetailView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/16.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
//某课详情弹窗的高度
#define DETAILVIEW_H (MAIN_SCREEN_H*0.38)
NS_ASSUME_NONNULL_BEGIN
///显示某课详情的弹窗view
@interface ClassDetailView : UIView
/// 显示一节课详情的view


/// 该节课的信息字典，暂时好像只有存信息的功能，先存着吧，以后或许有用。
/// 重写了setDataDict:，给dataDict赋值就可以自动完成对内部label文字的设置
@property(nonatomic, strong)NSDictionary *dataDict;
@end

NS_ASSUME_NONNULL_END
//用法：
//1.
//ClassDetailView *view = [[ClassDetailView alloc] init];

//2.对课信息字典赋值，赋值后自动设置内部文本
//view.dataDict = dict;

//3.设置frame，默认frame为CGRectMake(0, 0, MAIN_SCREEN_W, DETAILVIEW_H)];
//[view setFrame:CGRectMake(0, 0, MAIN_SCREEN_W, DETAILVIEW_H)];

//4.加入父控件
//[xxxView addSubview:view];
