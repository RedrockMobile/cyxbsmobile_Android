//
//  RemindTableViewCell.m
//  Demo
//
//  Created by 李展 on 2016/11/26.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "RemindTableViewCell.h"
#import "UIFont+AdaptiveFont.h"
@implementation RemindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.tintColor = [UIColor colorWithRed:65/255.f green:163/255.f blue:255/255.f alpha:1];
    self.titleLabel.font = [UIFont adaptFontSize:14];
    self.contentLabel.font = [UIFont adaptFontSize:14];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
