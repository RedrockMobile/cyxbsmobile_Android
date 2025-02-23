//
//  ContentScrollView.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/8/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
#import <SDCycleScrollView.h>

NS_ASSUME_NONNULL_BEGIN
///内容ScrollView
@interface ContentScrollView : UIScrollView
///商品模型
@property (nonatomic, strong) Goods *goods;
///图片轮播器
//@property (nonatomic, strong) SDCycleScrollView *picScrollView;
///名字
@property (nonatomic, strong) UILabel *nameLabel;
///库存
@property (nonatomic, strong) UILabel *amountLabel;
///内容
@property (nonatomic, strong) UILabel *textLabel;
///有效期
@property (nonatomic, strong) UILabel *lastdayLabel;
///说明Label
@property (nonatomic, strong) UILabel *tipsContentLabel;
///分页控制器
@property (weak, nonatomic)  UIPageControl *pageControl;
///商品ID
@property (nonatomic,copy) NSString *goodsID;
///左
@property (nonatomic, strong) UIView *leftimgView;
///中
@property (nonatomic, strong) UIView *centerimgView;
///右
@property (nonatomic, strong) UIView *rightimgView;
///计时器
@property (nonatomic, strong) NSTimer *timer;
///URLS
@property (nonatomic, copy) NSArray *urls;
///URLS数量
@property (nonatomic, assign) NSInteger urlscount;
///图片浏览器的数据源数组
@property (nonatomic, copy) NSArray *urldataArray;
///轮播器
@property (nonatomic, strong) SDCycleScrollView *bannerView;//

@property (nonatomic, copy) NSArray *color1;

- (instancetype)initWithFrame:(CGRect)frame AndID:(NSString *)ID;


@end

NS_ASSUME_NONNULL_END
