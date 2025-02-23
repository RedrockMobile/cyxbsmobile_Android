//
//  DetailScorePerYearCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/2/13.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DetailScorePerYearCell.h"
#import "DetailSubjectScoreCell.h"

@interface DetailScorePerYearCell()
@end
@implementation DetailScorePerYearCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (float)plainHeight {
    return 144;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        self.tableViewIsOpen = NO;
        self.layer.cornerRadius = 8;
//        self.clipsToBounds = YES;
        self.subjectCellHeight = 35;//具体学科的cell高度
        [self addTimeLabel];
        [self addBlueBackgroundView];
        [self addAverangePointLabel];
        [self addAverangePointTitleLabel];
        [self addAverangeScoreLabel];
        [self addAverangeScoreTitleLabel];
        [self addAverangeRankLabel];
        [self addAverangeRankTitleLabel];
        [self addWatchMoreButton];
    }
    return self;
}
- (void)addTimeLabel {
    UILabel *label = [[UILabel alloc]init];
    self.timeLabel = label;
    label.font = [UIFont fontWithName:PingFangSCSemibold size:15];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    label.text = @"2018-2019第二学年";
    [self.contentView addSubview:label];
}
- (void) addBlueBackgroundView {
    UIView *backView = [[UIView alloc]init];
    self.blueBackgroundView = backView;
    if (@available(iOS 11.0, *)) {
        backView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E8F1FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#5A5A5A" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    [self addSubview:self.blueBackgroundView];
}
- (void) addAverangePointLabel {
        UILabel *averangePointLabel = [[UILabel alloc]init];
        self.averangePointLabel = averangePointLabel;
        averangePointLabel.font = [UIFont fontWithName:PingFangSCSemibold size:21];
        if (@available(iOS 11.0, *)) {
            averangePointLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        averangePointLabel.text = @"3.4";
        [self.blueBackgroundView addSubview:averangePointLabel];
}
- (void) addAverangePointTitleLabel {
    UILabel *label = [[UILabel alloc]init];
    self.averangePointTitleLabel = label;
    label.font = [UIFont fontWithName:PingFangSCRegular size:11];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    label.text = @"平均绩点";
    [self.blueBackgroundView addSubview:label];
}
- (void) addAverangeScoreLabel {
        UILabel *label = [[UILabel alloc]init];
        self.averangeScoreLabel = label;
        label.font = [UIFont fontWithName:PingFangSCSemibold size:21];
        if (@available(iOS 11.0, *)) {
            label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        label.text = @"98";
        [self.blueBackgroundView addSubview:label];
}
- (void)addAverangeScoreTitleLabel {
    UILabel *label = [[UILabel alloc]init];
    self.averangeScoreTitleLabel = label;
    label.font = [UIFont fontWithName:PingFangSCRegular size:11];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    label.text = @"平均成绩";
    [self.blueBackgroundView addSubview:label];
}
- (void)addAverangeRankLabel {
    UILabel *label = [[UILabel alloc]init];
    self.averangeRankLabel = label;
    label.font = [UIFont fontWithName:PingFangSCSemibold size:21];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    label.text = @"96";
    [self.blueBackgroundView addSubview:label];
}
- (void) addAverangeRankTitleLabel {
    UILabel *label = [[UILabel alloc]init];
    self.averangeRankTitleLabel = label;
    label.font = [UIFont fontWithName:PingFangSCRegular size:11];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    label.text = @"平均排名";
    [self.blueBackgroundView addSubview:label];
}
- (void)addWatchMoreButton {
    UIButton *button = [[UIButton alloc]init];
    self.watchMoreButton = button;
    [button.titleLabel setFont:[UIFont fontWithName:PingFangSCRegular size:11]];
    button.alpha = 0.35;
    if (@available(iOS 11.0, *)) {
        [button setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]] forState:normal];
    } else {
        // Fallback on earlier versions
    }
    button.backgroundColor = UIColor.clearColor;
    [button setTitle:@"查看各科成绩" forState:normal];
    [self.blueBackgroundView addSubview:button];
    [button addTarget:self action:@selector(touchWatchMoreButton) forControlEvents:UIControlEventTouchUpInside];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.blueBackgroundView.width,1) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.clearColor;
    self.detailTableView = tableView;
    [tableView setUserInteractionEnabled:NO];
    tableView.delegate = self;
    tableView.clipsToBounds = NO;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [tableView setHidden:YES];
    [self.blueBackgroundView addSubview:tableView];
}
-(void)touchWatchMoreButton {
    [self.detailTableView setHidden:NO];
    self.tableViewIsOpen = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"expandSubjectScoreTableView" object:nil];//发送消息 刷新该cell高度
    NSNumber *cellHeight = @(self.subjectCellHeight*self.singleGradesArray.count);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"expandSubjectScoreTableView" object:nil userInfo:@{@"cellHeight":cellHeight}];
    [self.watchMoreButton setTitle:@"收起各科成绩" forState:normal];
    [self.watchMoreButton removeAllTargets];
    [self.watchMoreButton addTarget:self action:@selector(mergeScoreMore) forControlEvents:UIControlEventTouchUpInside];
