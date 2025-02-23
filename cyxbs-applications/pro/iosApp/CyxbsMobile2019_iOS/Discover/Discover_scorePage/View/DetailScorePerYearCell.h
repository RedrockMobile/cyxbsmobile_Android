//
//  DetailScorePerYearCell.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/2/13.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleGrade.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailScorePerYearCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak)UILabel *timeLabel;//2018-2019第一学年
@property (nonatomic, weak)UIView *blueBackgroundView;//淡蓝色背景

@property (nonatomic, weak)UILabel *averangePointLabel;//平均绩点
@property (nonatomic, weak)UILabel *averangePointTitleLabel;//"平均绩点"

@property (nonatomic, weak)UILabel *averangeScoreLabel;//平均成绩
@property (nonatomic, weak)UILabel *averangeScoreTitleLabel;//"平均成绩"

@property (nonatomic, weak)UILabel *averangeRankLabel;//平均排名
@property (nonatomic, weak)UILabel *averangeRankTitleLabel;//平均排名

@property (nonatomic, weak)UIButton *watchMoreButton;//“查看各科成绩”

@property(nonatomic, weak)UITableView *detailTableView;//“具体学科成绩”
@property (nonatomic)NSArray<SingleGrade*> *singleGradesArray;//每个cell持有一份singleGrade数据，用来驱动内部的tableView

@property (nonatomic)BOOL tableViewIsOpen;//tableView展开

//@property (nonatomic, assign)float plainHeight;//cell不展开时候的高度
@property (nonatomic, assign)float openingHeight;//cell展开时的高度

@property (nonatomic, assign)float subjectCellHeight;//具体学科的cell高度

//@property (nonatomic, assign)float tableViewOpeningHeight;//table
/// cell不展开时的高度
+(float)plainHeight;

@end

NS_ASSUME_NONNULL_END
