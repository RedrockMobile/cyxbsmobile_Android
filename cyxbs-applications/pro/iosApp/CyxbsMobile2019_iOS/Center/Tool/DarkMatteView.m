//
//  DarkMatteView.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/10/31.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "DarkMatteView.h"

@implementation DarkMatteView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self setupTraitCollectionObserver];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
    [self setupTraitCollectionObserver];
}

- (void)setupView {
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.25;
    self.hidden = YES; // 初始化时隐藏视图
}

- (void)setupTraitCollectionObserver {
    if (@available(iOS 13.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
            self.hidden = NO;
        } else{
            self.hidden = YES;
        }
    } else {
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            BOOL isDarkMode = (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark);
            self.hidden = !isDarkMode;
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    }
    return view;
}

@end
