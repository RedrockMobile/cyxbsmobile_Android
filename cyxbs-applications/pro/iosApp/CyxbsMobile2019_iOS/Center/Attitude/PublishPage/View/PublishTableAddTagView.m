//
//  PublishTableAddTagView.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/21.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "PublishTableAddTagView.h"
@interface PublishTableAddTagView()

@property (nonatomic, strong) UILabel *label;

@end

@implementation PublishTableAddTagView
- (instancetype)initWithView {
    if (self) {
        self = [super init];
        [self addSubview:self.btn];
        [self addSubview:self.label];
        [self addSubview:self.okEditBtn];
        [self setPosition];
    }
    return self;
}

- (void)setPosition {
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(12);
        make.left.equalTo(self).mas_offset(26);
        make.width.equalTo(@16);
        make.height.equalTo(@16);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(9);
        make.left.equalTo(self.btn.mas_right).mas_offset(20);
        make.width.equalTo(@66);
        make.height.equalTo(@22);
    }];
    
    [self.okEditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.label.mas_bottom).mas_offset(18);
        make.width.equalTo(@130);
        make.height.equalTo(@40);
    }];
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor colorWithHexString:@"#4A44E4"];
        _label.numberOfLines = 0;
        _label.font = [UIFont fontWithName:PingFangSC size:16];
        _label.text = @"添加选项";
    }
    return _label;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] init];
        [_btn setImage:[UIImage imageNamed:@"Publish_addTagBtn"] forState:UIControlStateNormal];
        
    }
    return _btn;
}

- (UIButton *)okEditBtn {
    if (!_okEditBtn) {
        _okEditBtn = [[UIButton alloc] init];
        [_okEditBtn setTitle:@"完成编辑" forState:UIControlStateNormal];
        _okEditBtn.titleLabel.font = [UIFont fontWithName:PingFangSC size:18];
        _okEditBtn.backgroundColor = [UIColor colorWithHexString:@"#5D5DF7"];
        [_okEditBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _okEditBtn.layer.cornerRadius = 20;
    }
    return _okEditBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
