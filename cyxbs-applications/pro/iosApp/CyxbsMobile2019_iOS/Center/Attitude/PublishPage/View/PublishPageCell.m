//
//  PublishPageCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "PublishPageCell.h"

@implementation PublishPageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.deleteBtn];
        [self.contentView addSubview:self.backView];
        [self.contentView addSubview:self.tagLabel];
        [self setPosition];
    }
    return self;
}

- (UILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.font = [UIFont fontWithName:PingFangSC size:14];
        _tagLabel.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.5];
    }
    return _tagLabel;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithHexString:@"#E8F1FC"];
        // 圆角，暂定15
        _backView.layer.cornerRadius = 15;
    }
    return _backView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn setImage:[UIImage imageNamed:@"Publish_deleteBtn"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (void)setPosition {
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(26);
        make.width.equalTo(@16);
        make.height.equalTo(@16);
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.deleteBtn.mas_right).mas_offset(20);
        make.width.equalTo(@257);
        make.height.equalTo(@34);
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.backView).mas_offset(23);
        make.width.equalTo(@211);
        make.height.equalTo(@20);
    }];
}

- (void)pressBtn {
    [self.delegate tableViewCellPressDeleteCell:self];
}


@end
