//
//  FakeTabBarView.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/25.
//  Copyright © 2020 Redrock. All rights reserved.
//课表顶部一个长得和显示课信息的tabBar一模一样的bar，用来制造底部bar随课表拖动的假象

#import "FakeTabBarView.h"
@interface FakeTabBarView()
//用来遮圆角的
@property (nonatomic, weak) UIView *bottomCoverView;

/// 可拖拽提示条
@property (nonatomic, weak) UIView *dragHintView;

@end
@implementation FakeTabBarView
//MARK:-重写的方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
               } else {
                  self.backgroundColor = [UIColor whiteColor];
               }
        
        self.layer.shadowOffset = CGSizeMake(0, -5);
        self.layer.shadowOpacity = 0.1;
        
        // 遮住下面两个圆角
        UIView *bottomCoverView = [[UIView alloc] init];
        bottomCoverView.backgroundColor = self.backgroundColor;
        [self addSubview:bottomCoverView];
        self.bottomCoverView = bottomCoverView;
        
        UIView *dragHintView = [[UIView alloc] init];
        
        if (@available(iOS 11.0, *)) {
            dragHintView.backgroundColor =[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E2EDFB" alpha:1] darkColor:[UIColor colorWithHexString:@"#010101" alpha:1]];
        } else {
            // Fallback on earlier versions
            dragHintView.backgroundColor = [UIColor whiteColor];
        }
        dragHintView.layer.cornerRadius = 2.5;
        [self addSubview:dragHintView];
        self.dragHintView = dragHintView;
        
        
        FYHCycleLabel *classLabel = [[FYHCycleLabel alloc] initWithFrame:CGRectMake(10, 10, 0.3*MAIN_SCREEN_W, 50)];
        classLabel.cycleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:22];
        classLabel.cycleLabel.textColor = [UIColor blackColor];
        [self addSubview:classLabel];
        self.classLabel = classLabel;
        
        
        UIImageView *clockImageView = [[UIImageView alloc] init];
        [clockImageView setImage:[UIImage imageNamed:@"nowClassTime"]];
        [self addSubview:clockImageView];
        self.clockImageView = clockImageView;
        
        
        FYHCycleLabel *classTimeLabel = [[FYHCycleLabel alloc] initWithFrame:CGRectMake(10, 10, 0.2*MAIN_SCREEN_W, 50)];
        classTimeLabel.cycleLabel.font = [UIFont fontWithName:PingFangSCLight size:12];
        [self addSubview:classTimeLabel];
        self.classTimeLabel = classTimeLabel;
        
        
        UIImageView *locationImageView = [[UIImageView alloc] init];
        [locationImageView setImage:[UIImage imageNamed:@"nowLocation"]];
        [self addSubview:locationImageView];
        self.locationImageView = locationImageView;
        
        
        FYHCycleLabel *classroomLabel = [[FYHCycleLabel alloc] initWithFrame:CGRectMake(10, 10, 0.2*MAIN_SCREEN_W, 50)];
        classroomLabel.cycleLabel.font = [UIFont fontWithName:PingFangSCLight size:12];
        [self addSubview:classroomLabel];
        self.classroomLabel = classroomLabel;
        
        
        //统一改一下label字色
        if (@available(iOS 11.0, *)) {
            classTimeLabel.cycleLabel.textColor =
            classroomLabel.cycleLabel.textColor =
            classLabel.cycleLabel.textColor =
            [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
            classTimeLabel.cycleLabel.textColor =
            classroomLabel.cycleLabel.textColor =
            classLabel.cycleLabel.textColor =
            [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
        }
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.bottomCoverView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.equalTo(@16);
    }];
    
    [self.dragHintView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@27);
        make.height.equalTo(@5);
        make.top.equalTo(self).offset(8);
        make.centerX.equalTo(self);
    }];
    
    [self.classLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MAIN_SCREEN_W*0.0774);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(0.3*MAIN_SCREEN_W);
        make.height.mas_equalTo(0.12*MAIN_SCREEN_W);
    }];
    
    [self.clockImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MAIN_SCREEN_W*0.4054);
        make.centerY.equalTo(self.classLabel);
        make.height.width.equalTo(@11);
    }];
    
    [self.classTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MAIN_SCREEN_W*0.4554);
        make.centerY.equalTo(self.classLabel);
        make.width.mas_equalTo(0.1867*MAIN_SCREEN_W);
        make.height.mas_equalTo(0.12*MAIN_SCREEN_W);
    }];
    
    [self.locationImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MAIN_SCREEN_W*0.6694);
        make.centerY.equalTo(self.classLabel);
        make.height.width.equalTo(@11);
    }];
    
    [self.classroomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MAIN_SCREEN_W * 0.7214);
        make.centerY.equalTo(self.classLabel);
        make.width.mas_equalTo(0.224*MAIN_SCREEN_W);
        make.height.mas_equalTo(MAIN_SCREEN_W*0.12);
    }];
}

/// 课表的一个代理方法，用来更新下节课信息
/// @param paramDict 下节课的数据字典
- (void)updateSchedulTabBarViewWithDic:(NSDictionary *)paramDict{
    if(paramDict.count >1){
        if( [paramDict[@"is"] intValue] == 1){//有下一节课
            self.classroomLabel.labelText = paramDict[@"classroomLabel"];
            self.classTimeLabel.labelText = paramDict[@"classTimeLabel"];
            self.classLabel.labelText = paramDict[@"classLabel"];
        }else{//无下一节课
            self.classroomLabel.labelText = @"---";
            self.classTimeLabel.labelText = @"---";
            self.classLabel.labelText = @"无课了";
        }
    }else{
        self.classroomLabel.labelText = @"无网了";
        self.classTimeLabel.labelText = @"无网了";
        self.classLabel.labelText = @"联网才能使用";
    }
}

@end
