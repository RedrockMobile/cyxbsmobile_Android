//
//  HintView.m
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/24.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "HintView.h"

@implementation HintView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.hintLbl];
        [self addSubview:self.qqGroupLbl];
    }
    return self;
}
- (UILabel *)hintLbl{
    if (!_hintLbl) {
        _hintLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 15)];
        _hintLbl.textColor = [UIColor colorWithHexString:@"#ABBBDA"];
        _hintLbl.font = [UIFont fontWithName:PingFangSCMedium size:11];
        _hintLbl.text = @"实时反馈可添加QQ反馈群：";
    }
    return _hintLbl;
}
- (UILabel *)qqGroupLbl{
    if (!_qqGroupLbl) {
        _qqGroupLbl = [[UILabel alloc]initWithFrame:CGRectMake(140, 0, 62, 15)];
        _qqGroupLbl.textColor = [UIColor colorWithHexString:@"#0BCCF0"];
        _qqGroupLbl.font = [UIFont fontWithName:PingFangSCMedium size:11];
        _qqGroupLbl.text = @"570919844";
    }
    return _qqGroupLbl;
}
@end
