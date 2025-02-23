//
//  HistoricalFBDefaultView.m
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/9/2.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "HistoricalFBDefaultView.h"

@implementation HistoricalFBDefaultView

- (void)configureView {
    [super configureView];
    CGFloat space0 = (16.f / 812) * SCREEN_HEIGHT; // V:[self]-space0-[img]-space0-[label]
    
    [self.tipImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(space0);
    }];
    
    [self.tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.tipImgView.mas_bottom).offset(space0);
    }];
}

@end
