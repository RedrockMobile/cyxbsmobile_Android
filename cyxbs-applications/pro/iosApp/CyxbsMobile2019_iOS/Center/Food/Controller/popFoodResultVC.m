//
//  popFoodResultVC.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "popFoodResultVC.h"
#import "FoodPraiseModel.h"

@interface popFoodResultVC ()
///信息说明的contentView，他是一个button，用来保证点击空白处可以取消
@property (nonatomic, weak) UIButton *informationContentView;
@property (nonatomic, strong) UIButton *praiseBtn;
@property (nonatomic, strong) UILabel *praiseLab;//此处立一个flag:不可能有6位数的点赞,所以大小直接写死
/// 美食点赞模型
@property (nonatomic, strong) FoodPraiseModel *praiseModel;

@end

@implementation popFoodResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0];
    [self popInformation];
}

#pragma mark -弹出信息
- (void)popInformation {
    //添加灰色背景板
    UIButton *contentView = [[UIButton alloc] initWithFrame:self.view.frame];
    self.informationContentView = contentView;
    [self.view addSubview:contentView];
    contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    contentView.alpha = 0;

    [UIView animateWithDuration:0.3 animations:^{
        contentView.alpha = 1;
        self.tabBarController.tabBar.userInteractionEnabled = NO;
    }];
    [contentView addTarget:self action:@selector(cancelLearnAbout) forControlEvents:UIControlEventTouchUpInside];

    UIView *learnView = [[UIView alloc]init];
    //设置圆角
    learnView.layer.cornerRadius = 8;
    learnView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"美食背景"].CGImage);

    UIImageView *foodImgView = [[UIImageView alloc] init];
    if (!self.ImgURL) {
        foodImgView.image = [UIImage imageNamed:@"美食"];
    }else {
        [foodImgView sd_setImageWithURL:[NSURL URLWithString:self.ImgURL]];
    }
    foodImgView.layer.cornerRadius = 8;
    foodImgView.layer.masksToBounds = YES;

    UIImageView *praiseView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"美食点赞"]];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 83, 29) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, 83, 29);
    maskLayer.path = maskPath.CGPath;
    praiseView.layer.mask = maskLayer;
    praiseView.layer.masksToBounds = YES;

    self.praiseLab.text = [NSString stringWithFormat:@"%ld", (long)self.praiseNum];
    //标题
    UILabel *foodNameLab = [[UILabel alloc] init];
    foodNameLab.text = self.foodNameText;
    foodNameLab.font = [UIFont fontWithName:PingFangSCMedium size:18];
    foodNameLab.textColor = [UIColor colorWithHexString:@"#15315B" alpha:1];
    foodNameLab.frame = CGRectMake(0, 0, 0, 18);
    [foodNameLab sizeToFit];    //计算高度

    //内容
    UILabel *contentLab = [[UILabel alloc] init];
    contentLab.text = self.contentText;
    contentLab.font = [UIFont fontWithName:PingFangSCMedium size:14];
    contentLab.numberOfLines = 0;
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.5];
    contentLab.frame = CGRectMake(0, 0, 225, 0);
    [contentLab sizeToFit];    //计算高度

    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 93, 34)];
    //给控件加边框
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"#5D5DF7"].CGColor;
    cancelBtn.layer.cornerRadius = 16;
    cancelBtn.layer.masksToBounds = YES;
    [cancelBtn setTitle:@"取消" forState:normal];
    [cancelBtn setTitleColor:[UIColor colorWithHexString:@"#5C5CF6"] forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont fontWithName:PingFangSCSemibold size:14]];
    [cancelBtn addTarget:self action:@selector(cancelLearnAbout) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:learnView];
    [learnView addSubview:foodImgView];
    [foodImgView addSubview:praiseView];
    [learnView addSubview:foodNameLab];
    [learnView addSubview:contentLab];
    [learnView addSubview:cancelBtn];
    [learnView addSubview:self.praiseBtn];
    [praiseView addSubview:self.praiseLab];
    
    [learnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(60);
        make.right.equalTo(self.view).offset(-60);
        make.height.equalTo(@(293 + contentLab.size.height));
    }];
    
    [foodImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(learnView);
        make.top.equalTo(learnView).offset(35);
        make.height.equalTo(@125);
        make.width.equalTo(@193);
    }];
    
    [foodNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(learnView);
        make.top.equalTo(foodImgView.mas_bottom).offset(20);
    }];
    
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(learnView).offset(15);
        make.top.equalTo(foodNameLab.mas_bottom).offset(10);
        make.right.equalTo(learnView).offset(-15);
    }];
    
    [praiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(foodImgView);
        make.left.equalTo(foodImgView);
        make.height.equalTo(@29);
        make.width.equalTo(@83);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(learnView.mas_centerX).offset(-6);
        make.top.equalTo(contentLab.mas_bottom).offset(22);
        make.width.equalTo(@93);
        make.height.equalTo(@34);
    }];
    
    [_praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(learnView.mas_centerX).offset(6);
        make.top.equalTo(contentLab.mas_bottom).offset(22);
        make.width.equalTo(@93);
        make.height.equalTo(@34);
    }];
    
    [_praiseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(praiseView).offset(33);
        make.top.equalTo(praiseView).offset(2);
        make.width.equalTo(@47);
        make.height.equalTo(@25);
    }];
}

