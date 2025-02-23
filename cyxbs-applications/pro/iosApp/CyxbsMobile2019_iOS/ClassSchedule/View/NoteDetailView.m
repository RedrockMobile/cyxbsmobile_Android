//
//  NoteDetailView.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/21.
//  Copyright © 2020 Redrock. All rights reserved.
//显示备忘详情的弹窗view

#import "NoteDetailView.h"

@interface NoteDetailView ()

/// 备忘标题
@property (nonatomic,strong)UILabel *noteTitleLabel;

/// 删除备忘按钮
@property (nonatomic,strong)UIButton *deleteBtn;

/// 编辑备忘按钮
@property (nonatomic,strong)UIButton *editBtn;

/// 备忘详情label
@property (nonatomic,strong)UILabel *detailLabel;

/// 显示@“第九周、第十三周、十八周的\n\n周一 五六节课、周四 三四节课”的备忘时间label
@property (nonatomic,strong)UILabel *weekTextsLabel;
@end

@implementation NoteDetailView
//MARK:-重写的方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addNoteTitleLabel];
        [self addDeleteBtn];
        [self addEditBtn];
        [self addWeekTextsLabel];
        [self addDetailLabel];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/// 重写self.dataModel的set方法，对dataModel赋值，自动设置内部label显示的文本
/// @param dataModel 备忘模型
- (void)setDataModel:(NoteDataModel *)dataModel{
    _dataModel = dataModel;
    
    //设置内部label显示的文本
    self.noteTitleLabel.text = dataModel.noteTitleStr;
    self.detailLabel.text = dataModel.noteDetailStr;
    
    //str1是@“第一周、第五周” @“第九周、第十三周、十八周”
    NSString *str1 = [dataModel.weeksStrArray firstObject];
    int i,count = (int)dataModel.weeksStrArray.count;
    for (i=1; i<count; i++) {
        str1 = [NSString stringWithFormat:@"%@、%@",str1,dataModel.weeksStrArray[i]];
    }
    
    //weekStr是@“周一”、@“周日”，lessonStr是@“一二节课”、@“五六节课”
    //str2是@“周一 五六节课、周四 三四节课”
    NSString *weekStr,*lessonStr,*str2;
    weekStr = [dataModel.timeStrDictArray firstObject][@"weekString"];
    lessonStr = [dataModel.timeStrDictArray firstObject][@"lessonString"];
    str2 = [NSString stringWithFormat:@"%@ %@",weekStr,lessonStr];
    count = (int)dataModel.timeStrDictArray.count;
    for (i=1; i<count; i++) {
        weekStr = dataModel.timeStrDictArray[i][@"weekString"];
        lessonStr = dataModel.timeStrDictArray[i][@"lessonString"];
        str2 = [NSString stringWithFormat:@"%@、%@ %@",str2,weekStr,lessonStr];
    }
    //最后组合出的是@“第九周、第十三周、十八周的\n\n周一 五六节课、周四 三四节课”
    self.weekTextsLabel.text = [NSString stringWithFormat:@"%@的\n\n%@",str1,str2];
}

//MARK:-添加子控件的方法
/// 添加备忘标题标题label
- (void)addNoteTitleLabel{
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    self.noteTitleLabel = label;
    
    
    label.font = [UIFont fontWithName:PingFangSCSemibold size:22];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    
    
    [self.noteTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0.04*MAIN_SCREEN_W);
        make.top.equalTo(self).offset(0.0246*MAIN_SCREEN_W);
    }];
}

/// 添加删除备忘按钮
- (void)addDeleteBtn{
    UIButton *btn = [self getBtn];
    self.deleteBtn = btn;
    [self addSubview:btn];
    
    if (@available(iOS 11.0, *)) {
        btn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E7EEFA" alpha:1] darkColor:[UIColor colorWithHexString:@"#2C2D2E" alpha:1]];
        [btn setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#82A6DA" alpha:1] darkColor:[UIColor colorWithHexString:@"#E7EEFA" alpha:1]] forState:UIControlStateNormal];
    } else {
        btn.backgroundColor = [UIColor colorWithRed:230/255.0 green:240/255.0 blue:252/255.0 alpha:1];
        [btn setTitleColor:[UIColor colorWithRed:130/255.0 green:166/255.0 blue:218/255.0 alpha:1] forState:UIControlStateNormal];
    }
    [btn setTitle:@"删除" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MAIN_SCREEN_W*0.6133);
        make.top.equalTo(self).offset(0.0295*MAIN_SCREEN_H);
    }];
}

