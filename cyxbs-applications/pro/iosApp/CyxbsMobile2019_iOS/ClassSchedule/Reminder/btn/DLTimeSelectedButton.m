//
//  DLTimeSelectedButton.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DLTimeSelectedButton.h"


#define kRateX [UIScreen mainScreen].bounds.size.width/375   //以iPhoneX为基准
@interface DLTimeSelectedButton ()
@property (nonatomic, strong)UIButton *deleteBtn;
@end

@implementation DLTimeSelectedButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:15];
        self.layer.masksToBounds = NO;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(MAIN_SCREEN_W*0.03467);
            make.right.equalTo(self).offset(-MAIN_SCREEN_W*0.04267);
        }];
        [self addDeleteBtn];
    }
    return self;
}


- (void)addDeleteBtn{
    UIButton *btn = [[UIButton alloc] init];
    [self addSubview:btn];
    self.deleteBtn = btn;
    [btn setBackgroundImage:[UIImage imageNamed:@"reminderDeleteImage"] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 8.5*kRateX;
    [btn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(17*kRateX);
        make.height.mas_equalTo(17*kRateX);
    }];
}

- (void)deleteBtnClicked{
    [self.delegate deleteButtonWithBtn:self];
}

@end