- (UIButton *)praiseBtn {
    if (!_praiseBtn) {
        _praiseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 93, 34)];
        _praiseBtn.layer.cornerRadius = 16;
        _praiseBtn.layer.masksToBounds = YES;

        [_praiseBtn setTitle:@"点赞" forState:normal];
        [_praiseBtn.titleLabel setFont:[UIFont fontWithName:PingFangSCSemibold size:14]];
        [_praiseBtn addTarget:self action:@selector(praiseFood) forControlEvents:UIControlEventTouchUpInside];
    }

    return _praiseBtn;
}

- (void)praiseFood {
    [self.praiseModel getName:self.foodNameText requestSuccess:^{
        if (self.praiseModel.status == 10000) {
            self.praiseNum = self.praiseModel.praise_num;
            self.isPraise = self.praiseModel.praise_is;
            self->_praiseBlock( self.praiseNum ,self.isPraise);
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"美食点赞失败");
    }];
}

- (void)cancelLearnAbout {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setFoodNameText:(NSString *)foodNameText {
    _foodNameText = foodNameText;
}

- (void)setContentText:(NSString *)contentText {
    _contentText = contentText;
}

- (void)setImgURL:(NSString *)ImgURL {
    _ImgURL = ImgURL;
}

- (void)setPraiseNum:(NSInteger)praiseNum {
    _praiseNum = praiseNum;
    self.praiseLab.text = [NSString stringWithFormat:@"%ld", (long)praiseNum];
}

- (void)setIsPraise:(BOOL)isPraise {
    _isPraise = isPraise;
    if (_isPraise) {
        self.praiseBtn.backgroundColor = [UIColor colorWithHexString:@"#C3D4EE"];
        [_praiseBtn removeAllTargets];
    } else {
        self.praiseBtn.backgroundColor = [UIColor colorWithHexString:@"#4A44E4"];
        [self.praiseBtn addTarget:self action:@selector(praiseFood) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UILabel *)praiseLab {
    if (!_praiseLab) {
        _praiseLab = [[UILabel alloc] init];
        _praiseLab.font = [UIFont fontWithName:PingFangSCMedium size:14];
        _praiseLab.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _praiseLab.textAlignment = NSTextAlignmentCenter;
    }
    return _praiseLab;
}

- (FoodPraiseModel *)praiseModel {
    if (!_praiseModel) {
        _praiseModel = [[FoodPraiseModel alloc] init];
    }
    return _praiseModel;
}

@end