/// 添加编辑备忘按钮
- (void)addEditBtn{
    UIButton *btn = [self getBtn];
    self.editBtn = btn;
    [self addSubview:btn];
    
    if (@available(iOS 11.0, *)) {
        btn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#453DD9" alpha:1] darkColor:[UIColor colorWithHexString:@"#495CF5" alpha:1]];
        [btn setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#D9EFFA" alpha:1]] forState:UIControlStateNormal];
    } else {
        btn.backgroundColor = [UIColor colorWithRed:69/255.0 green:62/255.0 blue:217/255.0 alpha:1];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [btn setTitle:@"修改" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(editBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MAIN_SCREEN_W*0.8026);
        make.top.equalTo(self).offset(0.0295*MAIN_SCREEN_H);
    }];
}

/// 添加备忘时间label
- (void)addWeekTextsLabel{
    UILabel *label = [[UILabel alloc] init];
    self.weekTextsLabel = label;
    [self addSubview:label];
    
    label.backgroundColor = [UIColor clearColor];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    label.font = [UIFont fontWithName:PingFangSCRegular size: 13];
    label.numberOfLines = 0;
    label.alpha = 0.6;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0.04*MAIN_SCREEN_W);
        make.right.equalTo(self).offset(-0.04*MAIN_SCREEN_W);
        make.top.equalTo(self).offset(MAIN_SCREEN_H*0.08);
    }];
}

/// 添加备忘详情label
- (void)addDetailLabel{
    UILabel *label = [[UILabel alloc] init];
    self.detailLabel = label;
    [self addSubview:label];
    
    label.backgroundColor = [UIColor clearColor];
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    label.font = [UIFont fontWithName:PingFangSCMedium size: 15];
    label.numberOfLines = 0;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0.04*MAIN_SCREEN_W);
        make.right.equalTo(self).offset(-0.04*MAIN_SCREEN_W);
        make.top.equalTo(self.weekTextsLabel.mas_bottom).offset(10);
    }];
}

//MARK:-点击某按钮后调用的方法

/// 点击删除按钮后调用
- (void)deleteBtnClicked{
    //调用代理方法，移走弹窗，代理是ClassDetailViewShower
    [self.hideDetailDelegate hideDetail];
    
    //发送通知，让WYCClassBookViewController调用WYCClassAndRemindDataModel的
    //方法删除备忘然后再重载self.scrollview的所有view
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldDeleteNote" object:self.dataModel];
    
}

/// 点击编辑按钮后调用
- (void)editBtnClicked{
    //调用代理方法，移走弹窗，代理是ClassDetailViewShower
    [self.hideDetailDelegate hideDetail];
    
    //发送通知，让WYCClassBookViewController调用WYCClassAndRemindDataModel的方法
    //弹窗备忘控制器
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DLReminderSetTimeVCShouldEditNote" object:self.dataModel];
    
}

//MARK:-其他方法
/// 获得一个圆角、titleLabel间距、font、文本对其方式、宽高和编辑按钮、删除按钮一样的按钮
- (UIButton*)getBtn{
    UIButton *btn = [[UIButton alloc] init];
    
    btn.layer.cornerRadius = 0.04265*MAIN_SCREEN_W;
    
    [btn.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn).offset(MAIN_SCREEN_W*0.033);
        make.right.equalTo(btn).offset(-MAIN_SCREEN_W*0.033);
    }];
    
    btn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size:15];
    [btn.titleLabel setTextAlignment:(NSTextAlignmentCenter)];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.1546*MAIN_SCREEN_W);
        make.height.mas_equalTo(0.0853*MAIN_SCREEN_W);
    }];
    
    return btn;
}
@end
