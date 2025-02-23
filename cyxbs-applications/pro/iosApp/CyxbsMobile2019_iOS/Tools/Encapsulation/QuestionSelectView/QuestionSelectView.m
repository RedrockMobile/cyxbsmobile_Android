//
//  QuestionSelectView.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/3/30.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "QuestionSelectView.h"

#pragma mark - DelegateFlags

// DelegateFlags & DataSourceFlags

//MARK: QuestionSelectViewDelegateFlags

typedef struct {
    
    /// gapBetweenButtonsAtQuestionSelectView
    BOOL gapBetweenButtons;
    
    /// questionSelectView:buttonUnselected:
    BOOL buttonUnselected;
    
    /// questionSelectView:buttonSelected:
    BOOL buttonSelected;
    
} QuestionSelectViewDelegateFlags;

//MARK: QuestionSelectViewDataSource

typedef struct {
    
    /// questionSelectView:buttonAtIndex:
    unsigned int buttonAtIndex : 1;
    
} QuestionSelectViewDataSourceFlags;

#pragma mark - QuestionSelectView ()

@interface QuestionSelectView ()

/// 问题反馈的button
@property (nonatomic, copy) NSArray <__kindof QuestionButton *> *buttons;

/// 被选中的button
@property (nonatomic, nullable, weak) QuestionButton *selectedButton;

/// DelegateFlags
@property (nonatomic) QuestionSelectViewDelegateFlags delegateFlags;

/// DataSourceFlags
@property (nonatomic) QuestionSelectViewDataSourceFlags dataSourceFlags;

/// button间间距
@property (nonatomic) CGFloat gap;

/// 是否已经布局
@property (nonatomic) BOOL isLay;

@end

#pragma mark - QuestionSelectView

@implementation QuestionSelectView

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self QuestionSelectView_initializer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self QuestionSelectView_initializer];
    }
    return self;
}

- (void)QuestionSelectView_initializer {
    self.selectedButton = nil;
    self.gap = 0;
    self.isLay = NO;
}

#pragma mark - Method

- (void)removeSubviews {
    for (UIView *view in self.buttons) {
        [view removeFromSuperview];
    }
    self.buttons = nil;
}

//MARK: SEL

- (void)btnSelected:(QuestionButton *)btn {
    if (btn == self.selectedButton) {
        return;
    }
    btn.selected = YES;
    // 设置被选中状态
    if (self.delegateFlags.buttonSelected) {
        [self.delegate questionSelectView:self buttonSelected:btn];
    }
    // 如果当前有选中button，则掉用buttonUnselected
    if (self.selectedButton) {
        // 选中状态置于初始化
        self.selectedButton.selected = NO;
        if (self.delegateFlags.buttonUnselected) {
            [self.delegate questionSelectView:self buttonUnselected:self.selectedButton];
        }
    }
    self.selectedButton = btn;
    // 告知被选中代理
    if (self.delegate) {
        [self.delegate questionSelectView:self selectedButtonAtIndex:btn.target];
    }
}


#pragma mark - Handle Delegate

- (void)handleQuestionSelectViewDataSource {
    // 创建并初始化布局
    [self removeSubviews];
    NSMutableArray <__kindof QuestionButton *> *btnMA = NSMutableArray.array;
    NSUInteger count = [self.dataSourse numberOfButtonsInQuestionSelectView:self];
    
    for (NSUInteger i = 0; i < count; i++) {
        QuestionButton *btn = nil;
        if (self.dataSourceFlags.buttonAtIndex) {
            // Source
            btn = [self.dataSourse questionSelectView:self buttonAtIndex:i];
            btn.target = i;
            [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
            [btnMA addObject:btn];
            
            [self addSubview:btn];
        }
    }
    self.buttons = [btnMA copy];
    
    // default UI
    for (NSUInteger i = 0; i < count; i++) {
        UIView *btn = self.buttons[i];
        // UI
        btn.top = 0;
        btn.height = self.height;
        if (i == 0) {
            btn.left = 0;
        } else {
            btn.left = self.buttons[i - 1].right;
        }
    }
}

- (void)handleQuestionSelectViewDelegate {
    if (self.buttons == nil || self.isLay == YES) {
        return;
    }
    // 计算可执行范围，如果超出，gap会自动为最大可执行范围
    CGFloat btnWidthCount = 0;
    for (QuestionButton *view in self.buttons) {
        btnWidthCount += view.width;
    }
    NSLog(@"%f - %f", btnWidthCount, self.width);
    if ((btnWidthCount + self.gap * (self.buttons.count - 1)) > self.width) {
        self.gap = (self.width - btnWidthCount) / (self.buttons.count - 1);
    }
    // 自动布局，算法：已知n个view的原始宽度和它们之间间距，给定一个宽度，让它们宽度自动拉伸
    CGFloat proportion = self.width / (btnWidthCount + self.gap * (self.buttons.count - 1));
    NSLog(@"%f", proportion);
    for (NSUInteger i = 0; i < self.buttons.count; i++) {
        self.buttons[i].width *= proportion;
        if (i != 0) {
            self.buttons[i].left = self.buttons[i - 1].right + self.gap;
        }
    }
    self.isLay = YES;
}

#pragma mark - Setter

- (void)setDelegate:(id<QuestionSelectViewDelegate>)delegate {
    _delegate = delegate;
    
    [self set_QuestionSelectViewDelegate];
    
    if (self.delegateFlags.gapBetweenButtons) {
        self.gap = [self.delegate gapBetweenButtonsAtQuestionSelectView:self];
    }
    
    if (self.dataSourse) {
        [self handleQuestionSelectViewDelegate];
    }
}

- (void)set_QuestionSelectViewDelegate {
    self->_delegateFlags.gapBetweenButtons = [self.delegate respondsToSelector:@selector(gapBetweenButtonsAtQuestionSelectView:)];
    self->_delegateFlags.buttonUnselected = [self.delegate respondsToSelector:@selector(questionSelectView:buttonUnselected:)];
    self->_delegateFlags.buttonSelected = [self.delegate respondsToSelector:@selector(questionSelectView:buttonSelected:)];
}

- (void)setDataSourse:(id<QuestionSelectViewDataSource>)dataSourse {
    _dataSourse = dataSourse;
    
    [self set_QuestionSelectViewDataSource];
    
    if (self.delegate) {
        [self handleQuestionSelectViewDataSource];
    }
}

- (void)set_QuestionSelectViewDataSource {
    self->_dataSourceFlags.buttonAtIndex = 1;
}

@end