//    self.height = self.subjectCellHeight*self.singleGradesArray.count+[DetailScorePerYearCell plainHeight];
    [self layoutSubviews];
//    [self.blueBackgroundView bringSubviewToFront:self.watchMoreButton];
}
-(void)mergeScoreMore {
    [self.detailTableView setHidden:YES];
    self.tableViewIsOpen = NO;
    NSNumber *cellHeight = @(self.subjectCellHeight*self.singleGradesArray.count);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"contractSubjectScoreTableView" object:nil userInfo:@{@"cellHeight":cellHeight}];

    [self.watchMoreButton setTitle:@"查看各科成绩" forState:normal];
    [self.watchMoreButton removeAllTargets];
    [self.watchMoreButton addTarget:self action:@selector(touchWatchMoreButton) forControlEvents:UIControlEventTouchUpInside];
//    [UIView animateWithDuration:0.5 animations:^{
//        [self.detailTableView removeFromSuperview];
//    }];
    self.height = [self.class plainHeight];
    [self layoutSubviews];
//    [self.blueBackgroundView bringSubviewToFront:self.watchMoreButton];

    

}
//MARK:  tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.singleGradesArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailSubjectScoreCell*cell = [[DetailSubjectScoreCell alloc]init];
    cell.nameLabel.text = self.singleGradesArray[indexPath.row].class_name;
    cell.scoreLabel.text = self.singleGradesArray[indexPath.row].grade;
    cell.majorLabel.text = self.singleGradesArray[indexPath.row].class_type;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.subjectCellHeight;
}
//MARK: layoutSubviews
- (void)layoutSubviews {
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(self).offset(28);
        make.top.equalTo(self).offset(15);
    }];
    [self.blueBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(9);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
//        make.height.equalTo(@99);
        make.bottom.equalTo(self.watchMoreButton).offset(5);
    }];
    [self.averangePointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.blueBackgroundView).offset(28);
        make.centerX.equalTo(self.averangePointTitleLabel);
        make.top.equalTo(self.blueBackgroundView).offset(16);
    }];
    [self.averangePointTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blueBackgroundView).offset(28);
//        make.centerX.equalTo(self.averangePointLabel);
        make.top.equalTo(self.averangePointLabel.mas_bottom).offset(0.68);
        make.height.equalTo(@12);
    }];
    [self.averangeScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.blueBackgroundView);
        make.centerY.equalTo(self.averangePointLabel);
    }];
    [self.averangeScoreTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.averangeScoreLabel);
        make.top.equalTo(self.averangeScoreLabel.mas_bottom).offset(0.68);
        make.height.equalTo(@12);

    }];
    [self.averangeRankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.blueBackgroundView).offset(-29);
        make.top.equalTo(self.averangePointLabel);
    }];
    [self.averangeRankTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.averangeRankLabel);
        make.top.equalTo(self.averangeRankLabel.mas_bottom).offset(0.68);
        make.height.equalTo(@12);

    }];
    if(self.tableViewIsOpen) {
        [self.watchMoreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.averangeScoreLabel);
            make.bottom.equalTo(self).offset(-5);
            make.height.equalTo(@22);
            }];
    }else {
        [self.watchMoreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.averangeScoreLabel);
            make.top.equalTo(self.detailTableView).offset(5);
            make.height.equalTo(@22);
    //        make.bottom.equalTo(self.blueBackgroundView.mas_bottom).offset(-6);
    //        make.bottom.equalTo(self.detailTableView.mas_bottom).offset(-15);
        }];
    }
    [self.watchMoreButton.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.watchMoreButton).offset(0);
    }];
    [self.detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.averangeScoreTitleLabel.mas_bottom).offset(0);
        make.left.right.equalTo(self.blueBackgroundView);
        make.height.equalTo(@(self.subjectCellHeight*self.singleGradesArray.count));
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.blueBackgroundView).offset(5);
    }];
}
@end
 
