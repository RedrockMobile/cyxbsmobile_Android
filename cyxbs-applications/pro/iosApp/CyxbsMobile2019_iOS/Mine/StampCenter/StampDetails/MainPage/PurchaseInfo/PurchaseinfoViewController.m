//
//  PurchaseinfoViewController.m
//  Details
//
//  Created by Edioth Jin on 2021/8/9.
//

#import "PurchaseinfoViewController.h"
// views
#import "PurchaseInfoGoodsInfoView.h"
#import "PurchaseInfoOrderIDView.h"

@interface PurchaseinfoViewController ()

/// 商品详情
@property (nonatomic, strong) PurchaseInfoGoodsInfoView * PurchaseInfoGoodsInfoView;
/// 订单编号视图
@property (nonatomic, strong) PurchaseInfoOrderIDView * PurchaseInfoOrderIDView;

// 数据信息，和传入的init方法传入的参数对应
@property (nonatomic, copy) NSString * goods_name;
@property (nonatomic, assign) NSInteger price; // 改成 price 比较好
@property (nonatomic, assign) long date;
@property (nonatomic, assign) BOOL received;
@property (nonatomic, copy) NSString * order_id;

@end

@implementation PurchaseinfoViewController

#pragma mark - life cycle

- (instancetype)initWithgoodsName:(NSString *)goodsName
                              orderID:(NSString *)orderID
                                 date:(long)date
                                price:(NSInteger)price
                             received:(BOOL)isReceived {
    self = [super init];
    if (self) {
        _goods_name = goodsName;
        _price = price;
        _date = date;
        _order_id = orderID;
        _received = isReceived;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)configureView {
    self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:1] darkColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:0.8]];
    self.VCTitleStr = @"兑换详情";
    self.splitLineHidden = YES;
    self.titlePosition = TopBarViewTitlePositionLeft;
    self.splitLineColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:0.1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    self.titleFont = [UIFont fontWithName:PingFangSCSemibold size:22];
    
    // PurchaseInfoOrderIDView
    [self.view addSubview:self.PurchaseInfoOrderIDView];
    [self.view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:_PurchaseInfoOrderIDView
                                     attribute:(NSLayoutAttributeTop)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:self.topBarView
                                     attribute:(NSLayoutAttributeBottom)
                                    multiplier:1.f
                                      constant:40],
        [NSLayoutConstraint constraintWithItem:_PurchaseInfoOrderIDView
                                     attribute:(NSLayoutAttributeLeft)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:self.view
                                     attribute:(NSLayoutAttributeLeft)
                                    multiplier:1.f
                                      constant:16],
        [NSLayoutConstraint constraintWithItem:_PurchaseInfoOrderIDView
                                     attribute:(NSLayoutAttributeRight)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:self.view
                                     attribute:(NSLayoutAttributeRight)
                                    multiplier:1.f
                                      constant:-16],
        [NSLayoutConstraint constraintWithItem:_PurchaseInfoOrderIDView
                                     attribute:(NSLayoutAttributeHeight)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:_PurchaseInfoOrderIDView
                                     attribute:(NSLayoutAttributeWidth)
                                    multiplier:108.f/343
                                      constant:0]
    ]];
    [_PurchaseInfoOrderIDView layoutIfNeeded];
    [_PurchaseInfoOrderIDView setOrderID:_order_id received:_received];
    
    // PurchaseInfoGoodsInfoView
    [self.view addSubview:self.PurchaseInfoGoodsInfoView];
    [self.view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:_PurchaseInfoGoodsInfoView
                                     attribute:(NSLayoutAttributeLeft)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:_PurchaseInfoOrderIDView
                                     attribute:(NSLayoutAttributeLeft)
                                    multiplier:1.f
                                      constant:10],
        [NSLayoutConstraint constraintWithItem:_PurchaseInfoGoodsInfoView
                                     attribute:(NSLayoutAttributeRight)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:_PurchaseInfoOrderIDView
                                     attribute:(NSLayoutAttributeRight)
                                    multiplier:1.f
                                      constant:-10],
        [NSLayoutConstraint constraintWithItem:_PurchaseInfoGoodsInfoView
                                     attribute:(NSLayoutAttributeTop)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:_PurchaseInfoOrderIDView
                                     attribute:(NSLayoutAttributeBottom)
                                    multiplier:1.f
                                      constant:40],
        [NSLayoutConstraint constraintWithItem:_PurchaseInfoGoodsInfoView
                                     attribute:(NSLayoutAttributeBottom)
                                     relatedBy:(NSLayoutRelationLessThanOrEqual)
                                        toItem:self.view
                                     attribute:(NSLayoutAttributeBottom)
                                    multiplier:1.f
                                      constant:0]
    ]];
    [_PurchaseInfoGoodsInfoView setgoodsName:_goods_name
                          goodsPrice:_price
                             tradingTime:_date
                                received:_received];
    
}

#pragma mark - getter

- (PurchaseInfoOrderIDView *)PurchaseInfoOrderIDView {
    if (_PurchaseInfoOrderIDView == nil) {
        _PurchaseInfoOrderIDView = [[PurchaseInfoOrderIDView alloc] init];
        _PurchaseInfoOrderIDView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _PurchaseInfoOrderIDView;
}

- (PurchaseInfoGoodsInfoView *)PurchaseInfoGoodsInfoView {
    if (_PurchaseInfoGoodsInfoView == nil) {
        _PurchaseInfoGoodsInfoView = [[PurchaseInfoGoodsInfoView alloc] initWithFrame:(CGRectZero)];
        _PurchaseInfoGoodsInfoView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _PurchaseInfoGoodsInfoView;
}

@end
