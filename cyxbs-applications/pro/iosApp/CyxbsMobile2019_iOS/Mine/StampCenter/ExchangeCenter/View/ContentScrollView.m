//
//  ContentScrollView.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/8/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "ContentScrollView.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import "Goods.h"
#import <YBImageBrowser.h>

#define picScrollViewWidth 360 * [UIScreen mainScreen].bounds.size.width / 390

@interface ContentScrollView()<SDCycleScrollViewDelegate>
@property (nonatomic, weak)SDCycleScrollView *cycleScrollView;
@end

@implementation ContentScrollView

///重写initWithFrame
- (instancetype)initWithFrame:(CGRect)frame AndID:(NSString *)ID{
    if ([super initWithFrame:frame]) {
        self.goodsID = ID;

        [self addBannerView];
        [self configure];
        
    }
    return  self;
}
///商品图片滚动
- (void) addBannerView {
    _bannerView = [[SDCycleScrollView alloc]init];
    [self addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(16);
        make.width.mas_equalTo(picScrollViewWidth);
        make.height.mas_equalTo(178);
    }];
    _bannerView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    
    NSString *s = self.goodsID;
    [Goods getDataDictWithId:s Success:^(NSDictionary * _Nonnull dict) {
        self.urls = dict[@"urls"];
        
        NSArray *imagesURLStrings = dict[@"urls"];
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@""]];
        [self addSubview:cycleScrollView];
        [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.top.equalTo(self).offset(16);
            make.width.mas_equalTo(picScrollViewWidth);
            make.height.mas_equalTo(178);
        }];
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.imageURLStringsGroup = imagesURLStrings;
        cycleScrollView.clipsToBounds = YES;
        cycleScrollView.layer.cornerRadius = 15;
        cycleScrollView.layer.shadowColor = [UIColor blackColor].CGColor;
        cycleScrollView.layer.shadowOpacity = 0.33f;
        cycleScrollView.layer.shadowColor = [UIColor colorWithRed:140/255.0 green:150/255.0 blue:217/255.0 alpha:1].CGColor;
        cycleScrollView.autoScrollTimeInterval = 3;
        cycleScrollView.layer.shadowOffset = CGSizeMake(0, 3);
        self.cycleScrollView = cycleScrollView;
        self.urlscount = imagesURLStrings.count;
//        [self addPageController];
        
        //图片的设置
        //设置图片浏览器的数据源数组
        NSMutableArray *dataMuteAry = [NSMutableArray array];
        for (int i = 0;i < self.urls.count; i++) {
            YBIBImageData *data = [YBIBImageData new];
            data.imageURL = [NSURL URLWithString:self.urls[i]];
            [dataMuteAry addObject:data];
        }
        self.urldataArray = dataMuteAry;
//        self.imageDataArray = dynamicDataModel.pics;
        
        } failure:^{
    }];
    
}


///分页控制器
- (void)addPageController {
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    [self addSubview:pageControl];
    _pageControl = pageControl;
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.bannerView.mas_bottom);
            make.width.mas_equalTo(125);
            make.height.mas_equalTo(30);
    }];
    pageControl.pageIndicatorTintColor =[UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.numberOfPages = self.urlscount;
    pageControl.currentPage = 0;

}
#pragma mark - configure
- (void)configure {
    
        
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bannerView);
        make.top.equalTo(self.bannerView.mas_bottomMargin).mas_offset(28);
        make.width.mas_equalTo(250);
    }];
    ///库存
    [self addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bannerView.mas_right);
            make.top.equalTo(self.bannerView.mas_bottomMargin).mas_offset(28);
            make.width.mas_equalTo(100);
    }];
    ///有效期
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).mas_offset(16);
            make.width.mas_equalTo(344);
    }];
    ///有效期
    [self addSubview:self.lastdayLabel];
    [self.lastdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textLabel);
            make.top.equalTo(self.textLabel.mas_bottom).offset(8);
            make.width.mas_equalTo(300);
    }];
    ///说明
    [self addSubview:self.tipsContentLabel];
    [self.tipsContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textLabel);
            make.top.equalTo(self.lastdayLabel.mas_bottom).offset(66);
//            make.right.equalTo(self.mas_right).offset(-16);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width * 345 / 375);
    }];
    
    
}
#pragma mark - delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    self.pageControl.currentPage = index;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = self.urldataArray;
    
    browser.currentPage = index;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
    
    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    
    [browser show];
    
}

#pragma mark - getter
///商品名字
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        _nameLabel.font = [UIFont systemFontOfSize:20];
    }
    return _nameLabel;
}
///库存
- (UILabel *)amountLabel {
    if (_amountLabel == nil) {
        _amountLabel = [[UILabel alloc]init];
        _amountLabel.textAlignment = NSTextAlignmentRight;
        _amountLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        _amountLabel.alpha = 0.4;
        _amountLabel.font = [UIFont systemFontOfSize:13];
    }
    return _amountLabel;
}
///商品说明
- (UILabel *)textLabel {
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        _textLabel.alpha = 0.8;
        _textLabel.font = [UIFont systemFontOfSize:16];
    }
    return _textLabel;
}
///有效期
- (UILabel *)lastdayLabel {
    if (_lastdayLabel == nil) {
        _lastdayLabel = [[UILabel alloc]init];
        _lastdayLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        _lastdayLabel.alpha = 0.8;
        _lastdayLabel.font = [UIFont systemFontOfSize:13];
    }
    return _lastdayLabel;
}
///说明
- (UILabel *)tipsContentLabel {
    if (_tipsContentLabel == nil) {
        UILabel *tipsLabel = [[UILabel alloc]init];
        [self addSubview:tipsLabel];
        [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.textLabel);
                make.top.equalTo(self.lastdayLabel.mas_bottom).offset(36);
                make.width.mas_equalTo(100);
        }];
        tipsLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        tipsLabel.alpha = 0.8;
        tipsLabel.font = [UIFont systemFontOfSize:14];
        tipsLabel.text = @"权益说明:";
        
        _tipsContentLabel = [[UILabel alloc]init];
        _tipsContentLabel.numberOfLines = 0;
        _tipsContentLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        _tipsContentLabel.alpha = 0.4;
        _tipsContentLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _tipsContentLabel;
}
@end
