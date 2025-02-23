//
//  SSRTopBarBaseView.m
//  SSRSwipe
//
//  Created by SSR on 2022/4/6.
//

#import "SSRTopBarBaseView.h"

#import "SSRButton.h"

#pragma mark - SSRTopBarBaseView ()

@interface SSRTopBarBaseView ()

/// 返回按钮
@property (nonatomic, strong) SSRButton *backBtn;

/// 标题Label
@property (nonatomic, strong, nullable) UILabel *titleLab;

/// 分割线
@property (nonatomic, strong) UIView *seperateLine;

@end

#pragma mark - SSRTopBarBaseView

@implementation SSRTopBarBaseView

#pragma mark - Init

- (instancetype)initWithSafeViewHeight:(CGFloat)height {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUSBARHEIGHT + height)];
    if (self) {
        [self addSubview:self.safeView]; {
            self.safeView.height = height;
            self.safeView.bottom = self.SuperBottom;
            
            [self.safeView addSubview:self.backBtn];
            self.backBtn.top = self.safeView.SuperTop + 5;
            
            self.hadLine = YES;
        }
    }
    return self;
}

#pragma mark - Method

- (void)addTitle:(NSString *)title
    withTitleLay:(SSRTopBarBaseViewTitleLabLay)titleLay
       withStyle:(void (^)(UILabel * _Nonnull))setTitleLab {
    // 如果以前有，那么就删掉
    if (_titleLab) {
        [self.titleLab removeFromSuperview];
        self.titleLab = nil;
    }
    // 先设置一个title，用于后面计算
    self.titleLab.text = title;
    // 先问block要，再去算
    if (setTitleLab) {
        setTitleLab(self.titleLab);
        title = self.titleLab.text;
    }
    // 算size，并确定最初布局
    CGSize size =
    [self.titleLab.text
     sizeWithAttributes:@{
        NSFontAttributeName : self.titleLab.font
    }];
    self.titleLab.size = size;
    self.titleLab.top = self.backBtn.top;
    // Lay
    switch (titleLay) {
        case SSRTopBarBaseViewTitleLabLayMiddle: {
            self.titleLab.center = self.safeView.SuperCenter;
            break;
        }
        case SSRTopBarBaseViewTitleLabLayLeft: {
            self.titleLab.left = self.backBtn.right + 10;
            break;
        }
    }
    
    [self.safeView addSubview:self.titleLab];
}

- (void)addBackButtonTarget:(id)target action:(SEL)action {
    [self.backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)addSwithLineWithOrigin:(CGPoint)origin {
    if (_swithLine == nil) {
        UIImageView *_switchbar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 62, 3)];
        _switchbar.image = [UIImage imageNamed:@"switchbar"];
        UIImageView *swithimage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 3)];
        swithimage1.image = [UIImage imageNamed:@"switchimage1"];
        [_switchbar addSubview:swithimage1];
        
        UIImageView *_swithPoint = [[UIImageView alloc]initWithFrame:CGRectMake(_switchbar.right + 3, 0, 3, 3)];
        _swithPoint.image = [UIImage imageNamed:@"swithPoint"];
        
        _swithLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 69, 3)];
        [_swithLine addSubview:_switchbar];
        [_swithLine addSubview:_swithPoint];
        
        [self.safeView addSubview:_swithLine];
    }
    _swithLine.origin = origin;
}

#pragma mark - Getter

- (UIView *)safeView {
    if (_safeView == nil) {
        // 高和顶部由父控件确定
        _safeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    return _safeView;
}

- (SSRButton *)backBtn {
    if (_backBtn == nil) {
        _backBtn = [[SSRButton alloc] initWithFrame:CGRectMake(10, 0, 20, 30)];
        _backBtn.expandHitEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        [_backBtn setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
        _backBtn.backgroundColor = [UIColor clearColor];
    }
    return _backBtn;
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont fontWithName:PingFangSCSemibold size:22];
        _titleLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    }
    return _titleLab;
}

- (UIView *)seperateLine {
    if (_seperateLine == nil) {
        _seperateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.safeView.width, 2)];
        _seperateLine.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#BDCCE5" alpha:0.3] darkColor:[UIColor colorWithHexString:@"#676767" alpha:0.1]];
    }
    return _seperateLine;
}

#pragma mark - Setter

- (void)shouldHaveLine:(BOOL)hadLine {
    if (_hadLine == hadLine) {
        return;
    }
    _hadLine = hadLine;
    if (_hadLine) {
        [self.safeView addSubview:self.seperateLine];
        self.seperateLine.bottom = self.safeView.SuperBottom;
    } else {
        [self.seperateLine removeFromSuperview];
    }
}

@end
