//
//  CQUPTMapSearchResultCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/13.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapSearchResultCell.h"

@interface CQUPTMapSearchResultCell ()

@property (nonatomic, weak) UIImageView *searchImageView;

@end

@implementation CQUPTMapSearchResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *searchImageView = [[UIImageView alloc] init];
        searchImageView.image = [UIImage imageNamed:@"Map_Scope"];
        [self addSubview:searchImageView];
        self.searchImageView = searchImageView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        if (@available(iOS 11.0, *)) {
            titleLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#234780" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF1" alpha:1]];
        } else {
            titleLabel.textColor = [UIColor colorWithHexString:@"#234780"];
        }
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(11);
        make.width.height.equalTo(@15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.searchImageView.mas_trailing).offset(12);
        make.centerY.equalTo(self.searchImageView);
        make.width.equalTo(self).offset(-50);
    }];
}

@end
