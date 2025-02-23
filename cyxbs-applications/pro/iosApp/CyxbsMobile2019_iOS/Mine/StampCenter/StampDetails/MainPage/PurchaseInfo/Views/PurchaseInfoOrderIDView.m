//
//  PurchaseInfoOrderIDView.m
//  Details
//
//  Created by Edioth Jin on 2021/8/9.
//

#import "PurchaseInfoOrderIDView.h"

@interface PurchaseInfoOrderIDView ()

/// 背景图片
@property (nonatomic, strong) UIImageView * backgroundImgView;
/// 订单编号
@property (nonatomic, strong) UILabel * orderIDLabel;

@end

@implementation PurchaseInfoOrderIDView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.backgroundImgView];
    [self addSubview:self.orderIDLabel];
}

- (void)setupFrame {
    for (UIView * view in self.subviews) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // configure background imgView
    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:_backgroundImgView
                                     attribute:(NSLayoutAttributeLeft)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:self
                                     attribute:(NSLayoutAttributeLeft)
                                    multiplier:1.f
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:_backgroundImgView
                                     attribute:(NSLayoutAttributeRight)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:self
                                     attribute:(NSLayoutAttributeRight)
                                    multiplier:1.f
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:_backgroundImgView
                                     attribute:(NSLayoutAttributeTop)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:self
                                     attribute:(NSLayoutAttributeTop)
                                    multiplier:1.f
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:_backgroundImgView
                                     attribute:(NSLayoutAttributeBottom)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:self
                                     attribute:(NSLayoutAttributeBottom)
                                    multiplier:1.f
                                      constant:0]
    ]];
    
    // configure orderID label
    // label 距离左侧为整个长度的 1/16
    // label 距离上侧为整个长度的 1/3
    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:_orderIDLabel
                                     attribute:(NSLayoutAttributeLeft)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:self
                                     attribute:(NSLayoutAttributeLeft)
                                    multiplier:1.f
                                      constant:self.frame.size.width/16],
        [NSLayoutConstraint constraintWithItem:_orderIDLabel
                                     attribute:(NSLayoutAttributeTop)
                                     relatedBy:(NSLayoutRelationEqual)
                                        toItem:self
                                     attribute:(NSLayoutAttributeTop)
                                    multiplier:1.f
                                      constant:self.frame.size.height/3]
    ]];
    
    
}

#pragma mark - setter

- (void)setOrderID:(NSString *)orderID
          received:(BOOL)isReceived {
    _orderID = orderID;
    _received = isReceived;
    self.orderIDLabel.text = orderID;
    self.backgroundImgView.image = [UIImage imageNamed:isReceived? @"purchaseInfo_received": @"purchaseInfo_notreceived"];
    [self setupFrame];
}

#pragma mark - getter

- (UIImageView *)backgroundImgView {
    if (_backgroundImgView == nil) {
        _backgroundImgView = [[UIImageView alloc] initWithFrame:(CGRectZero)];
        
    }
    return _backgroundImgView;
}

- (UILabel *)orderIDLabel {
    if (_orderIDLabel == nil) {
        _orderIDLabel = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _orderIDLabel.font = [UIFont fontWithName:PingFangSCSemibold size:23];
        _orderIDLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.9];
        [_orderIDLabel sizeToFit];
    }
    return _orderIDLabel;
}

@end
