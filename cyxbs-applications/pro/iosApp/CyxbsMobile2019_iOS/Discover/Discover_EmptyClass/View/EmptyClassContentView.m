//
//  EmptyClassContentView.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/19.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "EmptyClassContentView.h"

@interface EmptyClassContentView ()

/// 返回按钮
@property (nonatomic, weak) UIButton *backButton;

@property (nonatomic, weak) UIView *bottomView;

@end

@implementation EmptyClassContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#EEF2F7" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
        } else {
            self.backgroundColor = [UIColor colorWithRed:242/255.0 green:243/255.0 blue:248/255.0 alpha:1];
        }
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [backButton setImage:[UIImage imageNamed:@"空教室返回"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        self.backButton = backButton;
        
        UIScrollView *weekScrollView = [[UIScrollView alloc] init];
        weekScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:weekScrollView];
        self.weekScrollView = weekScrollView;
        
        
        NSArray *weekArray = @[@"第一周", @"第二周", @"第三周", @"第四周", @"第五周", @"第六周", @"第七周", @"第八周", @"第九周", @"第十周", @"第十一周", @"第十二周", @"第十三周", @"第十四周", @"第十五周", @"第十六周", @"第十七周", @"第十八周", @"第十九周", @"第二十周", @"第二十一周", @"第二十二周", @"第二十三周", @"第二十四周", @"第二十五周"];

        NSMutableArray *weekTmpArray = [NSMutableArray array];
        for (int i = 0; i < weekArray.count; i++) {
            UIButton *weekButton = [[UIButton alloc] init];
            if (@available(iOS 11.0, *)) {
                [weekButton setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C53" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF2" alpha:1]] forState:UIControlStateNormal];
            } else {
                [weekButton setTitleColor:[UIColor colorWithRed:18/255.0 green:45/255.0 blue:85/255.0 alpha:1] forState:UIControlStateNormal];
            }
            [weekButton setTitle:weekArray[i] forState:UIControlStateNormal];
            weekButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [weekButton addTarget:self action:@selector(weekButtonChoosed:) forControlEvents:UIControlEventTouchUpInside];
            weekButton.tag = i + 1;
            [self.weekScrollView addSubview:weekButton];
            [weekTmpArray addObject:weekButton];
        }
        self.weekButtonArray = weekTmpArray;

        
        NSArray *weekDayArray = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
        
        NSMutableArray *weekdayTmpArray = [NSMutableArray array];
        for (int i = 0; i < weekDayArray.count; i++) {
            UIButton *weekdayButton = [[UIButton alloc] init];
            if (@available(iOS 11.0, *)) {
                [weekdayButton setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C53" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF2" alpha:1]] forState:UIControlStateNormal];
            } else {
                [weekdayButton setTitleColor:[UIColor colorWithRed:18/255.0 green:45/255.0 blue:85/255.0 alpha:1] forState:UIControlStateNormal];
            }
            [weekdayButton setTitle:weekDayArray[i] forState:UIControlStateNormal];
            weekdayButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [weekdayButton addTarget:self action:@selector(weekdayButtonChoosed:) forControlEvents:UIControlEventTouchUpInside];
            weekdayButton.tag = i + 1;
            [self addSubview:weekdayButton];
            [weekdayTmpArray addObject:weekdayButton];
        }
        self.weekDayButtonArray = weekdayTmpArray;
        
        
        UITableView *resultTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            resultTableView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F7F8FB" alpha:1] darkColor:[UIColor colorWithHexString:@"#0F0F0F" alpha:1]];
        } else {
            resultTableView.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:252/255.0 alpha:1];
        }
        resultTableView.showsVerticalScrollIndicator = NO;
        resultTableView.layer.cornerRadius = 16;
        resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        resultTableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
        [self addSubview:resultTableView];
        self.resultTable = resultTableView;
        
        
        UIView *bottomView = [[UIView alloc] init];
        if (@available(iOS 11.0, *)) {
            bottomView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#1E1E1E" alpha:1]];
        } else {
            bottomView.backgroundColor = [UIColor whiteColor];
        }
        bottomView.layer.cornerRadius = 16;
        [self addSubview:bottomView];
        self.bottomView = bottomView;
        
        
        NSArray *classesArray = @[@"1-2", @"3-4", @"5-6", @"7-8", @"9-10", @"11-12"];
        NSMutableArray *classTmpArray = [NSMutableArray array];
        for (int i = 0; i < classesArray.count; i++) {
            UIButton * classButton = [[UIButton alloc] init];
            if (@available(iOS 11.0, *)) {
                [classButton setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C53" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF2" alpha:1]] forState:UIControlStateNormal];
            } else {
                [classButton setTitleColor:[UIColor colorWithRed:17/255.0 green:44/255.0 blue:84/255.0 alpha:1] forState:UIControlStateNormal];
            }
            [classButton setTitle:classesArray[i] forState:UIControlStateNormal];
            classButton.titleLabel.font = [UIFont systemFontOfSize:15];
            classButton.tag = i;
            [classButton addTarget:self action:@selector(classButtonChoosed:) forControlEvents:UIControlEventTouchDown];
            [self addSubview:classButton];
            [classTmpArray addObject:classButton];
        }
        self.classButtonArray = classTmpArray;
        
        
        NSArray *buildingArray = @[@"二教", @"三教", @"四教", @"五教", @"八教"];
        NSMutableArray *buildingTmpArray = [NSMutableArray array];
        for (int i = 0; i < buildingArray.count; i++) {
            UIButton * buidingButton = [[UIButton alloc] init];
            if (@available(iOS 11.0, *)) {
                [buidingButton setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C53" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF2" alpha:1]] forState:UIControlStateNormal];
            } else {
                [buidingButton setTitleColor:[UIColor colorWithRed:17/255.0 green:44/255.0 blue:84/255.0 alpha:1] forState:UIControlStateNormal];
            }
            [buidingButton setTitle:buildingArray[i] forState:UIControlStateNormal];
            buidingButton.titleLabel.font = [UIFont systemFontOfSize:15];
            switch (i) {
                case 0:
                    buidingButton.tag = 2;
                    break;
                    
                case 1:
                    buidingButton.tag = 3;
                    break;
                
                case 2:
                    buidingButton.tag = 4;
                    break;
                    
                case 3:
                    buidingButton.tag = 5;
                    break;
                    
                case 4:
                    buidingButton.tag = 8;
                    break;
                    
                default:
                    break;
            }
            [buidingButton addTarget:self action:@selector(buildingButtonChoosed:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:buidingButton];
            [buildingTmpArray addObject:buidingButton];
        }
        self.buildingButtonArray = buildingTmpArray;
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(17);
        make.top.equalTo(self).offset(STATUSBARHEIGHT + 13);
        make.height.width.equalTo(@19);
    }];
    
    // 选择周数按钮的约束
    for (int i = 0; i < self.weekButtonArray.count; i++) {
        [self.weekButtonArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.leading.equalTo(self.weekScrollView);
            } else {
                make.leading.equalTo(self.weekButtonArray[i - 1].mas_trailing).offset(5);
            }
            make.top.equalTo(self.backButton).offset(-5);
            make.bottom.equalTo(self.backButton).offset(5);
            make.width.equalTo(self.weekButtonArray[i].titleLabel.mas_width).offset(20);
        }];
        self.weekButtonArray[i].layer.cornerRadius = self.weekButtonArray[i].height / 2.0;
    }
    
    [self.weekScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backButton).offset(-4);
        make.bottom.equalTo(self.backButton).offset(4);
        make.leading.equalTo(self.backButton.mas_trailing);
        make.width.equalTo(self).offset(-57);
        make.trailing.equalTo(self.weekButtonArray[self.weekButtonArray.count - 1]).offset(13);
    }];
    
    // 选择星期的按钮的约束
    CGFloat weekdayButtonWidth = (MAIN_SCREEN_W - 36 - 13) / 7.0;  // 按钮宽度,(屏幕宽度 - leading - trailing) / 7个按钮
    for (int i = 0; i < self.weekDayButtonArray.count; i++) {
        [self.weekDayButtonArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.leading.equalTo(self.weekScrollView);
            } else {
                make.leading.equalTo(self.weekDayButtonArray[i - 1].mas_trailing);
            }
            make.top.equalTo(self.weekScrollView.mas_bottom).offset(17);
            make.height.equalTo(self.weekButtonArray[0].mas_height);
            make.width.equalTo(@(weekdayButtonWidth));
        }];
        self.weekDayButtonArray[i].layer.cornerRadius = self.weekDayButtonArray[i].height / 2.0;
    }
    
    [self.resultTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(self.weekDayButtonArray[0].mas_bottom).offset(12);
    }];
    
    if (IS_IPHONEX) {
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.height.equalTo(@104);
            make.bottom.equalTo(self).offset(16);       // 隐藏下圆角
        }];
    } else {
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.height.equalTo(@89);
            make.bottom.equalTo(self).offset(16);       // 隐藏下圆角
        }];
    }
    
    // 选择课程时段按钮的约束
    CGFloat classButtonWidth = (MAIN_SCREEN_W - 16 - 16) / 6.0;  // 按钮宽度,(屏幕宽度 - leading - trailing) / 7个按钮
    for (int i = 0; i < self.classButtonArray.count; i++) {
        [self.classButtonArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.leading.equalTo(self).offset(11 + 5);
            } else {
                make.leading.equalTo(self.classButtonArray[i - 1].mas_trailing).offset(5);
            }
            make.top.equalTo(self.bottomView).offset(10);
            make.height.equalTo(self.weekButtonArray[0]).offset(-2);
            make.width.equalTo(@(classButtonWidth - 5));
        }];
        self.classButtonArray[i].layer.cornerRadius = self.classButtonArray[i].height / 2.0;
    }
    
    // 选择教学楼按钮的约束
    CGFloat builindButtonWidth = (MAIN_SCREEN_W - 16 - 16) / 5.0;
    for (int i = 0; i < self.buildingButtonArray.count; i++) {
        [self.buildingButtonArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.leading.equalTo(self.bottomView).offset(11 + 15);
            } else {
                make.leading.equalTo(self.buildingButtonArray[i - 1].mas_trailing).offset(20);
            }
            make.top.equalTo(self.classButtonArray[0].mas_bottom).offset(4);
            make.height.equalTo(self.weekButtonArray[0]).offset(-2);
            make.width.equalTo(@(builindButtonWidth - 20));
        }];
        self.buildingButtonArray[i].layer.cornerRadius = self.buildingButtonArray[i].height / 2.0;
    }
}

#pragma mark - 按钮
- (void)backButtonClicked {
    if ([self.delegate respondsToSelector:@selector(backButtonClicked)]) {
        [self.delegate backButtonClicked];
    }
}

- (void)weekButtonChoosed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(weekButtonChoosed:)]) {
        [self.delegate weekButtonChoosed:sender];
    }
}

- (void)weekdayButtonChoosed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(weekdayButtonChoosed:)]) {
        [self.delegate weekdayButtonChoosed:sender];
    }
}

- (void)classButtonChoosed:(UIButton *)sender {    if ([self.delegate respondsToSelector:@selector(classButtonChoosed:)]) {
        [self.delegate classButtonChoosed:sender];
    }
}

- (void)buildingButtonChoosed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(buildingButtonChoosed:)]) {
        [self.delegate buildingButtonChoosed:sender];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    for (int i = 0; i < self.classButtonArray.count; i++) {
        CGPoint convertedPoint = [self convertPoint:point toView:self.classButtonArray[i]];
        if (CGRectContainsPoint(self.classButtonArray[i].bounds, convertedPoint)) {
            view = self.classButtonArray[i];
            break;
        }
    }
    
    return view;
}

@end
