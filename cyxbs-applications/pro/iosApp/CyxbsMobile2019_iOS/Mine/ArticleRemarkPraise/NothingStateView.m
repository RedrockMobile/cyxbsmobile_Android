//
//  NothingStateView.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/3/3.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "NothingStateView.h"

@interface NothingStateView ()
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *nothingLabel;
@end

@implementation NothingStateView
- (instancetype)initWithTitleStr:(NSString *)str
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(SCREEN_WIDTH*0.231, MAIN_SCREEN_W*0.5, MAIN_SCREEN_W*0.53867, MAIN_SCREEN_W*0.38934);
        [self addBackgroundViewWithStr:str];
    }
    return self;
}

/// 添加一个背景图片和一个label
- (void)addBackgroundViewWithStr:(NSString*)str{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"寂静"]];
    self.imgView = imgView;
    [self addSubview:imgView];
    
    [imgView setFrame:CGRectMake(0, 0, MAIN_SCREEN_W*0.53867, MAIN_SCREEN_W*0.34667)];
    
    UILabel *label = [[UILabel alloc] init];
    self.nothingLabel = label;
    [self addSubview:label];
    
    label.text = str;
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C53" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFEF" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:17/255.0 green:44/255.0 blue:84/255.0 alpha:1];
    }
    label.font = [UIFont fontWithName:PingFangSCLight size: 12];
    
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFrame:CGRectMake(0, MAIN_SCREEN_W*0.43667, MAIN_SCREEN_W*0.53867, 0.04267*MAIN_SCREEN_W)];
}

@end
