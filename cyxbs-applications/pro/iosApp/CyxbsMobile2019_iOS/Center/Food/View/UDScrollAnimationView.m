//
//  UDScrollAnimationView.m
//  UDScrollAnimation
//
//  Created by 潘申冰 on 2023/2/2.
//

#import "UDScrollAnimationView.h"

@interface UDScrollAnimationView () {
    NSMutableArray *_scrollLayers;
    NSMutableArray *_scrollLabels;      // 保存label
}

@end

@implementation UDScrollAnimationView
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame TextArry:(NSArray *)textArr FinalText:(NSString *)finalText {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        _textArr = textArr;
        _finalText = finalText;
        [self prepareAnimations];
    }
    return self;
}

#pragma mark - Public Methods

- (void)reloadView {
    [self prepareAnimations];
}

- (void)startAnimation {
    [self createAnimations];
}

- (void)stopAnimation {
    for (CALayer *layer in _scrollLayers) {
        [layer removeAnimationForKey:@"UDScrollAnimationView"];
    }
}

#pragma mark - Private Methods
- (void)commonInit {
    self.duration = 0.8;
    self.isUp = NO;
    self.backgroundColor = UIColor.whiteColor;
    _scrollLayers = [NSMutableArray array];
    _scrollLabels = [NSMutableArray array];
}

- (void)prepareAnimations {
    // 先删除旧数据
    for (CALayer *layer in _scrollLayers) {
        [layer removeFromSuperlayer];
    }

    [_scrollLayers removeAllObjects];
    [_scrollLabels removeAllObjects];

    // 配置新的数据
    [self configScrollLayers];
}

- (void)configScrollLayers {
    CAScrollLayer *layer = [CAScrollLayer layer];

    layer.frame = self.bounds;
    [_scrollLayers addObject:layer];
    [self.layer addSublayer:layer];

    [self configScrollLayer:layer finalText:_finalText];
}

- (void)configScrollLayer:(CAScrollLayer *)layer finalText:(NSString *)finalText {
    NSMutableArray *scrollText = [NSMutableArray array];

    // 添加要滚动的字符串 ###这里要不要多弄几组?
    for (NSInteger i = 0; i < _textArr.count; i++) {
        [scrollText addObject:_textArr[i]];
    }

    if (_finalText) {
        [scrollText addObject:finalText];
    }

    // 修改局部变量的值需要使用 __block 修饰符
    __block CGFloat height = 0;
    // NSEnumerationReverse 倒序排列
    [scrollText enumerateObjectsWithOptions:
     NSEnumerationReverse usingBlock:^(NSString *text, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [self createLabel:text];
        label.frame = CGRectMake(0, height, CGRectGetWidth(layer.frame), CGRectGetHeight(layer.frame));

        label.backgroundColor = UIColor.clearColor;

        [layer addSublayer:label.layer];
        // 保存label，防止对象被回收
        [_scrollLabels addObject:label];
        // 累加高度
        height = CGRectGetMaxY(label.frame);
    }];
}

- (UILabel *)createLabel:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];

    label.textColor = self.textColor;
    label.font = self.font;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    return label;
}

- (void)createAnimations {
    for (CALayer *layer in _scrollLayers) {
        CGFloat maxY = [[layer.sublayers lastObject] frame].origin.y;
        // keyPath 是 sublayerTransform ，因为动画应用于 layer 的 subLayer。
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.y"];
        animation.duration = self.duration;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

        // 滚动方向
        if (self.isUp) {
            animation.fromValue = @0;
            animation.toValue = [NSNumber numberWithFloat:-maxY];
        } else {
            animation.fromValue = [NSNumber numberWithFloat:-maxY];
            animation.toValue = @0;
        }

        // 添加动画
        [layer addAnimation:animation forKey:@"UDScrollAnimationView"];
    }
}

#pragma mark - Setter

- (void)setTextArr:(NSArray *)textArr {
    _textArr = textArr;
    // 重新加载
    [self reloadView];
}

- (void)setFinalText:(NSString *)finalText {
    _finalText = finalText;
    // 重新加载
    [self reloadView];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    // 重新加载
    [self reloadView];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    // 重新加载
    [self reloadView];
}

@end
