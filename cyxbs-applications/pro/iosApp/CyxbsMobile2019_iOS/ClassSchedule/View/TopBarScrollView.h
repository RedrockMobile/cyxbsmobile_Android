//
//  TopBarScrollView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/7/31.
//  Copyright © 2020 Redrock. All rights reserved.
//顶部周信息条，@“回到本周”、@“二周”、选择周的条的bar

#import <UIKit/UIKit.h>
#import "DateModle.h"
NS_ASSUME_NONNULL_BEGIN


@protocol TopBarScrollViewDelegate <NSObject>
//index里面是0，代表点击整学期，是17代表点击十七周
- (void)gotoWeekAtIndex:(NSNumber*)index;
@end

@interface TopBarScrollView : UIScrollView

//通过修改correctIndex会自动完成以下操作：
//1.该下标对应的周view移动到中央，如果是边缘的按钮那就不会移到中央
//2.对应周的按钮字体变大，原先下标所在的按钮字体复原
//3.让代理(课表)也把课表位置移动到现在的位置
//4.自动判断是否显示“回到本周”按钮
//改变nowWeekBar的周信息
//改变correctIndex，KVO会根据correctIndex的改变完成一系列相关操作,0代表在整学期页
@property (nonatomic,assign)NSNumber *correctIndex;
/// 代理，点击回到本周按钮后，会让课表去某一周
@property (nonatomic,weak)id<TopBarScrollViewDelegate>weekChooseDelegate;

/// 日期等数据的来源
@property (nonatomic,strong)DateModle *dateModel;
@end

NS_ASSUME_NONNULL_END
