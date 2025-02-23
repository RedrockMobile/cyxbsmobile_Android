//
//  PeopleListCellTableViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/29.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "PeopleListCellTableViewCell.h"

@implementation PeopleListCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.imageView setImage:[UIImage imageNamed:@"defaultStudentImage"]];
        if(@available(iOS 11.0,*)){
            self.textLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        }else{
            self.textLabel.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
        }
        self.textLabel.font = [UIFont fontWithName:PingFangSCSemibold size:15];
        if(@available(iOS 11.0, *)){
            self.detailTextLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        }else{
            self.detailTextLabel.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
        }
        self.detailTextLabel.font = [UIFont fontWithName:PingFangSCRegular size:13];
        [self addStuNumLabel];
        [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    }
    return self;
}
-(void) addStuNumLabel {
    UILabel *label = [[UILabel alloc]init];
    [self.contentView addSubview:label];
    self.stuNumLabel = label;
    label.font = [UIFont fontWithName:PingFangSCRegular size:11];
    if(@available(iOS 11.0, *)){
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
    }else{
        label.textColor = [UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1];
    }
}
- (void)layoutSubviews {
    self.imageView.frame = CGRectMake(19, 18, 48, 48);
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(80);
        make.top.equalTo(self).offset(17);
    }];
    [self.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel);
        make.top.equalTo(self.textLabel.mas_bottom).offset(7);
    }];
    [self.stuNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textLabel);
        make.right.equalTo(self).offset(-15);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
