//
//  FeedBackSelectView.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/3/30.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "FeedBackSelectView.h"

@implementation FeedBackSelectView

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    self.dataSourse = self;
    self.delegate = self;
}

#pragma mark - <QuestionSelectViewDelegate>

- (void)questionSelectView:(QuestionSelectView *)view selectedButtonAtIndex:(NSUInteger)index {
    // ----- 单击实现(不做UI处理) -----
}

- (CGFloat)gapBetweenButtonsAtQuestionSelectView:(QuestionSelectView *)view {
    return 5;
}

#pragma mark - <QuestionSelectViewDataSource>

- (NSUInteger)numberOfButtonsInQuestionSelectView:(QuestionSelectView *)view {
    return 4;
}

- (__kindof QuestionButton *)questionSelectView:(QuestionSelectView *)view buttonAtIndex:(NSUInteger)index {
    FeedBackQuestionButton *btn = [[FeedBackQuestionButton alloc] init];
    switch (index) {
        case 0: {
            btn.title = @"意见建议";
            return btn;
        }
        case 1: {
            btn.title = @"系统问题";
            return btn;
        }
        case 2: {
            btn.title = @"账号问题";
            return btn;
        }
        case 3: {
            btn.title = @"其他";
            return btn;
        }
        default:return nil;
    }
    return nil;
}

- (void)questionSelectView:(QuestionSelectView *)view buttonSelected:(QuestionButton *)btn {
    [(FeedBackQuestionButton *)btn setHighLightStyle];
}

- (void)questionSelectView:(QuestionSelectView *)view buttonUnselected:(QuestionButton *)btn {
    [(FeedBackQuestionButton *)btn setNormalStyle];
}

@end
