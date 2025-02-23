//
//  EditMyInfoContentView.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/11/14.
//  Modified by Edioth on 2021/10/12
//  Copyright © 2019 Redrock. All rights reserved.
//

#import "EditMyInfoContentView.h"
#import "RemindHUD.h"

#define LABELCOLOR [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1]

#define LABELFONT [UIFont fontWithName:PingFangSCSemibold size:15]
#define PLACEHOLDERFONT [UIFont fontWithName:PingFangSCRegular size:15]

/**
 @property (nonatomic, weak) UIImageView *headerImageView;
 @property (nonatomic, weak) MineEditTextField *nicknameTextField;
 @property (nonatomic, weak) MineEditTextField *introductionTextField;
 @property (nonatomic, weak) MineEditTextField *QQTextField;
 @property (nonatomic, weak) MineEditTextField *phoneNumberTextField;
 @property (nonatomic, weak) UIButton *myAcademyLabel;
 
 @property (nonatomic, weak) UIButton *saveButton;
 */

@interface EditMyInfoContentView () <
UITextFieldDelegate
>

@property (nonatomic, weak) UIButton *introductionButton;
@property (nonatomic, weak) UILabel *realNameLabel;
@property (nonatomic, weak) UILabel *stuNumLabel;
@property (nonatomic, weak) UILabel *genderLabel;
@property (nonatomic, weak) UILabel *collegeLabel;
@property (nonatomic, weak) UILabel *academyLabel;

@end

@implementation EditMyInfoContentView

#pragma mark - 添加子控件
- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addContentScrollView];
    }
    return self;
}

- (void)addContentScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor =
    [UIColor dm_colorWithLightColor:UIColor.whiteColor darkColor:UIColor.blackColor];
    self.contentScrollView = scrollView;
    [self addHeaderImageView];
    [self addIntroductionButton];
    [self addRealNameLabel];
    [self addRealNameDetailLabel];
    [self addStuNumLabel];
    [self addStuNumDetailLabel];
    [self addGenderLabel];
    [self addGenderDetailLabel];
    [self addCollegeLabel];
    [self addCollegeDetailLabel];
}

- (void)addHeaderImageView {
    UIImageView *headerImageView = [[UIImageView alloc] init];
    [self.contentScrollView addSubview:headerImageView];
    self.headerImageView = headerImageView;
    NSString *headImgUrl_str = [UserItemTool defaultItem].headImgUrl;
    NSURL *headImageUrl = [NSURL URLWithString:headImgUrl_str];
    [headerImageView sd_setImageWithURL:headImageUrl placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageFromCacheOnly context:nil progress:nil completed:nil];
    headerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageTapped:)];
    [headerImageView addGestureRecognizer:tap];
}

- (void)addIntroductionButton{
    UIButton *introductionButton = [[UIButton alloc] init];
    [introductionButton setImage:[UIImage imageNamed:@"编辑资料的点"] forState:UIControlStateNormal];
    [introductionButton addTarget:self action:@selector(showUserInformationIntroduction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollView addSubview:introductionButton];
    self.introductionButton = introductionButton;
}

- (void)addRealNameLabel{
    UILabel *realNameLabel = [[UILabel alloc] init];
    realNameLabel.text = @"姓名";
    
    realNameLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    
    realNameLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentScrollView addSubview:realNameLabel];
    self.realNameLabel = realNameLabel;
}

- (void)addRealNameDetailLabel{
    MineInformationLabel *realNameTextField = [[MineInformationLabel alloc] init];
    [self.contentScrollView addSubview:realNameTextField];
    self.realNameDetailLabel = realNameTextField;
    realNameTextField.text = [UserItemTool defaultItem].realName;
}

- (void)addStuNumLabel{
    UILabel *stuNumLabel = [[UILabel alloc] init];
    stuNumLabel.text = @"学号";
    stuNumLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    stuNumLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentScrollView addSubview:stuNumLabel];
    self.stuNumLabel = stuNumLabel;
}

