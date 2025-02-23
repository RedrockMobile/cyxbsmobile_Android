//
//  PeopleListTableViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/7/30.
//  Copyright © 2020 Redrock. All rights reserved.
//tableView的每一行的cell都是这个类，通过初始化的方法决定这个cell是add型还是delete型

#import "PeopleListTableViewCell.h"

@interface PeopleListTableViewCell ()
/**显示名字的大标题*/
@property (nonatomic ,strong)UILabel *nameLabel;
/**显示学号的小标题*/
@property (nonatomic, strong)UILabel *stuNumLabel;
/**储存对应的学生信息*/
@property (nonatomic, strong)NSDictionary *infoDict;
@end

@implementation PeopleListTableViewCell

- (instancetype)initWithInfoDict:(NSDictionary*)infoDict andRightBtnType:(PeopleListTableViewCellRightBtnType)type{
    self = [super init];
    if(self){
        self.infoDict = infoDict;
        [self addNameLabel];
        
        [self addStuNumLabel];
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        if(type==PeopleListTableViewCellRightBtnTypeAdd){
            [self addAddBtn];
        }else{
            [self addDeleteBtn];
        }
    }
    return self;
}

//MARK: -初始化子控件的方法：
//添加显示姓名的大标题
- (void)addNameLabel{
    UILabel *label = [[UILabel alloc] init];
    [self.contentView addSubview:label];
    self.nameLabel = label;
    label.text =self.infoDict[@"name"];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    label.font = [UIFont fontWithName:PingFangSC size: 16];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(MAIN_SCREEN_H*0.0062);
        make.left.equalTo(self.contentView).offset(MAIN_SCREEN_W*0.0427);
        make.height.mas_equalTo(MAIN_SCREEN_H*0.0271);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
    }];
}

//添加显示学号的小标题
- (void)addStuNumLabel {
    UILabel *label = [[UILabel alloc] init];
    [self.contentView addSubview:label];
    self.stuNumLabel = label;
    label.text =self.infoDict[@"stuNum"];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    label.font = [UIFont fontWithName:PingFangSC size: 11];
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(MAIN_SCREEN_H*0.0062);
        make.left.equalTo(self.contentView).offset(MAIN_SCREEN_W*0.0427);
        make.height.mas_equalTo(MAIN_SCREEN_H*0.0197);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
    }];
    
}

//添加删除按钮
- (void)addDeleteBtn{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:@"草稿箱垃圾桶"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(MAIN_SCREEN_W*0.904);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(0.0533*MAIN_SCREEN_W);
        make.height.mas_equalTo(0.033424*MAIN_SCREEN_H);
    }];
}

//添加add按钮
- (void)addAddBtn{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(MAIN_SCREEN_W*0.904);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(0.0587*MAIN_SCREEN_W);
        make.height.mas_equalTo(0.0587*MAIN_SCREEN_W);
    }];
}


//MARK: - 点击某按钮后调用的方法：
//点击删除按钮后调用
- (void)deleteBtnClicked{
    [self.delegateDelete PeopleListTableViewCellDeleteBtnClickInfoDict:self.infoDict];
}

//点击add按钮后调用
- (void)addBtnClicked{
    [self.delegateAdd PeopleListTableViewCellAddBtnClickInfoDict:self.infoDict];
}

@end
