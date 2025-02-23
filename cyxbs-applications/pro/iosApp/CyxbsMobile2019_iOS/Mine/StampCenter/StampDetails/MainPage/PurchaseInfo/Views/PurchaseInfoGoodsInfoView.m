//
//  PurchaseInfogoodsInfoView.m
//  Details
//
//  Created by Edioth Jin on 2021/8/9.
//

#import "PurchaseInfoGoodsInfoView.h"

@interface PurchaseInfoGoodsInfoView ()

@property (nonatomic, strong) UILabel * goodsNameLabel;
@property (nonatomic, strong) UILabel * goodsPriceLabel;
@property (nonatomic, strong) UILabel * traidingTimeLabel;
@property (nonatomic, strong) UILabel * isReceivedLabel;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, copy) NSArray * ary;
@property (nonatomic, copy) NSDictionary * dict;

@end

@implementation PurchaseInfoGoodsInfoView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.goodsNameLabel];
    [self addSubview:self.goodsPriceLabel];
    [self addSubview:self.traidingTimeLabel];
    [self addSubview:self.isReceivedLabel];
}

- (void)setupFrame {
    UILabel * topLabel = _titleLabel;
    for (int i = 0; i < 4; i++) {
        UILabel * label = [self createLabel];
        NSString * key = _ary[i];
        NSString * value = _dict[key];
        label.text = [NSString stringWithFormat:@"%@:\t\t%@", key, value];
        [self addSubview:label];
        [self addConstraints:@[
            [NSLayoutConstraint constraintWithItem:label
                                         attribute:(NSLayoutAttributeLeft)
                                         relatedBy:(NSLayoutRelationEqual)
                                            toItem:topLabel
                                         attribute:(NSLayoutAttributeLeft)
                                        multiplier:1.f
                                          constant:0],
            [NSLayoutConstraint constraintWithItem:label
                                         attribute:(NSLayoutAttributeTop)
                                         relatedBy:(NSLayoutRelationEqual)
                                            toItem:topLabel
                                         attribute:(NSLayoutAttributeBottom)
                                        multiplier:1.f
                                          constant:[topLabel isEqual:_titleLabel]? 20: 10]
        ]];
        topLabel = label;
    }
}

#pragma mark - private

- (UILabel *)createLabel {
    UILabel * label = [[UILabel alloc] initWithFrame:(CGRectZero)];
    [label sizeToFit];
    label.font = [UIFont fontWithName:PingFangSCMedium size:14];
    label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    return label;
}

- (void)setgoodsName:(NSString *)goodsName
          goodsPrice:(NSInteger)goodsPrice
             tradingTime:(long)tradingTime
                received:(BOOL)isReceived {
    _goodsName = goodsName;
    _goodsPrice = goodsPrice;
    _tradingTime = tradingTime;
    _received = isReceived;
    _ary = @[
        @"商品名称",
        @"商品价格",
        @"交易时间",
        @"商品状态"
    ];
    _dict = @{
        _ary[0] : goodsName,
        _ary[1] : [NSString stringWithFormat:@"%@邮票", @(goodsPrice)],
        _ary[2] : getTimeFromTimestampWithDateFormat(_tradingTime, @"YYYY-MM-dd HH:mm"),
        _ary[3] : (isReceived? @"已领取": @"未领取")
    };
    [self setupFrame];
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:16];
        _titleLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        _titleLabel.text = @"商品详情";
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

@end
