//
//  TimeChooseScrollView.m
//  Demo
//
//  Created by 李展 on 2016/12/8.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "TimeChooseScrollView.h"
#import "TickButton.h"
@interface TimeChooseScrollView()
@property (nonatomic, strong) NSMutableArray <TickButton *> *btnArray;
@property (nonatomic, strong) UIButton *selectedBtn;
@end

@implementation TimeChooseScrollView
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*) titles{
    self.titles = titles.mutableCopy;
    self.btnArray = [NSMutableArray array];
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#fbfbfb"];
        NSInteger count = self.titles.count;
        CGFloat lbHeight = frame.size.height/count;
        CGFloat lbWidth = frame.size.width;
        
        self.contentSize = CGSizeMake(lbWidth, lbHeight*count);
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        for (NSInteger i = 0; i<count; i++) {
            TickButton *btn = [[TickButton alloc] initWithFrame:CGRectMake(0, i*lbHeight, lbWidth, lbHeight-1)];
            UIView *assitView = [[UIView alloc]initWithFrame:CGRectMake(16, (i+1)*lbHeight-1, lbWidth-32, 1)];
            assitView.backgroundColor = [UIColor colorWithHexString:@"#e3e3e3"];
            [btn setTitle:self.titles[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            [self.btnArray addObject:btn];
            [self addSubview:btn];
            [self addSubview:assitView];
        }
    }
    return self;
}

- (void)clickBtn:(TickButton *)sender{
    self.selectedBtn.selected = NO;
    self.selectedBtn = sender;
    sender.selected = YES;
    if ([self.chooseDelegate respondsToSelector:@selector(eventWhenTapAtIndex:)]) {
        [self.chooseDelegate eventWhenTapAtIndex:sender.tag];
    }

}
- (void)tapAtIndex:(NSInteger)index{
    [self clickBtn:self.btnArray[index]];
}

- (NSString *)currenSelectedTitle{
    return self.selectedBtn.currentTitle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
