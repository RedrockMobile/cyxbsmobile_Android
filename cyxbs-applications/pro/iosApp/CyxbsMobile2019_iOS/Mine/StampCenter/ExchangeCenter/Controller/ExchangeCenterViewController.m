//
//  ExchangeCenterViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/8/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "ExchangeCenterViewController.h"
#import <Masonry/Masonry.h>

#define iPhoneScreenWidth [UIScreen mainScreen].bounds.size.width
#define iPhoneScreenHeight [UIScreen mainScreen].bounds.size.height
#define picScrollViewWidth 360 * [UIScreen mainScreen].bounds.size.width / 390

@interface ExchangeCenterViewController ()




@end

@implementation ExchangeCenterViewController


- (instancetype)initWithID:(NSString *)ID{
    if (self = [super init]) {
        self.goodsID = ID;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    [self getData];
    [self configure];
   
    
}
#pragma mark - configure
///设置
- (void)configure {
    self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:1] darkColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:0.8]];
    self.VCTitleStr = @"";
    self.titlePosition = TopBarViewTitlePositionLeft;
    self.splitLineHidden = YES;
    self.titleFont = [UIFont fontWithName:PingFangSCSemibold size:22];
    self.titleColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    
    [self.view addSubview:self.contentView];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(iPhoneScreenWidth);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(68);
    }];
}

///网络请求
- (void)getData {

    NSString *s = self.goodsID;
    [Goods getDataDictWithId:s Success:^(NSDictionary * _Nonnull dict) {
        self.goodsDict = dict;
        self.contentView.nameLabel.text = dict[@"title"];
        self.amount = [self.goodsDict[@"amount"]intValue];
        self.contentView.amountLabel.text = [@"库存量：" stringByAppendingString: [NSString stringWithFormat:@"%@",self.goodsDict[@"amount"]]];
        self.contentView.textLabel.text = self.goodsDict[@"description" ];
        self.contentView.lastdayLabel.text = [[@"有效期：" stringByAppendingString: [NSString stringWithFormat:@"%@",self.goodsDict[@"life"]]] stringByAppendingString:@"天"];
        int type = [self.goodsDict[@"type"]intValue];
        if (type == 0) {
            self.VCTitleStr = @"邮货详情";
            self.contentView.tipsContentLabel.text = @"1、每个实物商品每人限兑换一次，已经兑换的商品不能退货换货也不予折现。\n2、在法律允许的范围内，本活动的最终解释权归红岩网校工作站所有。";
        }else{
            self.VCTitleStr = @"装扮详情";
            self.contentView.tipsContentLabel.text = @"1、虚拟商品版权归红岩网校工作站所有。\n2、在法律允许的范围内，本活动的最终解释权归红岩网校工作站所有。";
        }
        } failure:^{
            
        }];
    
}

#pragma mark - private
///是否兑换
- (void)isExchange {
    PopupView *popupView = [[PopupView alloc] initWithGoodsName:self.contentView.nameLabel.text AndCount:self.bottomView.priceLabel.text AndAmount:self.amount  AndID:_goodsID];
    popupView.frame = CGRectMake(0, 0, 414, 900);
    [self.view addSubview:popupView];
    _popupView = popupView;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapBehind:)];
    UITapGestureRecognizer *whitegesture = [[UITapGestureRecognizer alloc]init];
//    [gesture setNumberOfTapsRequired:1];
//    gesture.cancelsTouchesInView = YES;
    [popupView.grayView addGestureRecognizer:gesture];
    [popupView.whiteView addGestureRecognizer:whitegesture];
}
///返回主页面
- (void)returnindex {
    [self.navigationController popViewControllerAnimated:YES];
}
///击其他区域关闭弹窗
- (void)handleTapBehind:(UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self.popupView removeFromSuperview];
    }
}

#pragma mark - getter

///内容
- (ContentScrollView *)contentView {
    if (_contentView == nil) {
        _contentView = [[ContentScrollView alloc]initWithFrame:CGRectMake(0, 88.0 / 812 * iPhoneScreenHeight, iPhoneScreenWidth, iPhoneScreenHeight - 88.0 / 812 * iPhoneScreenHeight - 68) AndID:self.goodsID];
        _contentView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
        
        //设置contentSize
        [_contentView layoutIfNeeded];
        if (_contentView.tipsContentLabel.frame.origin.y + _contentView.tipsContentLabel.frame.size.height < iPhoneScreenHeight - 88 - 68) {
            _contentView.contentSize = CGSizeMake(iPhoneScreenWidth, iPhoneScreenHeight - 88 - 68);
        }else{
            _contentView.contentSize = CGSizeMake(iPhoneScreenWidth, _contentView.tipsContentLabel.frame.origin.y + _contentView.tipsContentLabel.frame.size.height + 10);
        }
    }
    return _contentView;
}
- (BottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[BottomView alloc]initWithFrame:CGRectZero AndID:self.goodsID];
        _bottomView.goodsID = self.goodsID;
        _bottomView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
        [_bottomView.exchangeBtn addTarget:self action:@selector(isExchange) forControlEvents:UIControlEventTouchUpInside];
        //设置数据
        _bottomView.balanceLabel.text = [@"余额：" stringByAppendingString:@""];
    }
    return _bottomView;
}
@end

