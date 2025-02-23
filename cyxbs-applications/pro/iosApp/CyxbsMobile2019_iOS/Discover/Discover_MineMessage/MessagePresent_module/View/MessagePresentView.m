//
//  MessagePresentView.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/23.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "MessagePresentView.h"

typedef void(^TapCancelBlock)(BOOL);

#pragma mark - MessagePresentView ()

@interface MessagePresentView ()

/// 字段总的一个view
@property (nonatomic, strong) UIView *msgView;

/// 标题段
@property (nonatomic, strong) UILabel *titleLab;

/// 细节段
@property (nonatomic, strong) UILabel *detailLab;

/// 取消按钮
@property (nonatomic, strong) UIButton *cancelBtn;

/// 确定按钮
@property (nonatomic, strong) UIButton *okBtn;

/// 回掉block
@property (nonatomic, copy) TapCancelBlock cancelBlock;

@end

#pragma mark - MessagePresentView

@implementation MessagePresentView

#pragma mark - Life cycle

- (instancetype)init {
    self = [self initWithFrame:CGRectMake(0, 0, 255, 146)];
    self.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 15;
        self.clipsToBounds = YES;
        
        self.backgroundColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2C2C2C" alpha:1]];
        
        [self addSubview:self.cancelBtn];
        [self addSubview:self.okBtn];
        [self addSubview:self.msgView];
    }
    return self;
}

#pragma mark - Method

- (void)drawRect:(CGRect)rect {
    self.cancelBtn.bottom = self.SuperBottom - 35;
    self.okBtn.bottom = self.cancelBtn.bottom;
    [self.msgView stretchBottom_toPointY:self.cancelBtn.top offset:5];
    
    self.titleLab.bottom = self.msgView.SuperCenter.y;
    self.detailLab.top = self.titleLab.bottom;
}

- (void)addTitleStr:(NSString *)title color:(UIColor *)titleColor {
    if (_titleLab == nil) {
        [self.msgView addSubview:self.titleLab];
        self.titleLab.center = self.msgView.SuperCenter;
    }
    if (_detailLab) {
        self.height += 21;
        [self sizeToFit];
    }
    self.titleLab.text = title;
    self.titleLab.textColor = titleColor;
}

- (void)addDetailStr:(NSString *)detail {
    if (_detailLab == nil) {
        [self.msgView addSubview:self.detailLab];
        self.detailLab.center = self.msgView.SuperCenter;
    }
    if (_titleLab) {
        self.height += 21;
        [self sizeToFit];
    }
    self.detailLab.text = detail;
}

- (void)tapButton:(void (^)(BOOL))tapCancel {
    if (tapCancel) {
        self.cancelBlock = tapCancel;
    }
}

// MARK: SEL

- (void)selectedCancel:(UIButton *)btn {
    if (self.cancelBlock) {
        BOOL isCancel = (btn == self.cancelBtn);
        self.cancelBlock(isCancel);
    }
}

#pragma mark - Getter

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 93, 34)];
        _cancelBtn.left = self.width * 0.1;
        _cancelBtn.bottom = self.SuperBottom - 35;
        
        _cancelBtn.layer.cornerRadius = _cancelBtn.height / 2;
        
        _cancelBtn.backgroundColor =
        [UIColor dm_colorWithLightColor:[UIColor xFF_R:195 G:212 B:238 Alpha:1] darkColor:[UIColor xFF_R:90 G:90 B:90 Alpha:1]];
        
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        
        [_cancelBtn addTarget:self action:@selector(selectedCancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)okBtn {
    if (_okBtn == nil) {
        _okBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 93, 34)];
        _okBtn.right = self.SuperRight - self.width * 0.1;
        _okBtn.bottom = self.cancelBtn.bottom;
        
        _okBtn.layer.cornerRadius = _okBtn.height / 2;
        _okBtn.backgroundColor = [UIColor xFF_R:74 G:68 B:228 Alpha:1];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(selectedCancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}

- (UIView *)msgView {
    if (_msgView == nil) {
        _msgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - self.cancelBtn.top + 5)];
        _msgView.backgroundColor = UIColor.clearColor;
    }
    return _msgView;
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 19)];
        _titleLab.font = [UIFont fontWithName:PingFangSC size:14];
        
        _titleLab.textColor =
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
        
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)detailLab {
    if (_detailLab == nil) {
        _detailLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 19)];
        _detailLab.font = [UIFont fontWithName:PingFangSC size:14];
        
        _detailLab.textColor = 
        [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C54" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
        
        _detailLab.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLab;
}

@end
