//
//  DetailsTaskTableViewCell.m
//  Details
//
//  Created by Edioth Jin on 2021/8/6.
//

#import "DetailsTaskTableViewCell.h"

@implementation DetailsTaskTableViewCell

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureView];
    }
    return self;
}

- (void)configureView {
    self.rightTitleLabel.textColor = [UIColor colorWithHexString:@"#FFA92F"];
    self.rightIndicatorHidden = YES;
    self.titleImgHidden = YES;
    self.separatorLineHidden = YES;
}

#pragma mark - setter

- (void)setCellModel:(DetailsTaskModel *)cellModel {
    _cellModel = cellModel;
    self.titleLabel.text = cellModel.task_name;
    self.subtitleLabel.text = getTimeFromTimestampWithDateFormat(cellModel.date, @"YYYY.MM.dd");
    self.rightTitleLabel.text = [NSString stringWithFormat:@"+%zd", cellModel.task_income];
}

@end
