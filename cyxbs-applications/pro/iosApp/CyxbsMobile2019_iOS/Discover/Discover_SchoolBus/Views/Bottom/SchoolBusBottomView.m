//
//  SchoolBusBottomView.m
//  CyxbsMobile2019_iOS
//
//  Created by Clutch Powers on 2022/4/7.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SchoolBusBottomView.h"
#import "StationsCollectionViewCell.h"


#pragma mark - SchoolBusBottomView ()

@interface SchoolBusBottomView ()

@property (nonatomic, strong) NSArray <UIButton *> *busBtnAry;
@property (nonatomic, strong) NSArray <UILabel *> *lineLabelAry;
@property (nonatomic, copy) NSArray <NSString *> *defaultImgAry;
@property (nonatomic, copy) NSArray <NSString *> *selectedImgAry;

@property (nonatomic, weak) UIButton *selectedBtn;

@end

#pragma mark - SchoolBusBottomView

@implementation SchoolBusBottomView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
        self.layer.cornerRadius = 16;
        [self addBusbtn];
        [self addLineLabelAry];
        [self addDragHintView];
        [self addSubview:self.titleLabel];
        [self addGesture];
        self.selectedBtn = self.busBtnAry[0];
    }
    return self;
}
- (void)addGesture {
    UISwipeGestureRecognizer *recognizerDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(withdrawBottomView)];
    [recognizerDown setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self addGestureRecognizer:recognizerDown];
    UISwipeGestureRecognizer *recognizerUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(popBottomView)];
        [recognizerUp setDirection:(UISwipeGestureRecognizerDirectionUp)];
        [self addGestureRecognizer:recognizerUp];
}
/// 添加提示可拖拽的条
- (void)addDragHintView{
    UIView *dragHintView = [[UIView alloc]init];
    [self addSubview:dragHintView];
        dragHintView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E8F0FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    dragHintView.layer.cornerRadius = 2.5;
    [dragHintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@36);
        make.height.equalTo(@5);
        make.top.equalTo(self).offset(8);
        make.centerX.equalTo(self);
    }];
}

#pragma mark - Method

// MARK: SEL
- (void)withdrawBottomView {
    self.selectedBtn.selected = !self.selectedBtn.selected;
    if (self.delegate) {
        [self.delegate schoolBusView:self didSelectedBtnWithIndex:self.selectedBtn.tag AndisSelected: !self.selectedBtn.selected];
    }
}
- (void)popBottomView {
    self.selectedBtn.selected = !self.selectedBtn.selected;
    if (self.delegate) {
        [self.delegate schoolBusView:self didSelectedBtnWithIndex:self.selectedBtn.tag AndisSelected: !self.selectedBtn.selected];
    }
}
- (void)selectedBusLineBtn:(UIButton *)btn {
    [self busButtonControllerWithBtnTag:btn.tag];
}
- (void)busButtonControllerWithBtnTag:(NSUInteger )tag  {
    //tag对应的button在数组中的位置
    NSUInteger realpos = (tag-1+self.busBtnAry.count) % self.busBtnAry.count;
    if (self.selectedBtn.selected == NO && tag == self.selectedBtn.tag) {
        self.selectedBtn.selected = !self.selectedBtn.selected;
    }
    else if (tag != self.selectedBtn.tag) {
        self.selectedBtn.selected = NO;
        self.busBtnAry[realpos].selected = YES;
    }
    else {
        self.busBtnAry[realpos].selected = !self.busBtnAry[realpos].selected;
    }
    //tag==0:乘车指南按钮
    if (tag != 0) {
        self.selectedBtn = self.busBtnAry[realpos];
    }
    if (self.delegate) {
        [self.delegate schoolBusView:self didSelectedBtnWithIndex:tag AndisSelected: !self.selectedBtn.selected];
    }
}
#pragma mark - Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 109, 200, 31)];
    }
    return _titleLabel;
}

- (void)addBusbtn {
    if (_busBtnAry == nil) {
        NSMutableArray <UIButton *> *MAry = NSMutableArray.array;
        NSUInteger count = self.defaultImgAry.count;
        for (NSUInteger i = 0; i < count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth * ((i) % count) / count + kScreenWidth * 19 / 375, 28, 36, 36)];
            btn.tag = (i + 1) % 5;
            [btn setImage:[UIImage imageNamed:self.defaultImgAry[i]] forState:0];
            if (i < count-1) {
                [btn setImage:[UIImage imageNamed:self.selectedImgAry[i]] forState:UIControlStateSelected];
            }
            [btn setImage:[UIImage imageNamed:self.defaultImgAry[i]] forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(selectedBusLineBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [MAry addObject:btn];
        }
        _busBtnAry = MAry.copy;
    }
    return;
}
- (void)addLineLabelAry {
    if (!_lineLabelAry) {
        for (int i = 0; i < 5; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 14)];
            label.textAlignment = NSTextAlignmentCenter;
            label.centerX = self.busBtnAry[i].centerX;
            label.top = self.busBtnAry[i].bottom + 9;
            NSString *str = @"";
            if (i < 4) {
                label.text = [str stringByAppendingFormat: @"%d号线", i+1];
            }else{
                label.text = @"乘车指南";
            }
            label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#94A6C4" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
            label.font = [UIFont fontWithName:PingFangSCLight size:10];
            [self addSubview:label];
        }
    }
    return;
}
- (NSArray<NSString *> *)defaultImgAry {
    if (_defaultImgAry == nil) {
        _defaultImgAry = @[
            @"PinkBus",
            @"OrangeBus",
            @"BlueBus",
            @"GreenBus",
            @"Compass"
        ];
    }
    return _defaultImgAry;
}
- (NSArray<NSString *> *)selectedImgAry {
    if (_selectedImgAry == nil) {
        _selectedImgAry = @[
            @"PinkBus_Click",
            @"OrangeBus_Click",
            @"BlueBus_Click",
            @"GreenBus_Click",
            @"Compass_Click"
        ];
    }
    return _selectedImgAry;
}

@end
