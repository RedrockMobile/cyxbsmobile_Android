//
//  FeedBackQuestionButton.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/3/30.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "FeedBackQuestionButton.h"

#pragma mark - FeedBackQuestionButton

@implementation FeedBackQuestionButton

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    [self setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
    //边框
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 15;
    self.layer.borderWidth = 1;
    self.layer.borderColor = UIColor.grayColor.CGColor;
}

#pragma mark - Method

- (void)setNormalStyle {
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = UIColor.grayColor.CGColor;
    [self setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
}

- (void)setHighLightStyle {
    self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E7E6FA" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2C5A" alpha:1]];
    self.layer.borderColor = UIColor.orangeColor.CGColor;
    [self setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
}

@end
