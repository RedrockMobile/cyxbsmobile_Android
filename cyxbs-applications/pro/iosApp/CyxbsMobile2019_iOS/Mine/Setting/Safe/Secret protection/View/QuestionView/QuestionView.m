//
//  QuestionView.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/28.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "QuestionView.h"
#import "questionModel.h"



@interface QuestionView()
@property (nonatomic, strong) questionModel *model;
///数据源数组
@property (nonatomic, strong) NSMutableArray *questionArray;

@end

@implementation QuestionView

NSString *ID1 = @"Sport_cell";

- (instancetype) initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 16;
        
        ///背景蒙版
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        backView.backgroundColor = [UIColor colorWithRed:0/255.0 green:15/255.0 blue:37/255.0 alpha:0.14];
        backView.userInteractionEnabled = YES;
        [self addSubview:backView];
        _backView = backView;
        
        ///问题列表
        UITableView *questionTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        questionTableView.layer.cornerRadius = 16;
        if (@available(iOS 11.0, *)) {
            questionTableView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        questionTableView.separatorColor = [UIColor clearColor];
        questionTableView.rowHeight = 61;
        questionTableView.scrollEnabled = YES;
        questionTableView.tableHeaderView = [self setTableHeaderView];
        questionTableView.dataSource = self;
        questionTableView.delegate = self;
        [self addSubview:questionTableView];
        _questionTableView = questionTableView;
    
        [_questionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(SCREEN_HEIGHT * 0.4852);
            make.left.right.bottom.mas_equalTo(self);
        }];
        
        NSString *question = [[NSString alloc] init];
        _question = question;
        
        _questionArray = [[NSMutableArray alloc] init];
        [self setQeustionList];
        
    }
    return self;
}

///设置问题列表
- (void)setQeustionList{
    questionModel *model = [[questionModel alloc] init];
    [model loadQuestionList];
    
    [model setBlock:^(id  _Nonnull info) {
        NSArray *dataArray = info[@"data"];
        for (NSDictionary *dic in dataArray) {
            questionItem *item = [[questionItem alloc] initWithDict:dic];
            [self->_questionArray addObject:item];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_questionTableView reloadData];
        });
    }];
}

- (UIView *)setTableHeaderView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.4852, SCREEN_WIDTH, SCREEN_HEIGHT * 0.066)];
    topView.clipsToBounds = YES;
    topView.backgroundColor = [UIColor clearColor];
    
    ///头视图分割线
    UIView *lineView = [[UIView alloc] init];
    if (@available(iOS 11.0, *)) {
        lineView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    lineView.alpha = 0.04;
    [topView addSubview:lineView];
    
    ///头视图文字
    UILabel *placeholder = [[UILabel alloc] init];
    placeholder.text = @"选择一个密保问题";
    if (@available(iOS 11.0, *)) {
        placeholder.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    placeholder.alpha = 0.61;
    placeholder.font = [UIFont fontWithName:PingFangSCRegular size: 13*fontSizeScaleRate_SE];
    [topView addSubview:placeholder];
    
    [placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).mas_offset(SCREEN_HEIGHT * 0.0197);
        make.left.mas_equalTo(topView.mas_left).mas_offset(SCREEN_WIDTH * 0.048);
        make.right.mas_equalTo(topView.mas_right);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0431);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).mas_offset(SCREEN_HEIGHT * 0.064);
        make.left.mas_equalTo(topView.mas_left);
        make.right.mas_equalTo(topView.mas_right);
        make.height.mas_equalTo(3);
    }];
    return topView;
}

///消失动画
- (void)disMissView {
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.0;
        [self removeFromSuperview];
    }completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTitle" object:nil userInfo:nil];
}

///出现动画
- (void)popQuestionView:(UIView *)view {
    if (!view) {
        return;
    }
    [view addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.0;
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    } completion:nil];
}

#pragma mark - questionTableView的代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _questionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建单元格（用复用池）
    static NSString *CellIdentifier = @"Photos";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:PingFangSCMedium size:16*fontSizeScaleRate_SE];
    if (@available(iOS 11.0, *)) {
        cell.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        cell.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    questionItem *model = _questionArray[indexPath.row];
    //展示cell上的数据
    cell.textLabel.text = model.questionContent;
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    questionItem *model = _questionArray[indexPath.row];
    _question = model.questionContent;
    _questionId = model.questionId;
    [self disMissView];
}


@end
    