- (void)addStuNumDetailLabel{
    MineInformationLabel *stuNumDetailLabel = [[MineInformationLabel alloc] init];
    [self.contentScrollView addSubview:stuNumDetailLabel];
    self.stuNumDetailLabel = stuNumDetailLabel;
    stuNumDetailLabel.text = [UserItemTool defaultItem].stuNum;
}

/// 性别

- (void)addGenderLabel {
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.text = @"性别";
    genderLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    genderLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentScrollView addSubview:genderLabel];
    self.genderLabel = genderLabel;
}

- (void)addGenderDetailLabel {
    MineInformationLabel *genderDetailLabel = [[MineInformationLabel alloc] init];
    [self.contentScrollView addSubview:genderDetailLabel];
    self.genderDetailLabel = genderDetailLabel;
    genderDetailLabel.text = [UserItemTool defaultItem].gender;
}

///学院

- (void)addCollegeLabel {
    UILabel *collegeLabel = [[UILabel alloc] init];
    collegeLabel.text = @"学院";
    collegeLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    collegeLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentScrollView addSubview:collegeLabel];
    self.collegeLabel = collegeLabel;
}

- (void)addCollegeDetailLabel {
    MineInformationLabel *collegeDetailLabel = [[MineInformationLabel alloc] init];
    [self.contentScrollView addSubview:collegeDetailLabel];
    self.collegeDetailLabel = collegeDetailLabel;
    self.collegeDetailLabel.text = [UserItemTool defaultItem].college;
    
}

#pragma mark - 添加约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentScrollView).offset(64);
        make.leading.equalTo(self.contentScrollView).offset(32);
        make.height.width.equalTo(self.mas_width).multipliedBy(0.19);
    }];
    self.headerImageView.clipsToBounds = YES;
    self.headerImageView.layer.cornerRadius = self.width * 0.19 * 0.5;
    
    [self.introductionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerImageView);
        make.trailing.equalTo(self).offset(-59);
        make.height.width.equalTo(@20);
    }];
    
    [self.realNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(32);
        make.top.equalTo(self.headerImageView.mas_bottom).offset(34);
    }];
    
    [self.realNameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.realNameLabel);
        make.trailing.equalTo(self).offset(-32);
        make.top.equalTo(self.realNameLabel.mas_bottom).offset(3);
        make.height.equalTo(@45);
    }];
    
    [self.stuNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.realNameLabel);
        make.top.equalTo(self.realNameDetailLabel.mas_bottom).offset(20);
    }];
    
    [self.stuNumDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.realNameLabel);
        make.trailing.equalTo(self).offset(-32);
        make.top.equalTo(self.stuNumLabel.mas_bottom).offset(3);
        make.height.equalTo(@45);
    }];
    
    [self.genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.realNameLabel);
        make.top.mas_equalTo(self.stuNumDetailLabel.mas_bottom).offset(20);
    }];
    
    [self.genderDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.realNameLabel);
        make.trailing.equalTo(self).offset(-32);
        make.top.equalTo(self.genderLabel.mas_bottom).offset(3);
        make.height.equalTo(@45);
    }];
    
    [self.collegeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.realNameLabel);
        make.top.mas_equalTo(self.genderDetailLabel.mas_bottom).offset(20);
    }];
    
    [self.collegeDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.realNameLabel);
        make.trailing.equalTo(self).offset(-32);
        make.top.equalTo(self.collegeLabel.mas_bottom).offset(3);
        make.height.equalTo(@45);
    }];
    
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.height.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
}

#pragma mark - 按钮调用
- (void)headerImageTapped:(UIImageView *)sender {
    if ([self.delegate respondsToSelector:@selector(headerImageTapped:)]) {
        [self.delegate headerImageTapped:sender];
    }
}

- (void)showUserInformationIntroduction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(showUserInformationIntroduction:)]) {
        [self.delegate showUserInformationIntroduction:sender];
    }
}


@end
